package top.tobing.platformthirypart;

import com.aliyun.oss.OSSClient;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import top.tobing.platformthirypart.config.impl.TencentSmsConfig;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;

@SpringBootTest
class PlatformThirypartApplicationTests {

    @Test
    void contextLoads() {
    }


    @Autowired
    private TencentSmsConfig tencentSmsConfig;
    @Autowired
    private OSSClient ossClient;

//    @Test
    void testUploadByAlicloudOss() throws FileNotFoundException {
        String bucketName = "tobing-platform";
        String localFile = "F:\\IdeaProjects\\springboot_1_boot\\src\\main\\resources\\static\\nut.jpg";
        String fileKeyName = "nut.jpg";
        InputStream inputStream = new FileInputStream(localFile);
        ossClient.putObject(bucketName, fileKeyName, inputStream);
        ossClient.shutdown();
    }

    // @Test 测试发送短信息
    void testSendSms() {
        try {
            tencentSmsConfig.sendSms("15706694180", "888888");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
