package com.krt.common.filter.xss;

import com.krt.common.exception.KrtException;
import com.krt.common.util.StringUtils;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: SQL过滤
 * @date 2016年7月29日
 */
public class SqlFilter {

    /**
     * SQL注入过滤
     * @param str  待验证的字符串
     */
    public static String sqlInject(String str){
        if(StringUtils.isBlank(str)){
            return null;
        }
        //去掉'|"|;|\字符
        str = StringUtils.replace(str, "'", "");
        str = StringUtils.replace(str, "\"", "");
        str = StringUtils.replace(str, ";", "");
        str = StringUtils.replace(str, "\\", "");

        //转换成小写
        str = str.toLowerCase();

        //非法字符
        String[] keywords = {"master", "truncate", "insert", "delete", "update", "declare", "alert", "create", "drop"};

        //判断是否包含非法字符
        for(String keyword : keywords){
            if(str.indexOf(keyword) != -1){
                throw new KrtException("包含非法字符");
            }
        }

        return str;
    }
}
