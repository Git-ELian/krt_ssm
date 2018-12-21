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
 * @Description: 角色实体类
 * @date 2016年5月20日
 */
@Getter
@Setter
@ToString(callSuper = true)
public class Role extends BaseEntity {

    /**
     * 角色名
     */
    @NotBlank(message = "角色名不能为空")
    private String name;

    /**
     * 角色编码
     */
    @NotBlank(message = "角色编码不能为空")
    private String code;

    /**
     * 状态 0：正常  1：禁用
     */
    private String status;

    /**
     * 备注
     */
    private String remark;

    /**
     * 排序
     */
    @NotNull(message = "排序不能为空")
    private Integer sortNo;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getSortNo() {
        return sortNo;
    }

    public void setSortNo(Integer sortNo) {
        this.sortNo = sortNo;
    }
}