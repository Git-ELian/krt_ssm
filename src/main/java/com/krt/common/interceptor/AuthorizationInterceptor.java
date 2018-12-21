package com.krt.common.interceptor;

import com.alibaba.fastjson.JSON;
import com.krt.common.annotation.KrtIgnoreAuth;
import com.krt.common.bean.ReturnBean;
import com.krt.common.util.ServletUtils;
import com.krt.common.util.StringUtils;
import com.krt.sys.entity.Token;
import com.krt.sys.service.TokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: API权限(Token)验证
 * @date 2017年04月28日
 */
public class AuthorizationInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private TokenService tokenService;

    public static final String LOGIN_USER_KEY = "LOGIN_USER_KEY";

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        KrtIgnoreAuth annotation;
        if (handler instanceof HandlerMethod) {
            annotation = ((HandlerMethod) handler).getMethodAnnotation(KrtIgnoreAuth.class);
        } else {
            return true;
        }
        //如果有@IgnoreAuth注解，则不验证token
        if (annotation != null) {
            return true;
        }
        //从header中获取accessToken
        String accessToken = request.getHeader("accessToken");
        //如果header中不存在accessToken，则从参数中获取accessToken
        if (StringUtils.isBlank(accessToken)) {
            accessToken = request.getParameter("accessToken");
        }
        //token为空
        if (StringUtils.isBlank(accessToken)) {
            ServletUtils.print(response, JSON.toJSONString(ReturnBean.error("accessToken不能为空")));
            return false;
        }
        //查询token信息
        Token tokenEntity = tokenService.selectEntityByAccessToken(accessToken);
        if (tokenEntity == null || tokenEntity.getExpireTime().getTime() < System.currentTimeMillis()) {
            ServletUtils.print(response, JSON.toJSONString(ReturnBean.error("accessToken失效，请重新获取")));
            return false;
        }
        //设置userId到request里，后续根据userId，获取用户信息
        request.setAttribute(LOGIN_USER_KEY, tokenEntity.getUserId());
        return true;
    }
}
