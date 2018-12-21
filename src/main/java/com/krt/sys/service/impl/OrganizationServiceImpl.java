package com.krt.sys.service.impl;

import com.krt.common.base.BaseServiceImpl;
import com.krt.sys.entity.Organization;
import com.krt.sys.mapper.OrganizationMapper;
import com.krt.sys.service.OrganizationService;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 组织机构服务实现层
 * @date 2017年05月17日
 */
@Service
public class OrganizationServiceImpl extends BaseServiceImpl<OrganizationMapper, Organization> implements OrganizationService {

    /**
     * 新增组织结构
     *
     * @param entity
     * @return
     */
    @CacheEvict(value = "organizationCache", allEntries = true)
    @Override
    public Integer insert(Organization entity) {
        return super.insert(entity);
    }

    /**
     * 更新组织结构
     *
     * @param entity
     */
    @CacheEvict(value = "organizationCache", allEntries = true)
    @Override
    public void update(Organization entity) {
        super.update(entity);
    }

    /**
     * 检查机构代码是否重复
     *
     * @param id
     * @param code
     * @return
     */
    @Override
    public Integer checkCode(Integer id, String code) {
        return baseMapper.checkCode(id, code);
    }

    /**
     * 获取组织树
     *
     * @return
     */
    @Override
    @Cacheable(value = "organizationCache", unless = "#result == null")
    public List selectAllTree() {
        return baseMapper.selectAllTree();
    }

    /**
     * 根据参数查询
     *
     * @param para
     * @return
     */
    @Override
    @Cacheable(value = "organizationCache", unless = "#result == null")
    public List selectListNoPage(Map para) {
        return baseMapper.selectList(para);
    }

    /**
     * 删除
     *
     * @param id
     */
    @Override
    @CacheEvict(value = "organizationCache", allEntries = true)
    public void delete(Integer id) {
        super.delete(id);
        List<Map> resList = baseMapper.selectChildList(id);
        for (Map map : resList) {
            String idd = map.get("id").toString();
            delete(Integer.valueOf(idd));
        }
    }
}
