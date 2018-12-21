package com.krt.sys.service.impl;

import com.krt.common.base.BaseServiceImpl;
import com.krt.sys.entity.Res;
import com.krt.sys.mapper.ResMapper;
import com.krt.sys.service.ResService;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 资源管理服务实现层
 * @date 2017年03月29日
 */
@Service
public class ResServiceImpl extends BaseServiceImpl<ResMapper, Res> implements ResService {

    /**
     * 新增资源
     *
     * @param entity
     * @return
     */
    @CacheEvict(value = "resCache", allEntries = true)
    @Override
    public Integer insert(Res entity) {
        return super.insert(entity);
    }

    /**
     * 更新资源
     *
     * @param entity
     */
    @CacheEvict(value = "resCache", allEntries = true)
    @Override
    public void update(Res entity) {
        super.update(entity);
    }

    /**
     * 查询全部资源
     *
     * @return
     */
    @Override
    @Cacheable(value = "resCache")
    public List selectAllTree() {
        return baseMapper.selectAllTree();
    }

    /**
     * 根据pid查询资源
     *
     * @param pid
     * @return
     */
    @Override
    @Cacheable(value = "resCache",unless = "#result == null ")
    public List selectListByPid(Integer pid) {
        return baseMapper.selectListByPid(pid);
    }

    /**
     * 查询角色权限
     *
     * @param roleCode
     * @return
     */
    @Override
    @Cacheable(value = "resCache",key = "#roleCode")
    public List<Res> selectListByRoleCode(String roleCode) {
        return baseMapper.selectListByRoleCode(roleCode);
    }

    /**
     * 递归删除模块
     *
     * @param id
     * @throws Exception
     */
    @CacheEvict(value = "resCache", allEntries = true)
    @Override
    public void delete(Integer id) {
        super.delete(id);
        List<Map> resList = baseMapper.selectListByPid(id);
        for (Map map : resList) {
            String idd = map.get("id").toString();
            delete(Integer.valueOf(idd));
        }
    }
}
