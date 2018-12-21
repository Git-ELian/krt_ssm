package com.krt.common.base;

import com.krt.common.util.ShiroUtils;
import com.krt.common.validator.ValidatorUtils;
import com.krt.sys.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 控制器基类
 * @date 2016年7月16日
 */
public class BaseController {

    /**
     * 重定向
     */
    protected static String REDIRECT = "redirect:";

    @Autowired
    protected HttpServletRequest request;

    @Autowired
    protected HttpServletResponse response;


    /**
     * 获取session用户信息
     *
     * @return
     */
    protected User getCurrentUser() {
        return ShiroUtils.getCurrentUser();
    }

    /**
     * 验证实体
     *
     * @param object
     */
    protected void validateEntity(Object object) {
        ValidatorUtils.validateEntity(object);
    }

}