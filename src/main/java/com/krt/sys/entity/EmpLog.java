package com.krt.sys.entity;

/**
 * @author 匿名
 * @create 2018-12-25 10:11
 * @desc 日志实体类
 **/


public class EmpLog {
    private int logId;
    private String logName;
    private int logNum;
    private String logDetail;


    public int getLogId() {
        return logId;
    }

    public void setLogId(int logId) {
        this.logId = logId;
    }

    public String getLogName() {
        return logName;
    }

    public void setLogName(String logName) {
        this.logName = logName;
    }

    public int getLogNum() {
        return logNum;
    }

    public void setLogNum(int logNum) {
        this.logNum = logNum;
    }

    public String getLogDetail() {
        return logDetail;
    }

    public void setLogDetail(String logDetail) {
        this.logDetail = logDetail;
    }

}
