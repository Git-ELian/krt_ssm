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
 * @Description: 资源实体类
 * @date 2017年10月16日
 */
@Getter
@Setter
@ToString(callSuper = true)
public class Res extends BaseEntity {

    /**
     * 资源名称
     */
    @NotBlank(message = "资源名称")
    private String name;

    /**
     * 连接
     */
    private String url;

    /**
     * 父id
     */
    private Integer pid;

    /**
     * 图表
     */
    private String icon;

    /**
     * 权限
     */
    private String permission;

    /**
     * 排序
     */
    @NotNull(message = "排序不能为空")
    private Integer sortNo;

    /**
     * 类别 0：菜单 1按钮
     */
    @NotBlank(message = "类型不能为空")
    private String type;

    /**
     * 打开目标
     */
    private String target;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getPermission() {
        return permission;
    }

    public void setPermission(String permission) {
        this.permission = permission;
    }

    public Integer getSortNo() {
        return sortNo;
    }

    public void setSortNo(Integer sortNo) {
        this.sortNo = sortNo;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }
}