package com.krt.common.exception;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 自定义文件上传异常异常
 * @date 2017年04月24日
 */
public class KrtUploadException extends RuntimeException{

    private String message;

    public KrtUploadException(String message) {
        super(message);
        this.message = message;
    }

    public KrtUploadException(String message, Throwable e) {
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
