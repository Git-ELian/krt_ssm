package com.krt.sys.enums;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 任务执行状态枚举
 * @date 2018年04月29日
 */
public enum JobStaus {
    /**
     * 启动任务
     */
    START("0"),
    /**
     * 停止任务
     */
    STOP("1");

    JobStaus(String status) {
        this.status = status;
    }

    private String status;

    public String getStatus() {
        return status;
    }
}
