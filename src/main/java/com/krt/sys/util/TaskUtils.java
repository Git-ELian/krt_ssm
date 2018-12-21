package com.krt.sys.util;

import com.krt.common.util.SpringUtils;
import com.krt.sys.entity.QuartzJob;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Method;


/**
 * @Description: 任务操作工具类
 * @author 殷帅
 * @date 2016年3月8日
 * @version 1.0
 */
public class TaskUtils {

    public final static Logger logger = LoggerFactory.getLogger(TaskUtils.class);

    /**
     * 通过反射调用scheduleJob中定义的方法
     *
     * @param scheduleJob
     */
    @SuppressWarnings({"unchecked", "rawtypes"})
    public static void invokMethod(QuartzJob scheduleJob) {
        Object object = null;
        Class clazz = null;
        if (scheduleJob.getSpringId() != null && !"".equals(scheduleJob.getSpringId())) {
            object = SpringUtils.getBean(scheduleJob.getSpringId());
        } else if (scheduleJob.getBeanClass() != null && !"".equals(scheduleJob.getBeanClass())) {
            try {
                clazz = Class.forName(scheduleJob.getBeanClass());
                object = clazz.newInstance();
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        if (object == null) {
            logger.error("任务名称 = [" + scheduleJob.getName() + "]---------------未启动成功，请检查是否配置正确！！！");
            return;
        }
        clazz = object.getClass();
        Method method = null;
        try {
            method = clazz.getDeclaredMethod(scheduleJob.getMethod());
        } catch (NoSuchMethodException e) {
            logger.error("任务名称 = [" + scheduleJob.getName() + "]---------------未启动成功，方法名设置错误！！！");
        } catch (SecurityException e) {
            e.printStackTrace();
        }
        if (method != null) {
            try {
                method.invoke(object);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        logger.debug("任务名称 = [" + scheduleJob.getName() + "]----------启动成功");
    }
}
