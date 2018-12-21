package com.krt.common.exception;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 自定义异常
 * @date 2017年04月24日
 */
public class KrtException extends RuntimeException{


    private String message;

    public KrtException(String message) {
        super(message);
        this.message = message;
    }

    public KrtException(String message, Throwable e) {
        super(message, e);
        this.message = message;
    }

    @Override
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
