package com.krt.sys.service;

import com.krt.common.base.BaseService;
import com.krt.sys.entity.DictionaryType;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 字典类型表服务接口层
 * @date 2017年04月11日
 */
public interface DictionaryTypeService extends BaseService<DictionaryType> {

    /**
     * 检测字典编码
     *
     * @param code
     * @param id
     * @return
     */
    Integer checkCode(String code, Integer id);

    /**
     * 批量删除字典
     *
     * @param ids
     * @param codes
     */
    void deleteByIdsAndCodes(String ids, String codes);

    /**
     * 删除字典
     *
     * @param id
     * @param code
     */
    void delete(Integer id, String code);
}
