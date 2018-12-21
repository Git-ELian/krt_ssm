package com.krt.sys.service.impl;

import com.krt.common.base.BaseServiceImpl;
import com.krt.sys.entity.DictionaryType;
import com.krt.sys.mapper.DictionaryMapper;
import com.krt.sys.mapper.DictionaryTypeMapper;
import com.krt.sys.service.DictionaryTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 字典类型表服务实现层
 * @date 2017年04月11日
 */

@Service
public class DictionaryTypeServiceImpl extends BaseServiceImpl<DictionaryTypeMapper, DictionaryType> implements DictionaryTypeService {


    @Autowired
    private DictionaryMapper dictionaryMapper;

    /**
     * 删除字典
     *
     * @param id
     * @param code
     * @throws Exception
     */
    @CacheEvict(value = "dicCache", allEntries = true)
    @Override
    public void delete(Integer id, String code) {
        baseMapper.delete(id);
        dictionaryMapper.deleteByType(code);
    }

    /**
     * 检测字典编码
     *
     * @param code
     * @param id
     * @return
     */
    @Override
    public Integer checkCode(String code, Integer id) {
        return baseMapper.checkCode(code, id);
    }

    /**
     * 批量删除字典
     *
     * @param ids
     * @param codes
     */
    @Override
    @CacheEvict(value = "dicCache", allEntries = true)
    public void deleteByIdsAndCodes(String ids, String codes) {
        baseMapper.deleteByIds(ids.split(","));
        dictionaryMapper.deleteByTypes(codes);
    }
}
