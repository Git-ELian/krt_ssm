package com.krt.sys.service;

import com.krt.common.base.BaseService;
import com.krt.sys.entity.Res;
import java.util.List;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 资源管理服务接口层
 * @date 2017年03月29日
 */
public interface ResService extends BaseService<Res> {

    /**
     * 查询全部资源
     *
     * @return
     */
    List selectAllTree();

    /**
     * 根据pid查询资源
     *
     * @param pid
     * @return
     */
    List selectListByPid(Integer pid);

    /**
     * 查询角色权限
     * @param roleCode
     * @return
     */
    List<Res> selectListByRoleCode(String roleCode);
}
