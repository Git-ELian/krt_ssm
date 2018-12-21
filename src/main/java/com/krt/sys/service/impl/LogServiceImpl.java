package com.krt.sys.service.impl;

import com.krt.common.base.BaseServiceImpl;
import com.krt.sys.entity.Log;
import com.krt.sys.mapper.LogMapper;
import com.krt.sys.service.LogService;
import org.springframework.stereotype.Service;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 日志服务实现层
 * @date 2017年03月29日
 */
@Service
public class LogServiceImpl extends BaseServiceImpl<LogMapper, Log> implements LogService {

    /**
     * 清空日志
     */
    @Override
    public void deleteAll() {
        baseMapper.deleteAll();
    }

}
