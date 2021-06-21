# Platform-product

## 简介

商品服务是核心服务只有，如果按照业务范围，可以分为前台和后台，前台主要是跟用户直接交互，因此对于并发量有一定要求；而后台主要是个店家或者管理员来管理商品，如：商品的上架/下架。

因此下面分前台业务和后台业务来阐释。

## 前台业务

#### 主页

前台业务主要是主页部分，在主页中需要展示如下的信息：

![image-20210514182848812](https://tobing-markdown.oss-cn-shenzhen.aliyuncs.com/image-20210514182848812.png)

观察上面其实可以发现，主要就部分信息：分类信息、广告信息、秒杀信息。由于秒杀信息单独属于一个服务，现在暂且按下不表，主要是分类信息和广告信息的获取。

广告信息和分类信息，都是调用http://platform.com/之后会直接查询出数据返回的，其中广告信息数据量比较上，而分类信息数据量当，而且还要进行拼接处理，是该业务的主要性能瓶颈。

考虑到并发量以及查询效率问题，对三级分类使用缓存加速。

> 不加缓存

![image-20210514213602674](https://tobing-markdown.oss-cn-shenzhen.aliyuncs.com/image-20210514213602674.png)

>加 Redis 缓存

![image-20210514212806802](https://tobing-markdown.oss-cn-shenzhen.aliyuncs.com/image-20210514212806802.png)

可以看出加缓冲和不加缓存性能差别还是很大的，如果想了解缓存相关内容，去看缓存相关信息。

## 后台业务