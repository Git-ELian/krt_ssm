package com.krt.sys.service.impl;

import com.krt.sys.entity.EmpLog;
import com.krt.sys.mapper.EmpLogMapper;
import com.krt.sys.service.EmpLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


/**
 * @author 匿名
 * @create 2018-12-25 11:37
 * @desc
 **/

@Service
public class EmpLogServiceImpl implements EmpLogService {

    @Autowired
    private EmpLogMapper empLogMapper;


    @Override
    public int addLog(EmpLog log) {
        return empLogMapper.addLog(log);
    }

    @Override
    public int deleteLogById(Integer id) {
        return empLogMapper.deleteLogById(id);
    }

    @Override
    public int updateLog(EmpLog log) {
        return empLogMapper.updateLog(log);
    }

    @Override
    public EmpLog queryById(Integer id) {
        return empLogMapper.queryById(id);
    }

    @Override
    public List<EmpLog> queryAllLog() {
        return empLogMapper.queryAllLog();
    }
}
