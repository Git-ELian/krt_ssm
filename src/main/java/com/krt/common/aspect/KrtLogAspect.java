package com.krt.common.aspect;

import com.krt.common.annotation.KrtLog;
import com.krt.common.bean.ReturnBean;
import com.krt.common.enums.ReturnCode;
import com.krt.common.util.IpUtils;
import com.krt.common.util.ShiroUtils;
import com.krt.sys.entity.Log;
import com.krt.sys.entity.User;
import com.krt.sys.enums.LogType;
import com.krt.sys.service.LogService;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NamedThreadLocal;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Arrays;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 切面日志
 * @date 2016年7月21日
 */
@Aspect
@Component
public class KrtLogAspect {

    private static final Logger logger = LoggerFactory.getLogger(KrtLogAspect.class);

    @Autowired
    private LogService logService;

    @Autowired
    private ThreadPoolTaskExecutor threadPoolTaskExecutor;

    /**
     * 日志
     */
    private static final ThreadLocal<Log> LOCAL_LOG = new ThreadLocal();

    /**
     * 开始时间
     */
    private static final ThreadLocal<Long> startTimeThreadLocal = new NamedThreadLocal<Long>("ThreadLocal StartTime");

    /**
     * 定义切入点
     */
    @Pointcut("@annotation(com.krt.common.annotation.KrtLog)")
    public void logAspect() {

    }

    /**
     * 方法执行前执行
     *
     * @param joinPoint
     */
    @Before("logAspect()")
    public void doBefore(JoinPoint joinPoint) {
        try {
            long beginTime = System.currentTimeMillis();
            startTimeThreadLocal.set(beginTime);
            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
            // 读取session中的用户
            User currentUser = ShiroUtils.getCurrentUser();
            // 请求的IP
            String ip = IpUtils.getIpAddr(request);
            //请求的参数
            Object[] args = joinPoint.getArgs();
            Log log = getAopLog(joinPoint);
            log.setRequestMethodName((joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName() + "()"));
            log.setRequestIp(ip);
            log.setRequestParams(null);
            if (currentUser != null) {
                log.setUsername(currentUser.getUsername());
            }
            log.setRequestMethod(request.getMethod());
            MethodSignature signature = (MethodSignature) joinPoint.getSignature();
            Method method = signature.getMethod();
            KrtLog krtLog = method.getAnnotation(KrtLog.class);
            if (krtLog.para() && Arrays.toString(args).length() < 800) {
                log.setRequestParams(Arrays.toString(args));
            }
            log.setRequestUrl(request.getServletPath());
            log.setUserAgent(request.getHeader("User-Agent"));
            log.setExceptionCode(null);
            log.setExceptionDetail(null);
            LOCAL_LOG.set(log);
        } catch (Exception e) {
            // 记录本地异常日志
            logger.error("===前置通知异常===");
            logger.error("异常信息:{}", e.getMessage());
        }
    }

    /**
     * 方法返回后执行
     *
     * @param returnValue
     */
    @AfterReturning(pointcut = "logAspect()", returning = "returnValue")
    public void log(Object returnValue) {
        //得到线程绑定的局部变量（开始时间）
        long beginTime = startTimeThreadLocal.get();
        //2、结束时间
        long endTime = System.currentTimeMillis();
        Log log = LOCAL_LOG.get();
        log.setUseTime(endTime - beginTime);
        User user = ShiroUtils.getCurrentUser();
        if (user != null) {
            log.setUsername(user.getUsername());
        }
        if (log.getType().equals(LogType.LOGIN.getType())) {
            ReturnBean rb = (ReturnBean) returnValue;
            if (ReturnCode.OK.getCode() == rb.code) {
                //记录登录成功的日志 登录失败不记录
                threadPoolTaskExecutor.execute(new InsertLogThread(log, logService));
            }
        } else {
            threadPoolTaskExecutor.execute(new InsertLogThread(log, logService));
        }
        LOCAL_LOG.remove();
        startTimeThreadLocal.remove();
    }


    /**
     * 发生异常后执行
     *
     * @param joinPoint
     * @param e
     */
    @AfterThrowing(pointcut = "logAspect()", throwing = "e")
    public void doAfterThrowing(JoinPoint joinPoint, Throwable e) {
        //请求的参数
        Object[] args = joinPoint.getArgs();
        Log log = LOCAL_LOG.get();
        try {
            log.setType(LogType.EXCEPTION.getType());
            log.setExceptionCode(e.getClass().getName());
            log.setExceptionDetail(e.getMessage());
            //保存数据库
            threadPoolTaskExecutor.execute(new InsertLogThread(log, logService));
            LOCAL_LOG.remove();
            startTimeThreadLocal.remove();
        } catch (Exception ex) {
            //记录本地异常日志
            logger.error("===异常方法全路径:{},异常信息:{},请求参数:{}===", log.getRequestMethodName(), e.getMessage(), Arrays.toString(args));
        }
    }

    /**
     * 获取注解中对方法的描述信息 用于Controller层注解
     *
     * @param joinPoint 切点
     * @return 方法描述
     * @throws Exception
     */
    public static Log getAopLog(JoinPoint joinPoint) throws Exception {
        Log log = new Log();
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        Method method = signature.getMethod();
        KrtLog krtLog = method.getAnnotation(KrtLog.class);
        if (null != krtLog) {
            String description = krtLog.description();
            String type = krtLog.type();
            log.setDescription(description);
            log.setType(type);
        }
        return log;
    }

    /**
     * 保存日志线程
     */
    public class InsertLogThread implements Runnable {
        private Log log;
        private LogService logService;

        public InsertLogThread(Log log, LogService logService) {
            this.log = log;
            this.logService = logService;
        }

        @Override
        public void run() {
            logService.insert(log);
        }
    }

}

