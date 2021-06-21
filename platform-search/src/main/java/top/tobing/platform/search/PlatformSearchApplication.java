package top.tobing.platform.search;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.session.config.annotation.web.http.EnableSpringHttpSession;

@EnableSpringHttpSession
@EnableDiscoveryClient
@SpringBootApplication
public class PlatformSearchApplication {

    public static void main(String[] args) {
        SpringApplication.run(PlatformSearchApplication.class, args);
    }

}
