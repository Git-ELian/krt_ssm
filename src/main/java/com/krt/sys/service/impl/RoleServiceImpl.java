package com.krt.sys.service.impl;

import com.krt.common.base.BaseServiceImpl;
import com.krt.sys.dto.ResTree;
import com.krt.sys.entity.Res;
import com.krt.sys.entity.Role;
import com.krt.sys.mapper.ResMapper;
import com.krt.sys.mapper.RoleMapper;
import com.krt.sys.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 角色管理服务实现层
 * @date 2016年7月16日
 */
@Service
public class RoleServiceImpl extends BaseServiceImpl<RoleMapper, Role> implements RoleService {

    @Autowired
    private ResMapper resMapper;

    /**
     * 检测角色名
     *
     * @param name 角色名
     * @param id   角色id
     * @return
     */
    @Override
    public Integer checkName(String name, Integer id) {
        return baseMapper.checkName(name, id);
    }

    /**
     * 检测角色编码
     *
     * @param code 角色编码
     * @param id   角色id
     * @return
     */
    @Override
    public Integer checkCode(String code, Integer id) {
        return baseMapper.checkCode(code, id);
    }

    /**
     * 获取角色资源树
     *
     * @param roleCode
     * @return
     */
    @Override
    public List<ResTree> selectRoleResTree(String roleCode) {
        // 查询全部资源
        List allList = resMapper.selectAll();
        // 查询角色资源
        List<Res> roleResList = resMapper.selectListByRoleCode(roleCode);
        List<ResTree> resTreeList = new ArrayList<>();
        if (allList != null && allList.size() > 0) {
            for (int i = 0; i < allList.size(); i++) {
                ResTree resTree = new ResTree();
                Res res1 = (Res) allList.get(i);
                int resId1 = res1.getId();
                resTree.setId(resId1);
                resTree.setName(res1.getName());
                resTree.setPId(res1.getPid());
                if (roleResList != null && roleResList.size() > 0) {
                    for (int j = 0; j < roleResList.size(); j++) {
                        Res res2 =  roleResList.get(j);
                        int resId2 = res2.getId();
                        if (resId1 == resId2) {
                            resTree.setOpen(true);
                            resTree.setChecked(true);
                        }
                    }
                }
                resTreeList.add(resTree);
            }
        }
        return resTreeList;
    }

    /**
     * 修改角色权限
     *
     * @param roleCode
     * @param resId
     * @throws Exception
     */
    @Override
    public void updateRoleRes(String roleCode, String resId) {
        // 先删除角色权限
        baseMapper.deleteRoleRes(roleCode);
        if (resId != null && !"".equals(resId)) {
            List list = new ArrayList();
            String[] ids = resId.split(",");
            for (String id : ids) {
                Map pmap = new HashMap(2);
                pmap.put("roleCode", roleCode);
                pmap.put("resId", Integer.valueOf(id));
                list.add(pmap);
            }
            baseMapper.insertRoleRes(list);
        }
    }

    /**
     * 删除
     *
     * @param id
     * @param code
     */
    @Override
    public void delete(Integer id, String code) {
        baseMapper.delete(id);
        baseMapper.deleteRoleRes(code);
    }

    /**
     * 批量删除
     *
     * @param ids
     * @param codes
     */
    @Override
    public void deleteByIdsAndCodes(String ids, String codes) {
        baseMapper.deleteByIds(ids.split(","));
        baseMapper.deleteRoleResByCodes(codes);
    }

    /**
     * 获取角色url资源
     *
     * @param code
     * @return
     */
    @Override
    @Cacheable(value = "resCache")
    public List selectRoleUrlRes(String code, Integer pid) {
        List<Map> list = baseMapper.selectRoleUrlRes(code, pid);
        if (list != null && list.size() > 0) {
            for (Map m : list) {
                List chlid = selectRoleUrlRes(code, Integer.valueOf(m.get("id").toString()));
                m.put("child", chlid);
            }
        }
        return list;
    }


}
