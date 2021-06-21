package top.tobing.platform.product;

import org.junit.jupiter.api.Test;
import org.redisson.api.RedissonClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import top.tobing.platform.product.controller.CategoryController;
import top.tobing.platform.product.dao.AttrGroupDao;
import top.tobing.platform.product.dao.SkuSaleAttrValueDao;
import top.tobing.platform.product.service.CategoryService;
import top.tobing.platform.product.vo.SkuItemSaleAttrVo;
import top.tobing.platform.product.vo.SpuItemAttrGroupVo;

import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.TreeSet;

@SpringBootTest
class PlatformProductApplicationTests {

    @Test
    void contextLoads() {
    }

    @Autowired
    private CategoryService categoryService;
    @Autowired
    private RedissonClient redissonClient;
    @Autowired
    private AttrGroupDao attrGroupDao;
    @Autowired
    private SkuSaleAttrValueDao skuSaleAttrValueDao;

//    @Test
//    public void testGetSaleAttrBySpuId() {
//        List<SkuItemSaleAttrVo> saleAttrBySpuId = skuSaleAttrValueDao.getSaleAttrBySpuId(9L);
//        System.out.println(saleAttrBySpuId);
//    }

    // 通过
//    @Test
//    public void testGetAttrGroupWithAttrByCatalogIdAndSpuId() {
//        List<SpuItemAttrGroupVo> spuItemAttrGroupVoList = attrGroupDao.getAttrGroupWithAttrByCatalogIdAndSpuId(225L, 9L);
//        System.out.println(spuItemAttrGroupVoList);
//    }

    // 通过
//    @Test
//    public void testGetPath() {
//        Long[] path = categoryService.path(52L);
//        System.out.println(Arrays.asList(path));
//    }

    // 通过
//    @Test
//    public void testRedissonClient() {
//        System.out.println(redissonClient);
//    }
}
