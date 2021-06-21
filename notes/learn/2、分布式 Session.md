# 2、分布式 Session

## Session 回顾

因为HTTP协议是一个无状态协议，即Web应用程序无法区分收到的两个HTTP请求是否是同一个浏览器发出的。为了跟踪用户状态，服务器可以向浏览器分配一个唯一ID（JSESSIONID），并以Cookie的形式发送到浏览器，浏览器在后续访问时总是附带此Cookie，这样，服务器就可以识别用户身份。

这种基于唯一ID识别用户身份的机制称为Session。

每个用户第一次访问服务器后，会自动获得一个Session ID。如果用户在一段时间内没有访问服务器，那么Session会自动失效，下次即使带着上次分配的Session ID访问，服务器也认为这是一个新用户，会分配新的Session ID。

从上面我看可以Session的实现是依赖于Cookie的。

## Session 共享

#### 什么是 Session 共享

在分布式环境下，由于不同系统部署在不同的机器上，或者一个系统被以集群的方式部署在不同的机器上，而传统的Session是保存在 JVM 进程中。这时，这时候就需要考虑如何将 Session进行共享。

#### 如何是实现 Session 共享

- 使用 Cookie 来完成（很明显这种不安全的操作并不可靠，用户信息全都暴露在浏览器端）；
- 使用 Nginx 中的 IP 绑定策略（Ip_Hash），同一个 IP 只能在指定的同一个机器访问（单台机器的负载可能很高，水平添加机器后，请求可能会被重新定位到一台机器上还是会导致 Session 不能顺利共享）；
- 利用数据库同步 Session（本质上和本文推荐的存在 Redis 中是一样的，但是效率没有存放在 Redis 中高）；
- 使用 Tomcat 内置的 Session 同步（同步可能会产生延迟）；
- 使用 Token 代替 Session（也是比较推荐的方案，但不是本文的重点）；
- **本文推荐使用 Spring-Session 集成好的解决方案，将Session存放在Redis中进行共享**。

## Spring Session

#### Spring Session 简介

Spring Session provides an API and implementations for managing a user’s session information while also making it trivial to support clustered sessions without being tied to an application container-specific solution. 

#### Spring Session 使用（boot）

1、引入 `spring-session-data-redis`与`spring-boot-starter-data-redis`依赖

```xml
<!--springsession-->
<dependency>
    <groupId>org.springframework.session</groupId>
    <artifactId>spring-session-data-redis</artifactId>
</dependency>
<!--reids-->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-redis</artifactId>
</dependency>
```

2、配置 Spring Session 使用的持久化方式

```properties
# spring session
spring.session.store-type=redis
# redis使用默认配置
```

3、在SpringBoot启动类中使用 `@EnableRedisHttpSession` 注解开启 SpringSession 的使用

```java
@EnableRedisHttpSession
@SpringBootApplication
public class PlatformAuthApplication {
    public static void main(String[] args) {
        SpringApplication.run(PlatformAuthApplication.class, args);
    }
}
```

#### Spring Session 原理浅析

原理概览

1. 使用SpringSession需要添加@EnableRedisHttpSession，这个注解帮我们引入了RedisHttpSessionConfiguration；
2. 在RedisHttpSessionConfiguration类中，往Spring容器放了：
   + RedisIndexedSessionRepository（本类中注入）：主要用于对Redis中的session就行增删改查；
   + SessionRepositoryFilter（父类中注入）：实现Filter，作用是过滤器，每个请求都会经过这个类；
3. 对于SessionRepositoryFilter，在构造函数中会获取容器中的RedisIndexedSessionRepository；
4. 在SessionRepositoryFilter的doFilterInternal中，是对每个请求的实现逻辑过滤操作；
5. 在doFilterInternal方法中对request和response就行了包装（装饰者模式）；
6. 原始的request和response会被包装为SessionRepositoryRequestWrapper和SessionRepositoryResponseWrapper；
7. 在以后获取Session，需要通过request获取，这是就是调用了SessionRepositoryRequestWrapper.getSession方法；
8. SessionRepositoryRequestWrapper实现的session是通过SessionRepository来操作（增删改查）Session；
9. 而SessionRepository又是传入的RedisIndexedSessionRepository，即通过Redis来操作Session。

> @EnableRedisHttpSession 注解

```java
@Import(RedisHttpSessionConfiguration.class)
@Configuration(proxyBeanMethods = false)
public @interface EnableRedisHttpSession {
    ...
}
```

>RedisHttpSessionConfiguration 类

```java
public class RedisHttpSessionConfiguration extends SpringHttpSessionConfiguration
		implements BeanClassLoaderAware, EmbeddedValueResolverAware, ImportAware {
    @Bean	// 使用Bean注解将RedisIndexedSessionRepository放到容器中
	public RedisIndexedSessionRepository sessionRepository(){
        ...
    }
}
```

> RedisHttpSessionConfiguration 父类 SpringHttpSessionConfiguration

```java
public class SpringHttpSessionConfiguration implements ApplicationContextAware {
    	@Bean // 使用Bean注解将SessionRepositoryFilter放到容器中
	public <S extends Session> SessionRepositoryFilter<? extends Session> springSessionRepositoryFilter(){
        ...
    }
}
```

> SessionRepositoryFilter 类

```java
public class SessionRepositoryFilter<S extends Session> extends OncePerRequestFilter{
    // 构造函数将SessionRepository注入
    public SessionRepositoryFilter(SessionRepository<S> sessionRepository) {
		if (sessionRepository == null) {
			throw new IllegalArgumentException("sessionRepository cannot be null");
		}
		this.sessionRepository = sessionRepository;
	}
    // ...
    // doFilterInternal中将request，response分别封装为SessionRepositoryRequestWrapper和SessionRepositoryResponseWrapper
    @Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		request.setAttribute(SESSION_REPOSITORY_ATTR, this.sessionRepository);

		SessionRepositoryRequestWrapper wrappedRequest = new SessionRepositoryRequestWrapper(request, response);
		SessionRepositoryResponseWrapper wrappedResponse = new SessionRepositoryResponseWrapper(wrappedRequest,
				response);

		try {
			filterChain.doFilter(wrappedRequest, wrappedResponse);
		}
		finally {
			wrappedRequest.commitSession();
		}
	}
}
```

>SessionRepositoryRequestWrapper 类

```java
private final class SessionRepositoryRequestWrapper extends HttpServletRequestWrapper {
    // 获取Sesion
    @Override
    public HttpSessionWrapper getSession(boolean create) {
        // 内部通过sessionRepository操作
        // ...
    }
}
```

> RedisIndexedSessionRepository 类封装了Redis对Session的操作

```java
public interface SessionRepository<S extends Session> {
	S createSession();
	void save(S session);
	S findById(String id);
	void deleteById(String id);
}
```

【总结】

通过自定义Filter封装request、response，使得在使用request获取Session时，从Redis中获取。



## 参考文献

[Spring-Session 原理简析](https://zhuanlan.zhihu.com/p/246344640)

[Spring Session](https://docs.spring.io/spring-session/docs/2.4.3/reference/html5/)

[session介绍]([session介绍_coolwriter的博客-CSDN博客_session介绍](https://blog.csdn.net/coolwriter/article/details/81201799))







