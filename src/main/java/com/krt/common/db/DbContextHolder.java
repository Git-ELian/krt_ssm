package com.krt.common.db;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 数据源上下文环境工具类
 * @date 2017年07月06日
 */
public class DbContextHolder {

    /**
     * 线程安全的ThreadLocal
     */
    private static final ThreadLocal<String> CONTEXT_HOLDER = new ThreadLocal<String>();
    public static String MASTER = "master";
    public static String SLAVE = "slave";

    /**
     * 设置数据源类型
     * @param dbType
     */
    public static void setDbType(String dbType) {
        CONTEXT_HOLDER.set(dbType);
    }

    /**
     * 获取当前使用的数据源
     * @return
     */
    public static String getDbType() {
        return CONTEXT_HOLDER.get();
    }

    /**
     * 清除数据源类型设置
     */
    public static void clearDbType() {
        CONTEXT_HOLDER.remove();
    }

}