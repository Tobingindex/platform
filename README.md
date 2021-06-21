# platform

基于常见开源框架搭建的分布式电商系统，期望能在项目中不断应用学习到的技术，一方面提供系统的性能，另一方面公共学习到的知识。

## 1、组织架构

| 目录               | 简介                                                         |
| ------------------ | ------------------------------------------------------------ |
| notes              | 学习项目过程中记录的笔记                                     |
| platform-auth      | 认证服务                                                     |
| platform-cart      | 购物车服务                                                   |
| platform-common    | 通用模块，通用返回对象，远程调用传输对象，依赖版本控制       |
| platform-coupon    | 优惠服务                                                     |
| platform-gateway   | 网关服务                                                     |
| platform-member    | 会员服务                                                     |
| platform-order     | 订单服务                                                     |
| platform-product   | 商品服务                                                     |
| platform-thirypart | 第三方服务                                                   |
| platform-ware      | 库存服务                                                     |
| renren-fast        | 人人快速开发平台，有助于使我们将精力放在核心业务             |
| renren-generator   | 人人代码生成器，生成简单通用代码，有助于使我们将精力放在核心业务 |

> 项目架构：参考自谷粒商城，下面技术不是全部都实现，如果有机会将会对其进行重绘

![谷粒商城-微服务架构图](https://tobing-markdown.oss-cn-shenzhen.aliyuncs.com/%E8%B0%B7%E7%B2%92%E5%95%86%E5%9F%8E-%E5%BE%AE%E6%9C%8D%E5%8A%A1%E6%9E%B6%E6%9E%84%E5%9B%BE.jpg)

## 2、后端技术

| 技术                 | 说明                                                         |
| -------------------- | ------------------------------------------------------------ |
| SpringCloud Alibaba  | 阿里提供的微服务开发一站式解决方案，是阿里巴巴开源中间件与 Spring Cloud 体系的融合。 |
| SpringBoot           | 容器+MVC框架                                                 |
| Mybatis-Plus         | ORM，集成代码生成                                            |
| ElasticSearch        | 搜索引擎                                                     |
| RabbitMQ             | 消息队列                                                     |
| Nginx                | 静态资源                                                     |
| Hibernator-Validator | 验证框架                                                     |
| Lombok               | 简化对象封装工具                                             |

## 3、开发工具

| 工具                | 说明                   |
| ------------------- | ---------------------- |
| IDEA                | 开发IDE                |
| RedisDesktop        | redis客户端连接工具    |
| X-shell             | Linux远程连接工具      |
| SQLyog              | 数据库连接工具         |
| PowerDesigner/PDMan | 数据库设计工具         |
| MindMaster          | 思维导图设计工具       |
| ProcessOn           | 流程图绘制工具         |
| Snipaste            | 屏幕截图工具           |
| Postman             | API接口调试工具        |
| Typora              | Markdown编辑器         |
| PicGo               | 结合Typora实现图片上云 |
| VMware WorkStation  | 虚拟机                 |
| 花生壳              | 内网穿透               |

## 4、开发环境

| 工具          | 版本   |
| ------------- | ------ |
| JDK           | 1.8    |
| MySQL         | 5.7    |
| Redis         | 5.0    |
| ElasticSearch | 7.4.2  |
| Nginx         | 1.10   |
| RabbitMQ      | 3.8.14 |







## 参考资料

[谷粒商城](https://www.bilibili.com/video/BV1np4y1C7Yf)

[mall](https://gitee.com/macrozheng/mall)

<hr>

目前仅仅是将整体框架编写完成，但还有很多细节问题需要完善，敬请期待！

