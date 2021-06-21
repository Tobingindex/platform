package top.tobing.platform.order.config;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import org.springframework.context.annotation.Configuration;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.SimpleFormatter;

/**
 * @Author tobing
 * @Date 2021/4/25 20:53
 * @Description 解决Jackson序列化问题「yyyy-MM-dd HH:mm:ss」问题
 */
@Configuration
public class JacksonDateFormatConfig extends JsonDeserializer<Date> {

    @Override
    public Date deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String text = jsonParser.getText();
        try {
            return sdf.parse(text);
        } catch (ParseException e) {
            throw new RuntimeException("日期转失败");
        }
    }

}
