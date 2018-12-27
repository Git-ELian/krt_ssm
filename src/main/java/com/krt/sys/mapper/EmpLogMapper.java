package com.krt.sys.mapper;

import com.krt.sys.entity.EmpLog;

import java.util.List;

/**
 * @author 匿名
 * @create 2018-12-25 10:16
 * @desc
 **/
public interface EmpLogMapper {
    int addLog(EmpLog log);

    int deleteLogById(Integer id);

    int updateLog(EmpLog log);

    EmpLog queryById(Integer id);

    List<EmpLog> queryAllLog();

}
