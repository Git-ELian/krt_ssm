package com.krt.sys.mapper;

import com.krt.common.base.BaseMapper;
import com.krt.sys.entity.Region;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @version 1.0
 * @Description：区域映射层
 * @author：殷帅
 * @date：2016-07-26
 */
public interface RegionMapper extends BaseMapper<Region> {

    /**
     * 检测区域编码是否重复
     * @param id 区域id
     * @param code 区域编码
     * @return
     */
    Integer checkCode(@Param("id") Integer id, @Param("code") String code);

    /**
     * 根据id查询子集区域id
     * @param id 区域id
     * @return
     */
    List<Map> selectChildList(@Param("id") Integer id);

    /**
     * 根据父id查询子集区域
     * @param pid 父id
     * @return
     */
    List<Map> selectListByPid(@Param("pid") Integer pid);

    /**
     * 查询区域树
     * @return
     */
    List<Map> selectRegionTree();
}
