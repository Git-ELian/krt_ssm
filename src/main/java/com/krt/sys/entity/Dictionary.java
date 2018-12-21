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
 * @Description: 字典表实体类
 * @date 2017年04月11日
 */
@Getter
@Setter
@ToString(callSuper = true)
public class Dictionary extends BaseEntity {

    /**
     * 类别
     */
    @NotBlank(message = "类别不能为空")
    private String type;

    /**
     * 父id
     */
    @NotNull(message = "父id不能为空")
    private Integer pid;

    /**
     * 字典代码
     */
    @NotBlank(message = "字典代码不能为空")
    private String code;

    /**
     * 字典名称
     */
    @NotBlank(message = "字典名称不能为空")
    private String name;

    /**
     * 备注
     */
    private String remark;

    /**
     * 排序
     */
    @NotNull(message = "排序不能为空")
    private Integer sortNo;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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