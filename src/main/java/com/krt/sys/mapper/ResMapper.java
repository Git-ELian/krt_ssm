package com.krt.sys.mapper;

import com.krt.common.base.BaseMapper;
import com.krt.sys.entity.Res;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 资源管理映射层
 * @date 2016年7月16日
 */
public interface ResMapper extends BaseMapper<Res> {

    /**
     * 获取角色的资源
     *
     * @param roleCode 角色id
     * @return
     */
    List<Res> selectListByRoleCode(@Param("roleCode") String roleCode);

    /**
     * 获取资源树
     *
     * @return
     */
    List selectAllTree();

    /**
     * 根据父id查询子集资源
     *
     * @param pid 父id
     * @return
     */
    List selectListByPid(@Param("pid") Integer pid);

}