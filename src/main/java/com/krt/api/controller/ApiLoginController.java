package com.krt.api.controller;

import com.krt.common.annotation.KrtIgnoreAuth;
import com.krt.common.bean.ReturnBean;
import com.krt.common.constant.SysConstant;
import com.krt.common.util.AesUtils;
import com.krt.common.validator.Assert;
import com.krt.sys.entity.User;
import com.krt.sys.service.TokenService;
import com.krt.sys.service.UserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.UnsupportedEncodingException;
import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 登录接口
 * @date 2017年04月11日
 */
@RestController
@RequestMapping("api")
@Api(description = "登录接口API")
public class ApiLoginController {

    @Autowired
    private UserService userService;

    @Autowired
    private TokenService tokenService;

    /**
     * 登录
     * @param username
     * @param password
     * @return
     */
    @KrtIgnoreAuth
    @PostMapping("login")
    @ApiOperation(value = "登录",notes = "登录说明")
    @ApiImplicitParams({
        @ApiImplicitParam(paramType = "query", dataType="string", name = "username", value = "账号", required = true),
        @ApiImplicitParam(paramType = "query", dataType="string", name = "password", value = "密码", required = true)
    })
    public ReturnBean<Map> login(String username, String password) throws UnsupportedEncodingException {
        Assert.isBlank(username, "账号不能为空");
        Assert.isBlank(password, "密码不能为空");
        User user= userService.selectByUsername(username);
        if(user!=null){
            String passwords = user.getPassword();
            password = AesUtils.getAESEncrypt(password, SysConstant.PASS_KEY);
            if(password.equals(passwords)) {
                Map<String, Object> map = tokenService.createToken(user.getId());
                return ReturnBean.ok(map);
            }else{
                return ReturnBean.error();
            }
        }else{
            return ReturnBean.error();
        }
    }

}
