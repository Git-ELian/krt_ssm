package com.krt.common.mvc;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializerProvider;

import java.io.IOException;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 自定义Jackjson mapper
 * @date 2017年04月24日
 */
public class CustomObjectMapper extends ObjectMapper {

    private static final long serialVersionUID = 1L;

    /**
     * 将json的null转为空字符串
     */
    public CustomObjectMapper() {
        super();
        // 空值处理为空串
        this.getSerializerProvider().setNullValueSerializer(new JsonSerializer<Object>() {
            @Override
            public void serialize(Object value, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException, JsonProcessingException {
                jsonGenerator.writeString("");
            }
        });
    }


}
