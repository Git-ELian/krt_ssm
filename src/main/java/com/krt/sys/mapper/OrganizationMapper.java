package com.krt.sys.mapper;

import com.krt.common.base.BaseMapper;
import com.krt.sys.entity.Organization;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: 组织机构映射层
 * @date 2017年05月17日
 */
public interface OrganizationMapper extends BaseMapper<Organization> {

    /**
     * 检测组织编码
     * @param id 组织id
     * @param code 组织编码
     * @return
     */
    Integer checkCode(@Param("id") Integer id, @Param("code") String code);

    /**
     * 获取组织树结构
     * @return
     */
    List selectAllTree();

    /**
     * 查询子集组织
     * @param id 组织id
     * @return
     */
    List<Map> selectChildList(@Param("id") Integer id);
}
