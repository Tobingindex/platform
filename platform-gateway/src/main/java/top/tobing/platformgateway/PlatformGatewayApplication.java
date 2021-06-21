package top.tobing.platformgateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

// 由于网关不需要数据源，依次将其排除，否则会抛出相关异常
// @SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
// 获取我们从pom.xml中导入common是就将其排除在外
@SpringBootApplication
@EnableDiscoveryClient
public class PlatformGatewayApplication {
    public static void main(String[] args) {
        SpringApplication.run(PlatformGatewayApplication.class, args);
    }
}
