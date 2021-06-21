package top.tobing.platform.product.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.Caching;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import top.tobing.common.constant.LuaScript;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.Query;

import top.tobing.platform.product.dao.CategoryBrandRelationDao;
import top.tobing.platform.product.dao.CategoryDao;
import top.tobing.platform.product.entity.CategoryEntity;
import top.tobing.platform.product.service.CategoryService;
import top.tobing.platform.product.vo.Catalog2Vo;
import top.tobing.platform.product.vo.Catalog3Vo;

@Slf4j
@Service("categoryService")
public class CategoryServiceImpl extends ServiceImpl<CategoryDao, CategoryEntity> implements CategoryService {

    public static final String CATALOG_JSON_LOCK = "CATALOG_JSON_LOCK";

    @Autowired
    private CategoryBrandRelationDao categoryBrandRelationDao;
    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<CategoryEntity> page = this.page(
                new Query<CategoryEntity>().getPage(params),
                new QueryWrapper<CategoryEntity>()
        );
        page.getRecords().forEach(System.out::println);
        return new PageUtils(page);
    }

    public List<CategoryEntity> queryListByTreeWithDB() {

        return null;
    }


    @Cacheable("categoryEntity")
    @Override
    public List<CategoryEntity> queryListByTree() {
        log.info("查询数据库...");
        // 查询所有可见分类 showStatus = 1
        List<CategoryEntity> categoryEntityList = this.list(new QueryWrapper<CategoryEntity>().eq("show_status", '1'));
        // 查询出所有父类，即 parentCid = 0
        List<CategoryEntity> res = categoryEntityList.stream().filter(category -> {
            return category.getParentCid() == 0;
        }).collect(Collectors.toList());
        // 获取其子分类
        res.forEach(category -> {
            category.setChildren(queryChildren(categoryEntityList, category.getCatId()));
        });

        return res;
    }

    @Override
    public Long[] path(Long catelogId) {
        List<Long> list = new ArrayList<>();
        getPath(catelogId, list);
        return list.toArray(new Long[0]);
    }

    @Override
    @Transactional
    @Caching(evict = {
            @CacheEvict(value = "category", key = "'getCatalogJsonWithRedissonLock'"),
            @CacheEvict(value = "category", key = "'getLevel1Categories'"),
    })
//    @CacheEvict(value = "category", allEntries = true)
    public void updateCascade(CategoryEntity category) {
        this.updateById(category);
        categoryBrandRelationDao.updateCategoryNameByCategoryId(category.getCatId(), category.getName());
    }

    @Override
    @Cacheable(value = {"category"}, key = "#root.method.name")
    public List<CategoryEntity> getLevel1Categories() {
        List<CategoryEntity> categoryEntityList = this.list(new QueryWrapper<CategoryEntity>().eq("parent_cid", 0));
        return categoryEntityList;
    }


    /**
     * 利用Redisson结合SpringCache实现配置式添加分布式缓存
     * 1、@Cacheable 表明方法的结果需要缓存。如果缓存中有，方法不调用；如果缓存中没有会调用方法，最后将结果放入缓存中
     * 1.1）、value：表明这个缓存将会放到category命名空间中
     * 1.2）、key：表明这个这个缓存的key将使用「方法名」
     * 【默认】
     * 1、如果缓存中有方法不被调用
     * 2、key默认自动生成，「缓存名字::simpleKey[]（自主生成的key值）」
     * 3、默认ttl时间-1【建议在配置文件中统一修改过期时间，防止缓存穿透问题】
     * 4、缓存的value值默认采用JDK序列化机制，将序列化的数据放到redis中【建议在配置文件中配置json序列，有利于异构系统的开发，提高跨平台性】
     */
    @Override
    @Cacheable(value = {"category"}, key = "#root.method.name")
    public Map<String, List<Catalog2Vo>> getCatalogJsonWithRedissonLock() {
        // 没有缓存则直接从数据库中查询
        log.info("[CategoryServiceImpl]查询数据库");
        Map<String, List<Catalog2Vo>> catalogJsonFromDB = getCatalogJsonFromDB();
        return catalogJsonFromDB;
    }

    /**
     * 利用分布式锁实现缓存控制
     *
     * @return
     */
    public Map<String, List<Catalog2Vo>> getCatalogJsonWithRedisLock() {
        String uuid = UUID.randomUUID().toString();
        ValueOperations<String, String> ops = stringRedisTemplate.opsForValue();
        // 原子性设置分布式锁，同时设置值和过期时间
        Boolean success = ops.setIfAbsent(CATALOG_JSON_LOCK, uuid, 500, TimeUnit.SECONDS);
        // 获取锁不成功，等待100ms，自旋
        while (!success) {
            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            success = ops.setIfAbsent(CATALOG_JSON_LOCK, uuid, 500, TimeUnit.SECONDS);
        }
        // 获取锁成功，执行逻辑删除锁返回【只会有一个线程回去成功】
        String lock = ops.get(CATALOG_JSON_LOCK);
        // 执行Lua脚本，原子性删除锁，成功返回1，失败返回0
        String getCatalogJson = ops.get("getCatalogJsonWithRedisLock");
        if (StringUtils.isEmpty(getCatalogJson)) {
            Map<String, List<Catalog2Vo>> catalogJsonFromDB = getCatalogJsonFromDB();
            String json = JSON.toJSONString(catalogJsonFromDB);
            stringRedisTemplate.opsForValue().set("getCatalogJsonWithRedisLock", json);
            Long res = stringRedisTemplate.execute(new DefaultRedisScript<Long>(LuaScript.REDIS_ATOMIC_COMPARE_AND_DELETE, Long.class), Arrays.asList(CATALOG_JSON_LOCK), lock);
            return catalogJsonFromDB;
        }
        Long res = stringRedisTemplate.execute(new DefaultRedisScript<Long>(LuaScript.REDIS_ATOMIC_COMPARE_AND_DELETE, Long.class), Arrays.asList(CATALOG_JSON_LOCK), lock);
        return JSON.parseObject(getCatalogJson, new TypeReference<Map<String, List<Catalog2Vo>>>() {
        });
    }

    /**
     * 先去查询缓存、有则取出来，转换为对象返回，无则去数据库查询，并将结果放到缓存，返回。
     * 【缓存穿透】：需要注意如果查不到一个值，也要将这个值对应的key添加一个null值，避免缓存穿透问题。同时还要个值加上过期时间，避免出现其他问题。
     * 【缓存雪崩】：避免采用相同的失效时间，导致某个时刻内所有的数据同时失效，从而导致缓存雪崩。
     * 【缓存击穿】：对于热点数据，需要注意对数据库的查询加锁，避免该热点数据失效导致高并发同时打到数据库。
     * 加锁的时候，只让一个进程进入数据库查询，查询之后放到缓存中，其他线程只需要去缓存中查询即可。
     */
    public Map<String, List<Catalog2Vo>> getCatalogJsonWithLocalLock() {
        String getCatalogJson = stringRedisTemplate.opsForValue().get("getCatalogJsonWithRedisLock");
        // 双重检查锁来校验当前缓存中是否已经存在数据
        if (StringUtils.isEmpty(getCatalogJson)) {
            synchronized (this) {
                System.out.println("将要查询数据库....");
                if (StringUtils.isEmpty(getCatalogJson = stringRedisTemplate.opsForValue().get("getCatalogJsonWithRedisLock"))) {
                    // 服务器查询数据
                    Map<String, List<Catalog2Vo>> catalogJsonFromDB = getCatalogJsonFromDB();
                    // 将数据保存到缓存中
                    String json = JSON.toJSONString(catalogJsonFromDB);
                    stringRedisTemplate.opsForValue().set("getCatalogJsonWithRedisLock", json);
                    return catalogJsonFromDB;
                }
            }
        }
        System.out.println("查询缓存....");
        return JSON.parseObject(getCatalogJson, new TypeReference<Map<String, List<Catalog2Vo>>>() {
        });
    }

    /**
     * 从数据库中查询Catalog数据
     */
    public Map<String, List<Catalog2Vo>> getCatalogJsonFromDB() {
        System.out.println("正在查询数据库....");
        // 数据库中查询所有数据库，在Java端对数据进行封住，避免多次查询数据库
        List<CategoryEntity> all = this.list();
        // 获取一级菜单数据
        List<CategoryEntity> level1Categories = getChildByParentCid(all, 0L);
        // 将菜单数据封装成结果，key为catId，value为List
        Map<String, List<Catalog2Vo>> map = level1Categories.stream().collect(Collectors.toMap(k -> k.getCatId().toString(), v -> {
            // 查询一级菜单下的二级菜单
            List<CategoryEntity> level2 = getChildByParentCid(all, v.getCatId());
            List<Catalog2Vo> parent_cid = null;
            if (level2 != null) {
                // 将二级菜单下的三级菜单进行封住哪个
                parent_cid = level2.stream().map(item -> {
                    List<CategoryEntity> level3 = getChildByParentCid(all, item.getCatId());
                    List<Catalog3Vo> collect = null;
                    if (level3 != null) {
                        collect = level3.stream().map(l3 -> {
                            return new Catalog3Vo(item.getCatId().toString(), l3.getCatId().toString(), l3.getName());
                        }).collect(Collectors.toList());
                    }
                    return new Catalog2Vo(v.getCatId().toString(), item.getCatId().toString(), item.getName(), collect);
                }).collect(Collectors.toList());
            }
            return parent_cid;
        }));
        return map;
    }

    // 从List<CategoryEntity>获取catId为parentCid的孩子节点
    private List<CategoryEntity> getChildByParentCid(List<CategoryEntity> all, Long parentCid) {
        return all.stream().filter(item -> item.getParentCid().equals(parentCid)).collect(Collectors.toList());
    }

    private void getPath(Long catelogId, List<Long> list) {
        CategoryEntity categoryEntity = this.getById(catelogId);
        if (categoryEntity.getParentCid() != 0) {
            getPath(categoryEntity.getParentCid(), list);
        }
        list.add(categoryEntity.getCatId());
    }

    private List<CategoryEntity> queryChildren(List<CategoryEntity> list, Long parentId) {
        List<CategoryEntity> children = list.stream().filter(categoryEntity -> {
            return categoryEntity.getParentCid().equals(parentId);
        }).collect(Collectors.toList());
        children.forEach(categoryEntity -> {
            categoryEntity.setChildren(queryChildren(list, categoryEntity.getCatId()));
        });
        return children;
    }

}