package com.krt.sys.service.impl;

import com.krt.common.base.BaseServiceImpl;
import com.krt.sys.entity.Region;
import com.krt.sys.mapper.RegionMapper;
import com.krt.sys.service.RegionService;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @version 1.0
 * @Description：区域服务实现层
 * @author：殷帅
 * @date：2016-07-26
 */
@Service
public class RegionServiceImpl extends BaseServiceImpl<RegionMapper, Region> implements RegionService {

    /**
     * 新增区域码
     *
     * @param entity
     * @return
     */
    @CacheEvict(value = "regionCache", allEntries = true)
    @Override
    public Integer insert(Region entity) {
        return super.insert(entity);
    }

    /**
     * 更新区域码
     *
     * @param entity
     */
    @CacheEvict(value = "regionCache", allEntries = true)
    @Override
    public void update(Region entity) {
        super.update(entity);
    }

    /**
     * 根据pid查询区域
     *
     * @param pid
     * @return
     */
    @Override
    @Cacheable(value = "regionCache", unless = "#result == null")
    public List selectListByPid(Integer pid) {
        return baseMapper.selectListByPid(pid);
    }

    /**
     * 区域区域树
     *
     * @return
     */
    @Override
    @Cacheable(value = "regionCache", unless = "#result == null")
    public List selectRegionTree() {
        return baseMapper.selectRegionTree();
    }

    /**
     * 检测区域编码
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
     * 递归删除
     */
    @Override
    @CacheEvict(value = "regionCache", allEntries = true)
    public void delete(Integer id) {
        super.delete(id);
        // 查询子集
        List<Map> regList = baseMapper.selectChildList(id);
        for (Map dic : regList) {
            Integer regId = Integer.valueOf(dic.get("id") + "");
            delete(regId);
        }
    }


}
