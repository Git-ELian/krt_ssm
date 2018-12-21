package com.krt.common.util;
import java.util.UUID;

/**
 * @Description: 编号工具类
 * @author 殷帅
 * @date 2014年1月14日
 * @version 1.0
 */
public class IdUtils {

    /**
     * 随机生成UUID
     *
     * @return
     */
    public static synchronized String getUUID() {
        UUID uuid = UUID.randomUUID();
        String str = uuid.toString();
        String uuidStr = str.replace("-", "");
        return uuidStr;
    }

    /**
     * 根据字符串生成固定UUID
     *
     * @param name
     * @return
     */
    public static synchronized String getUUID(String name) {
        UUID uuid = UUID.nameUUIDFromBytes(name.getBytes());
        String str = uuid.toString();
        String uuidStr = str.replace("-", "");
        return uuidStr;
    }
}

