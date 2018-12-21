package com.krt.sys.mapper;

import com.krt.common.base.BaseMapper;
import com.krt.sys.entity.DictionaryType;
import org.apache.ibatis.annotations.Param;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: 字典类型表映射层
 * @date 2017年04月11日
 */
public interface DictionaryTypeMapper extends BaseMapper<DictionaryType> {

    /**
     * 检测字典类型编码是否重复
     * @param code 字典类型编码
     * @param id 字典类型id
     * @return
     */
    Integer checkCode(@Param("code") String code, @Param("id") Integer id);
}
