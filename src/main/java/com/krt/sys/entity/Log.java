package com.krt.sys.entity;

import com.krt.common.base.BaseEntity;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: t_log实体类
 * @date 2017年10月16日
 */
@Getter
@Setter
@ToString(callSuper = true)
public class Log extends BaseEntity {

    /**
     * 用户
     */
    private String username;

    /**
     * 请求参数
     */
    private String requestParams;

    /**
     * 请求方式(GET,POST,DELETE,PUT)
     */
    private String requestMethod;

    /**
     * 请求方法全称
     */
    private String requestMethodName;

    /**
     * 请求id
     */
    private String requestIp;

    /**
     * 描述
     */
    private String description;

    /**
     * 耗时 单位毫秒
     */
    private Long useTime;

    /**
     * 0:登录日志 1：操作日志 2:异常日志
     */
    private String type;

    /**
     * 请求uri
     */
    private String requestUrl;

    /**
     * 异常编码
     */
    private String exceptionCode;

    /**
     * 异常详情
     */
    private String exceptionDetail;

    /**
     * 客户端信息
     */
    private String userAgent;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRequestParams() {
        return requestParams;
    }

    public void setRequestParams(String requestParams) {
        this.requestParams = requestParams;
    }

    public String getRequestMethod() {
        return requestMethod;
    }

    public void setRequestMethod(String requestMethod) {
        this.requestMethod = requestMethod;
    }

    public String getRequestMethodName() {
        return requestMethodName;
    }

    public void setRequestMethodName(String requestMethodName) {
        this.requestMethodName = requestMethodName;
    }

    public String getRequestIp() {
        return requestIp;
    }

    public void setRequestIp(String requestIp) {
        this.requestIp = requestIp;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getUseTime() {
        return useTime;
    }

    public void setUseTime(Long useTime) {
        this.useTime = useTime;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getRequestUrl() {
        return requestUrl;
    }

    public void setRequestUrl(String requestUrl) {
        this.requestUrl = requestUrl;
    }

    public String getExceptionCode() {
        return exceptionCode;
    }

    public void setExceptionCode(String exceptionCode) {
        this.exceptionCode = exceptionCode;
    }

    public String getExceptionDetail() {
        return exceptionDetail;
    }

    public void setExceptionDetail(String exceptionDetail) {
        this.exceptionDetail = exceptionDetail;
    }

    public String getUserAgent() {
        return userAgent;
    }

    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }
}