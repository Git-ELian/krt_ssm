package com.krt.common.enums;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: 全局返回码
 * @date 2016年8月1日
 */
public enum ReturnCode {

    /**
     * 操作成功
     */
    OK(0, "操作成功"),
    /**
     * 操作失败
     */
    ERROR(-1, "操作失败"),
    /**
     * ACCESS_TOKEN已过期
     */
    ACCESS_TOKEN_EXPIRE(40001,"ACCESS_TOKEN已过期");


    private int code;

    private String msg;


    ReturnCode(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

}
