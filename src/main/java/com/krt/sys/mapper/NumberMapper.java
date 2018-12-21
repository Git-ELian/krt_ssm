package com.krt.sys.mapper;

import com.krt.common.base.BaseMapper;
import com.krt.sys.entity.Number;
import org.apache.ibatis.annotations.Param;

import java.util.Map;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: 流水号映射层
 * @date 2017年05月17日
 */
public interface NumberMapper extends BaseMapper<Number> {

    /**
     * 检车流水号类型编码
     * @param id 流水号id
     * @param code 流水号编码
     * @return
     */
    Integer checkNumber(@Param("id") Integer id, @Param("code") String code);

    /**
     * 获取流水号
     * @param para
     * @return
     */
    String selectNum(Map para);

    /**
     * 根据流水号编码查询
     * @param code 流水号类别编码
     * @return
     */
    Map selectByCode(@Param("code") String code);
}
