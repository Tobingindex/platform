package top.tobing.platform.order.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * @Author tobing
 * @Date 2021/4/15 12:40
 * @Description
 */
@Data
@ConfigurationProperties(prefix = "platform.thread")
public class ThreadPoolProperties {
    // 核心线程数
    private Integer coreSize = 10;
    // 最大线程数
    private Integer maxSize = 20;
    // 生产秒数
    private Long seconds = 10L;

}
