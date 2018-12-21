package com.krt.sys.entity;

import com.krt.common.base.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: 流水号实体类
 * @date 2017年05月17日
 */
@Getter
@Setter
@ToString(callSuper = true)
public class Number extends BaseEntity {

    /**
     * 流水号编码
     */
    @NotBlank(message = "流水号编码不能为空")
    private String code;

    /**
     * 流水号名称
     */
    @NotBlank(message = "流水号名称不能为空")
    private String name;

    /**
     * 前缀
     */
    private String prefix;

    /**
     * 后缀
     */
    private String suffix;

    /**
     * 流水号
     */
    @NotNull(message = "流水号不能为空")
    private Integer num;

    /**
     * 流水号长度
     */
    @NotNull(message = "流水号长度不能为空")
    private Integer numLength;

    /**
     * 日期格式化
     */
    private String dateFormat;
}