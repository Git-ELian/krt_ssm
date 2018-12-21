package com.krt.api.controller;

import com.krt.common.annotation.KrtIgnoreAuth;
import com.krt.common.annotation.KrtLoginUser;
import com.krt.common.bean.ReturnBean;
import com.krt.sys.entity.Token;
import com.krt.sys.entity.User;
import com.krt.sys.service.TokenService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: API测试接口接口
 * @date 2017年04月11日
 */
@RestController
@RequestMapping("api")
@Api(description = "测试接口API")
public class ApiTestController {

    @Autowired
    private TokenService tokenService;

   /**
     * 获取用户信息
     */
    @PostMapping("userInfo")
    @ApiOperation(value = "获取用户信息")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "header", name = "accessToken", value = "accessToken", required = true),
            @ApiImplicitParam(paramType = "query", dataType="User", name = "user", value = "不需要传参")
    })
    public ReturnBean<User> userInfo(@KrtLoginUser User user){
        if(user!=null) {
            return ReturnBean.ok(user);
        }else{
            return ReturnBean.error("token错误");
        }
    }

    /**
     * 忽略accessToken验证测试
     */
    @KrtIgnoreAuth
    @PostMapping("notToken")
    @ApiOperation(value = "忽略accessToken验证测试")
    public ReturnBean notToken(){
        return ReturnBean.ok();
    }


    /**
     * 刷新accessToken
     */
    @KrtIgnoreAuth
    @PostMapping("refreshToken")
    @ApiOperation(value = "accessToken")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "header", name = "refreshToken", value = "refreshToken", required = true)
    })
    public ReturnBean refreshToken(@RequestHeader String refreshToken){
        Token token = tokenService.selectEntityByRefreshToken(refreshToken);
        if(token!=null){
            Map<String, Object> map = tokenService.createToken(token.getUserId());
            return ReturnBean.ok(map);
        }else{
            return ReturnBean.error("refreshToken失效，请重新登录!");
        }
    }
}
