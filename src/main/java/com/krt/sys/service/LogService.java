package com.krt.sys.service;

import com.krt.common.base.BaseService;
import com.krt.sys.entity.Log;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 日志服务接口层
 * @date 2017年03月29日
 */
public interface LogService extends BaseService<Log> {

    /**
     * 清空日志
     */
    void deleteAll();

}
