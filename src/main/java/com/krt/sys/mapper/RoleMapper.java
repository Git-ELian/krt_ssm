package com.krt.sys.mapper;
import com.krt.common.base.BaseMapper;
import com.krt.sys.entity.Role;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Description: 角色管理映射层
 * @author 殷帅
 * @date 2016年7月16日
 * @version 1.0
 */
public interface RoleMapper extends BaseMapper<Role> {

	/**
	 * 检测角色名是否重复
	 * @param name 角色名
	 * @param id 角色id
	 * @return
	 */
	Integer checkName(@Param("name") String name, @Param("id") Integer id);

	/**
	 * 检测角色编码是否重复
	 * @param code 角色编码
	 * @param id 角色id
	 * @return
	 */
	Integer checkCode(@Param("code") String code, @Param("id") Integer id);

	/**
	 * 根据角色编码删除角色资源
	 * @param roleCode 角色编码
	 */
	void deleteRoleRes(@Param("roleCode") String roleCode);

	/**
	 * 批量保存角色资源
	 * @param list 角色资源list
	 */
	void insertRoleRes(List list);

	/**
	 * 查询角色资源
	 * @param code 角色编码
	 * @param pid 父id
	 * @return
	 */
	List selectRoleUrlRes(@Param("code") String code, @Param("pid") Integer pid);

	/**
	 * 批量删除角色资源
	 * @param codes 角色编码
	 */
    void deleteRoleResByCodes(@Param("codes") String codes);
}
