package com.krt.sys.enums;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 用户账号状态枚举
 * @date 2018年04月29日
 */
public enum UserStatus {
    /**
     * 正常的
     */
    NORMAL("0"),
    /**
     * 禁用的
     */
    FORBIDDEN("1");

    UserStatus(String status) {
        this.status = status;
    }

    private String status;

    public String getStatus() {
        return status;
    }
}
