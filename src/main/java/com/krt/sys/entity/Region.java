package com.krt.sys.entity;

import com.krt.common.base.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;

/**
 * @version 1.0
 * @Description：Region实体类
 * @author：殷帅
 * @date：2016-07-26
 */
@Getter
@Setter
@ToString(callSuper = true)
public class Region extends BaseEntity {

    /**
     * 地区编码
     */
    @NotBlank(message = "地区编码不能为空")
    private String code;

    /**
     * 地区名称
     */
    @NotBlank(message = "地区名称不能为空")
    private String name;

    /**
     * 区域类型
     */
    @NotBlank(message = "区域类型不能为空")
    private String type;

    /**
     * 父id
     */
    @NotNull(message = "父id不能为空")
    private Integer pid;
}
