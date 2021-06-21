# 浅谈SpringSession

## SpringSession作用 TODO

## SpringSession快速使用

Springboot在使用SpringSession需要以下步骤：

1. 引入依赖 `spring-session-data-redis`
2. 配置配置文件 `spring.session.store-type=redis` 来指明session存储的类型
3. 配置 Redis 的连接信息
4. 在SpringBoot启动类中使用 `@EnableRedisHttpSession` 注解开启 SpringSession 的使用

[Spring Session - Spring Boot](https://docs.spring.io/spring-session/docs/2.4.3/reference/html5/guides/boot-redis.html)

## SpringSession原理

SpringBoot 配置注解创建了一个实现了 Filter 的 SpringSessionRepositoryFilter类。这个类可以让自定义的配置 SpringSession来替换 HttpSesion。

【SpringSession的核心原理】
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
    @Bean
	public RedisIndexedSessionRepository sessionRepository(){
        ...
    }
}
```

> RedisHttpSessionConfiguration 父类 SpringHttpSessionConfiguration

```java
public class SpringHttpSessionConfiguration implements ApplicationContextAware {
    	@Bean
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

## 补充：Filter

Filter 能够在一个request到达servlet之前预处理request，也可以在response离开servlet时处理response。可以实现：

1. 在servlet被调用之前截获；

2. 在servlet被调用之前检查servlet request;

3. 根据需要修改request头和request数据；

4. 根据需要修改response头和response数据；

5. 在servlet被调用之后截获.

三个方法

1. void setFilterConfig(FilterConfig config) //设置filter 的配置对象；

2. FilterConfig getFilterConfig() //返回filter的配置对象；

3. void doFilter(ServletRequest req,ServletResponse res,FilterChain chain) //执行filter 的工作.