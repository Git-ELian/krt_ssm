package com.krt.sys.service;

import com.krt.common.base.BaseService;
import com.krt.sys.dto.ResTree;
import com.krt.sys.entity.Role;

import java.util.List;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 角色管理服务接口层
 * @date 2016年7月16日
 */
public interface RoleService extends BaseService<Role> {

    /**
     * 检测角色名
     *
     * @param name 角色名
     * @param id   角色id
     * @return
     */
    Integer checkName(String name, Integer id);

    /**
     * 检测角色编码
     *
     * @param code 角色编码
     * @param id   角色id
     * @return
     */
    Integer checkCode(String code, Integer id);

    /**
     * 获取角色资源树
     *
     * @param roleCode
     * @return
     */
    List<ResTree> selectRoleResTree(String roleCode);

    /**
     * 修改角色权限
     *
     * @param roleCode
     * @param resId
     * @throws Exception
     */
    void updateRoleRes(String roleCode, String resId);

    /**
     * 批量删除
     *
     * @param ids
     * @param codes
     */
    void deleteByIdsAndCodes(String ids, String codes);

    /**
     * 获取角色url资源
     *
     * @param code
     * @param pid
     * @return
     */
    List selectRoleUrlRes(String code, Integer pid);

    /**
     * 删除角色
     *
     * @param id
     * @param code
     */
    void delete(Integer id, String code);
}
