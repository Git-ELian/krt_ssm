package com.krt.sys.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.validation.constraints.NotNull;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 登录表单
 * @date 2018年04月29日
 */
@Getter
@Setter
@ToString(callSuper = true)
public class LoginForm {

    /**
     * 用户名
     */
    @NotNull
    private String username;
    /**
     * 密码
     */
    @NotNull
    private String password;
    /**
     * 验证码
     */
    @NotNull
    private String verifyCode;
}
