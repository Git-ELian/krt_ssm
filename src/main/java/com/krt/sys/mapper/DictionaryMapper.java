package com.krt.sys.mapper;

import com.krt.common.base.BaseMapper;
import com.krt.sys.entity.Dictionary;
import org.apache.ibatis.annotations.Param;

import java.util.List;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: 字典表映射层
 * @date 2017年04月11日
 */
public interface DictionaryMapper extends BaseMapper<Dictionary> {

    /**
     * 检测字典编码
     * @param type 字典类型
     * @param code 字典编码
     * @param id 字典id
     * @return
     */
    Integer checkCode(@Param("type") String type, @Param("code") String code, @Param("id") Integer id);

    /**
     * 获取子集字典
     * @param id 字典id
     * @return
     */
    List selectChildList(@Param("id") Integer id);

    /**
     * 根据类型删除字典
     * @param type
     */
    void deleteByType(@Param("type") String type);

    /**
     * 根据父id和类型查询字典
     * @param pid 父id
     * @param type 类型
     * @return
     */
    List selectDicByPidAndType(@Param("pid") Integer pid, @Param("type") String type);

    /**
     * 根据类型批量删除字典
     * @param types
     */
    void deleteByTypes(@Param("types") String types);

    /**
     * 根据code查询实体
     * @param code
     * @return
     */
    Dictionary selectEntityByCode(@Param("code") String code);
}
