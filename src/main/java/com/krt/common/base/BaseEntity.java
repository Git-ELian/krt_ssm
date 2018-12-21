package com.krt.common.base;

import com.krt.common.util.ShiroUtils;
import com.krt.sys.entity.User;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
import java.util.Date;
import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 实体基类
 * @date 2016年7月16日
 */
@Getter
@Setter
@ToString
public class BaseEntity implements Serializable {

    /**
     * 主键id
     */
    private Integer id;
    /**
     * 录入人
     */
    private Integer inserter;
    /**
     * 录入时间
     */
    private Date insertTime;
    /**
     * 更新人
     */
    private Integer updater;
    /**
     * 更新时间
     */
    private Date updateTime;


    /**
     * 插入之前执行方法，需要手动调用
     */
    public void preInsert() {
        User currentUser = ShiroUtils.getCurrentUser();
        if (currentUser != null) {
            this.inserter = currentUser.getId();
            this.updater = this.inserter;
        }
        this.insertTime = new Date();
        this.updateTime = this.insertTime;
    }

    /**
     * 更新之前执行方法，需要手动调用
     */
    public void preUpdate() {
        User currentUser = ShiroUtils.getCurrentUser();
        if (currentUser != null) {
            this.updater = currentUser.getId();
        }
        this.updateTime = new Date();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getInserter() {
        return inserter;
    }

    public void setInserter(Integer inserter) {
        this.inserter = inserter;
    }

    public Date getInsertTime() {
        return insertTime;
    }

    public void setInsertTime(Date insertTime) {
        this.insertTime = insertTime;
    }

    public Integer getUpdater() {
        return updater;
    }

    public void setUpdater(Integer updater) {
        this.updater = updater;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}
