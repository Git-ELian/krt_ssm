package com.krt.common.constant;


import com.google.common.collect.Maps;
import com.krt.common.util.PropertyUtils;
import com.krt.common.util.StringUtils;

import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 系统全局常量
 * @date 2016年8月1日
 */
public class SysConstant {


    /**
     * 当前对象实例
     */
    private static SysConstant sysConstant = null;

    /**
     * 静态工厂方法 获取当前对象实例 多线程安全单例模式(使用双重同步锁)
     */
    public static synchronized SysConstant getInstance() {
        if (sysConstant == null) {
            synchronized (SysConstant.class) {
                if (sysConstant == null) {
                    sysConstant = new SysConstant();
                }
            }
        }
        return sysConstant;
    }

    /**
     * 保存全局属性值
     */
    private static Map<String, String> map = Maps.newHashMap();

    /**
     * 属性文件加载对象
     */
    private static PropertyUtils propertyUtils = new PropertyUtils("krt.properties");


    /**
     * 获取配置
     *
     * @param key
     * @return
     */
    public static String getValue(String key) {
        String value = map.get(key);
        if (value == null) {
            value = propertyUtils.getValue(key);
            map.put(key, value != null ? value : StringUtils.EMPTY);
        }
        return value;
    }

    /************************************ 属性常量 *********************************************/

    /**
     * 超级管理员角色code
     */
    public static final String ADMIN = "admin";
    /**
     * 用户中心加密key
     */
    public static String PASS_KEY = "b0qk7cqwntc0ttqx";
    /**
     * 字典顶级父id
     */
    public static final String DIC_PID = "0";
    /**
     * session用户key
     */
    public static final String CURRENT_USER = "currentUser";
    /**
     * 分页起始数
     */
    public static final String START = "start";
    /**
     * 每页显示数量
     */
    public static final String LENGTH = "length";

}
