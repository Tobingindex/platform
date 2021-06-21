package top.tobing.platform.seckill;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@SpringBootTest
class PlatformSeckillApplicationTests {

    @Test
    void testGetRecently3Day() {
        LocalDate day1 = LocalDate.now();
        LocalDate day3 = day1.plusDays(2);

        LocalTime min = LocalTime.MIN;
        LocalTime max = LocalTime.MAX;

        LocalDateTime start = LocalDateTime.of(day1, min);
        LocalDateTime end = LocalDateTime.of(day3, max);

        System.out.println("开始时间：" + start.toString());
        System.out.println("结束时间：" + end.toString());


    }

}
