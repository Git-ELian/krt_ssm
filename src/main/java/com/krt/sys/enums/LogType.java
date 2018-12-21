package com.krt.sys.enums;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 系统日志类别枚举
 * @date 2018年04月29日
 */
public enum LogType {

    /**
     * 登录日志类别
     */
    LOGIN("0"),
    /**
     * 操作日志类别
     */
    DO("1"),
    /**
     * 异常日志类别
     */
    EXCEPTION("2");

    LogType(String type) {
        this.type = type;
    }

    private String type;

    public String getType() {
        return type;
    }
}
