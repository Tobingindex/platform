package top.tobing.platform.order;

import io.seata.spring.boot.autoconfigure.SeataAutoConfiguration;
import org.springframework.amqp.rabbit.annotation.EnableRabbit;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;


@EnableRabbit
@EnableFeignClients
@EnableConfigurationProperties
@EnableDiscoveryClient
@SpringBootApplication(exclude = SeataAutoConfiguration.class)
public class PlatformOrderApplication {

    public static void main(String[] args) {
        SpringApplication.run(PlatformOrderApplication.class, args);
    }

}
