package com.krt.common.cache;

import org.springframework.cache.interceptor.KeyGenerator;

import java.lang.reflect.Method;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 自定义缓存key
 * @date 2017年06月20日
 */
public class KrtCacheKeyGenerator implements KeyGenerator {

    /**
     * key 为包名+方法名+：+参数
     *
     * @param o 包名
     * @param method 方法名
     * @param objects 参数
     * @return
     */
    @Override
    public Object generate(Object o, Method method, Object... objects) {
        StringBuilder sb = new StringBuilder();
        sb.append(o.getClass().getName());
        sb.append(".");
        sb.append(method.getName());
        if (objects.length > 0) {
            sb.append(":");
        }
        for (Object obj : objects) {
            sb.append(obj.toString());
        }
        return sb.toString();
    }
}
