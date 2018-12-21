package com.krt.common.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;
import java.lang.annotation.RetentionPolicy;


/**  
 * @Description: 自定义日志注解
 * @author 殷帅
 * @date 2016年7月21日
 * @version 1.0
 */
@Target({ElementType.PARAMETER, ElementType.METHOD})    
@Retention(RetentionPolicy.RUNTIME)  
@Documented 
public @interface KrtLog {
	String description()  default "";
	String type() default "1"; //1：操作日志 0：登录日志 :2 异常日志
	boolean para() default true;//  是否记录参数 true 记录 false 不记录
}
