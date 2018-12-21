package com.krt.common.util;

import com.krt.sys.entity.User;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.UnavailableSecurityManagerException;
import org.apache.shiro.session.InvalidSessionException;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.UnknownSessionException;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: Shiro工具类
 * @date 2016年7月20日
 */
public class ShiroUtils {

    private static final Logger logger = LoggerFactory.getLogger(ShiroUtils.class);

    public static Session getSession() {
        Subject subject = getSubject();
        if (subject != null) {
            return subject.getSession();
        } else {
            return null;
        }
    }

    public static Subject getSubject() {
        try {
            return SecurityUtils.getSubject();
        } catch (UnavailableSecurityManagerException e) {

        }
        return null;
    }


    /**
     * 获取session用户
     *
     * @return
     */
    public static User getCurrentUser() {
        try {
            Session session = getSession();
            if (session != null) {
                return (User) session.getAttribute("currentUser");
            } else {
                return null;
            }
        }catch (UnknownSessionException e){

        }
        return null;
    }

    /**
     * 保存session属性
     *
     * @param key
     * @param value
     */
    public static void setSessionAttribute(String key, Object value) {
        getSession().setAttribute(key, value);
    }

    /**
     * 获取session属性
     *
     * @param key
     * @return
     */
    public static Object getSessionAttribute(Object key) {
        Session session = getSession();
        if (session != null) {
            return session.getAttribute(key);
        } else {
            return null;
        }
    }


    /**
     * 获取session验证码
     *
     * @param key
     * @return
     */
    public static String getKaptcha(String key) {
        String kaptcha = getSessionAttribute(key).toString();
        getSession().removeAttribute(key);
        return kaptcha;
    }
}
