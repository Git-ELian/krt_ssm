package com.krt.common.aspect;

import com.krt.common.db.DbContextHolder;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author 殷帅
 * @version 1.0
 * @Description:Aop动态切换数据源
 * @date 2017年07月06日
 * ======使用请添加以下注解：=====
 * @Aspect
 * @Component
 * @Order(-1)
 */
public class KrtDataSourceAspect {

    private static final Logger logger = LoggerFactory.getLogger(KrtDataSourceAspect.class);

    /**
     * 事务方法名
     */
    String[] methodName = {"insert","update","delete","create","change","give","save","cancel","do"};

    /**
     * 定义切入点
     */
    @Pointcut("execution(* com.krt.*..service..*.*(..)) || execution(* com.krt.common.base.BaseServiceImpl.*(..))")
    public void dsAspect() {
    }

    /**
     * 方法执行前执行
     *
     * @param joinPoint
     */
    @Before("dsAspect()")
    public void before(JoinPoint joinPoint) {
        try {
            //获取方法名
            String method = joinPoint.getSignature().getName();
            //一下开头的方法名 用MASTER数据库  这些方法与spring-mybatis.xml事务管理的方法名同步
            boolean flag = false;
            for(int i=0;i<methodName.length;i++){
                if(method.startsWith(methodName[i])){
                    flag = true;
                    break;
                }
            }
            if (flag) {
                DbContextHolder.setDbType(DbContextHolder.MASTER);
            } else {
                DbContextHolder.setDbType(DbContextHolder.SLAVE);
            }
            logger.debug("执行方法：{} AOP设置数据源为：{}",method,DbContextHolder.getDbType());
        } catch (Exception e) {
            logger.debug("AOP设置数据源异常");
        }
    }

    /**
     * 方法返回后执行
     *
     * @param joinPoint
     */
    @After("dsAspect()")
    public void after(JoinPoint joinPoint) {
        //获取方法名
        String method = joinPoint.getSignature().getName();
        DbContextHolder.clearDbType();
        logger.debug("执行方法：{} AOP清空数据源类型设置",method);
    }


    /**
     * 发生异常后执行
     *
     * @param joinPoint
     * @param e
     */
    @AfterThrowing(pointcut = "dsAspect()", throwing = "e")
    public void afterThrowing(JoinPoint joinPoint, Throwable e) {
        //获取方法名
        String method = joinPoint.getSignature().getName();
        logger.debug("执行方法：{} 当前的数据源：{},发生了异常：{}", DbContextHolder.getDbType(), e);
        DbContextHolder.setDbType(DbContextHolder.MASTER);
    }

}
