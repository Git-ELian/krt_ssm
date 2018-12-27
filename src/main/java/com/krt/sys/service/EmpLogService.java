package com.krt.sys.service;

import com.krt.sys.entity.EmpLog;

import java.util.List;

/**
 * @author 匿名
 * @create 2018-12-25 11:20
 * @desc
 **/

public interface EmpLogService {

    int addLog(EmpLog log);

    int deleteLogById(Integer id);

    int updateLog(EmpLog log);

    EmpLog queryById(Integer id);

    List<EmpLog> queryAllLog();
}
