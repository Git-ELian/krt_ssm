package com.krt.sys.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 资源树结构
 * @date 2018年04月29日
 */
@Getter
@Setter
@ToString(callSuper = true)
public class ResTree {

    /**
     * 资源id
     */
    private Integer id;
    /**
     * 资源父id
     */
    private Integer pId;
    /**
     * 资源名称
     */
    private String name;
    /**
     * 是否打开
     */
    private boolean open;
    /**
     * 是否选中
     */
    private boolean checked;
}
