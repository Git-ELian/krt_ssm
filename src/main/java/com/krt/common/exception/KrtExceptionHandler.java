package com.krt.common.exception;

import com.alibaba.fastjson.JSON;
import com.krt.common.bean.ReturnBean;
import com.krt.common.util.ServletUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authz.UnauthorizedException;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: 统一异常处理器
 * @date 2017年04月24日
 */
@Slf4j
@Component
public class KrtExceptionHandler implements HandlerExceptionResolver {

    /**
     * API 地址访问前缀
     */
    private final String API_PRE = "/api/";

    /**
     * 错误页
     */
    public final String ERROR_PATG = "error/500";

    /**
     * 无权限页
     */
    public final String UNAUTH_PATG = "error/unauth";

    /**
     * 异常解析器
     *
     * @param request
     * @param response
     * @param handler
     * @param ex
     * @return
     */
    @Override
    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        try {
            ex.printStackTrace();
            //判断是否是ajax请求
            String path = request.getServletPath();
            log.error("请求地址:{},程序异常:{}", path, ex);
            if (ServletUtils.isAjax(request) || path.startsWith(API_PRE)) {
                ReturnBean rb;

                if (ex instanceof KrtException) {
                    rb = ReturnBean.error(ex.getMessage());
                } else if (ex instanceof UnauthorizedException) {
                    rb = ReturnBean.error("没有权限，请联系管理员授权");
                } else {
                    rb = ReturnBean.error();
                }
                String json = JSON.toJSONString(rb);
                ServletUtils.print(response, json);
            } else {
                // 页面请求
                if (ex instanceof UnauthorizedException) {
                    log.error("shiro无权限", ex);
                    return new ModelAndView(UNAUTH_PATG);
                }
                if (ex instanceof KrtUploadException) {
                    log.warn("上传异常:{}",ex.getMessage());
                    ReturnBean rb = ReturnBean.error(ex.getMessage());
                    String json = JSON.toJSONString(rb);
                    ServletUtils.print(response, json);
                } else {
                    log.error("程序500异常", ex);
                    return new ModelAndView(ERROR_PATG);
                }
            }
        } catch (Exception e) {
            log.error("KrtExceptionHandler 异常处理失败", e);
        }
        return new ModelAndView();
    }
}
