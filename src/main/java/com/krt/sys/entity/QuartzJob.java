package com.krt.sys.entity;

import com.krt.common.base.BaseEntity;
import lombok.Data;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: t_quartzJob实体类
 * @date 2017年10月16日
 */
@Data
public class QuartzJob extends BaseEntity {

    /**
     * 任务名
     */
    private String name;

    /**
     * 任务组
     */
    private String group;

    /**
     * 1：运行 0：停止
     */
    private String status;

    /**
     * 表达式
     */
    private String expression;

    /**
     * 描述
     */
    private String description;

    /**
     * bean
     */
    private String beanClass;

    /**
     * 是否同步
     */
    private String isConcurrent;

    /**
     * spring管理的bean
     */
    private String springId;

    /**
     * 方法
     */
    private String method;
}