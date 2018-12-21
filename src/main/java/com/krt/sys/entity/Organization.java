package com.krt.sys.entity;

import com.krt.common.base.BaseEntity;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: 组织机构实体类
 * @date 2017年10月16日
 */
@Getter
@Setter
@ToString(callSuper = true)
public class Organization extends BaseEntity {

    /**
     * 父级id
     */
    @NotNull(message = "父级id不能为空")
    private Integer pid;

    /**
     * 机构名称
     */
    @NotBlank(message = "机构名称不能为空")
    private String name;

    /**
     * 机构代码
     */
    @NotBlank(message = "机构代码不能为空")
    private String code;

    /**
     * 机构类别
     */
    private String type;

    /**
     * 结构类型
     */
    private String grade;

    /**
     * 主要负责人
     */
    private String primaryMan;

    /**
     * 副负责人
     */
    private String viceMan;

    /**
     * 联系人
     */
    private String linkMan;

    /**
     * 联系地址
     */
    private String address;

    /**
     * 邮编
     */
    private String zipcode;

    /**
     * 手机号码
     */
    private String phone;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 区域编码
     */
    private String regionCode;

    /**
     * 备注
     */
    private String remark;
}