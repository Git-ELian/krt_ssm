package com.krt.common.interceptor;

import com.krt.common.util.DateUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.NamedThreadLocal;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 日志拦截器
 * @date 2017年03月29日
 */
@Slf4j
public class LogInterceptor implements HandlerInterceptor {

    private static final ThreadLocal<Long> START_TIME_THREAD_LOCAL = new NamedThreadLocal("ThreadLocal StartTime");

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        /**
         * request.getRequestURL() 返回全路径
         * request.getRequestURI() 返回除去host（域名或者ip）部分的路径
         * request.getContextPath() 返回工程名部分，如果工程映射为/，此处返回则为空
         * request.getServletPath() 返回除去host和工程名部分的路径
         * eg:
         * request.getRequestURL() http://localhost:8080/jqueryLearn/resources/request.jsp
         * request.getRequestURI() /jqueryLearn/resources/request.jsp
         * request.getContextPath()/jqueryLearn
         * request.getServletPath()/resources/request.jsp
         */
        if (log.isDebugEnabled()) {
            //1、开始时间
            long beginTime = System.currentTimeMillis();
            //线程绑定变量（该数据只有当前请求的线程可见）
            START_TIME_THREAD_LOCAL.set(beginTime);
            log.debug("开始计时: {}  URI: {}", new SimpleDateFormat("hh:mm:ss.SSS").format(beginTime), httpServletRequest.getServletPath());
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
        if (modelAndView != null) {
            log.info("ViewName: " + modelAndView.getViewName());
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {
        // 打印JVM信息。
        if (log.isDebugEnabled()) {
            //得到线程绑定的局部变量（开始时间）
            long beginTime = START_TIME_THREAD_LOCAL.get();
            //2、结束时间
            long endTime = System.currentTimeMillis();
            log.debug("计时结束：{}  耗时：{}  URI: {}  最大内存: {}m  已分配内存: {}m  已分配内存中的剩余空间: {}m  最大可用内存: {}m",
                    new SimpleDateFormat("hh:mm:ss.SSS").format(endTime), DateUtils.timeStampToDate(endTime - beginTime),
                    httpServletRequest.getServletPath(), Runtime.getRuntime().maxMemory() / 1024 / 1024, Runtime.getRuntime().totalMemory() / 1024 / 1024, Runtime.getRuntime().freeMemory() / 1024 / 1024,
                    (Runtime.getRuntime().maxMemory() - Runtime.getRuntime().totalMemory() + Runtime.getRuntime().freeMemory()) / 1024 / 1024);
            //删除线程变量中的数据，防止内存泄漏
            START_TIME_THREAD_LOCAL.remove();
        }
    }
}
