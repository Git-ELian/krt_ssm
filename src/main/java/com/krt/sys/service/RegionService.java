package com.krt.sys.service;

import com.krt.common.base.BaseService;
import com.krt.sys.entity.Region;

import java.util.List;

/**
 * @version 1.0
 * @Description：区域服务接口层
 * @author：殷帅
 * @date：2016-07-26
 */
public interface RegionService extends BaseService<Region> {

    /**
     * 根据pid查询
     *
     * @param pid
     * @return
     */
    List selectListByPid(Integer pid);

    /**
     * 区域区域树
     *
     * @return
     */
    List selectRegionTree();

    /**
     * 检测区域编码
     *
     * @param id
     * @param code
     * @return
     */
    Integer checkCode(Integer id, String code);


}
