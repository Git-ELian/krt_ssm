package com.krt.sys.service.impl;

import com.krt.common.base.BaseServiceImpl;
import com.krt.sys.entity.Dictionary;
import com.krt.sys.mapper.DictionaryMapper;
import com.krt.sys.service.DictionaryService;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 字典表服务实现层
 * @date 2017年04月11日
 */
@Service
public class DictionaryServiceImpl extends BaseServiceImpl<DictionaryMapper, Dictionary> implements DictionaryService {

    /**
     * 新增字典
     *
     * @param entity
     * @return
     */
    @Override
    @CacheEvict(value = "dicCache", allEntries = true)
    public Integer insert(Dictionary entity) {
        return super.insert(entity);
    }

    /**
     * 修改字典
     *
     * @param entity
     */
    @CacheEvict(value = "dicCache", allEntries = true)
    @Override
    public void update(Dictionary entity) {
        super.update(entity);
    }

    /**
     * 检测字典代码是否重复
     *
     * @param type 字典类型
     * @param code 字典代码
     * @param id
     * @return
     */
    @Override
    public Integer checkCode(String type, String code, Integer id) {
        return baseMapper.checkCode(type, code, id);
    }


    /**
     * 递归删除字典
     *
     * @param id 字典id
     * @throws Exception
     */
    @CacheEvict(value = "dicCache", allEntries = true)
    @Override
    public void delete(Integer id) {
        super.delete(id);
        // 查询子集
        List<Map> dicList = baseMapper.selectChildList(id);
        for (Map dic : dicList) {
            Integer dicId = Integer.valueOf(dic.get("id") + "");
            delete(dicId);
        }
    }

    /**
     * 批量递归删除字典
     *
     * @param idsStr
     */
    @CacheEvict(value = "dicCache", allEntries = true)
    @Override
    public void deleteByIds(String idsStr) {
        String[] ids = idsStr.split(",");
        for (String id : ids) {
            delete(Integer.valueOf(id));
        }
    }

    /**
     * 根据pid 和 type查询字典
     *
     * @param pid
     * @param type
     * @return
     */
    @Override
    @Cacheable(value = "dicCache")
    public List selectDicByPidAndType(Integer pid, String type) {
        return baseMapper.selectDicByPidAndType(pid, type);
    }

    /**
     * type查询字典
     *
     * @param type
     * @return
     */
    @Override
    @Cacheable(value = "dicCache")
    public List selectDicByType(String type) {
        return baseMapper.selectDicByPidAndType(0, type);
    }

    /**
     * 根据code查询实体
     *
     * @param code
     * @return
     */
    @Override
    @Cacheable(value = "dicCache")
    public Dictionary selectEntityByCode(String code) {
        return baseMapper.selectEntityByCode(code);
    }
}
