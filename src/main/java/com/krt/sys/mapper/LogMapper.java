package com.krt.sys.mapper;


import com.krt.common.base.BaseMapper;
import com.krt.sys.entity.Log;

/**
 * @Description: 日志管理映射层
 * @author 殷帅
 * @date 2016年7月19日
 * @version 1.0
 */
public interface LogMapper extends BaseMapper<Log> {

    /**
     * 清空日志
     */
    void deleteAll();

}