package com.krt.common.util;

import com.krt.common.constant.SysConstant;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Enumeration;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: servlet 访问工具类
 * @date 2018年4月29日
 */
public class ServletUtils {

    /**
     * 静态文件后缀
     */
    private final static String[] STATIC_FILES = StringUtils.split(SysConstant.getValue("web.staticFile"), ",");


    /**
     * 判断访问URI是否是静态文件请求
     *
     * @throws Exception
     */
    public static boolean isStaticFile(String uri) {
        if (STATIC_FILES == null) {
            try {
                throw new Exception("检测到“krt.properties”中没有配置“web.staticFile”属性。配置示例：\n#静态文件后缀\n"
                        + "web.staticFile=.css,.js,.png,.jpg,.gif,.jpeg,.bmp,.ico,.swf,.psd,.htc,.crx,.xpi,.ipa,.apk");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (StringUtils.endsWithAny(uri, STATIC_FILES)
                && !StringUtils.endsWithAny(uri, ".jsp")
                && !StringUtils.endsWithAny(uri, ".java")) {
            return true;
        }
        return false;
    }

    /**
     * 获取当前请求对象
     *
     * @return
     */
    public static HttpServletRequest getRequest() {
        try {
            return ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * 判断是不是ajax访问
     *
     * @return
     */
    public static boolean isAjax(HttpServletRequest request) {
        //判断是不是ajax访问
        boolean isAjax = false;
        Enumeration<String> values = request.getHeaders("X-Requested-With");
        while (values.hasMoreElements()) {
            String value = values.nextElement();
            if ("XMLHttpRequest".equalsIgnoreCase(value)) {
                isAjax = true;
                break;
            }
        }
        return isAjax;
    }

    /**
     * response 响应
     */
    public static void print(HttpServletResponse response, Object res) throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        response.getWriter().print(res);
    }
}
