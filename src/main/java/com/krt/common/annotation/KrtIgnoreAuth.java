package com.krt.common.annotation;

import java.lang.annotation.*;


/**
 * @Description: 忽略Token验证注解
 * @author 殷帅
 * @date 2016年7月21日
 * @version 1.0
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface KrtIgnoreAuth {

}
