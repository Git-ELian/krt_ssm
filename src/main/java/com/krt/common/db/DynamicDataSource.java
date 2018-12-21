package com.krt.common.db;

import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 多数据源工具类
 * @date 2017年07月06日
 */
public class DynamicDataSource extends AbstractRoutingDataSource {

    /**
     * 取得当前使用那个数据源
     *
     * @return
     */
    @Override
    protected Object determineCurrentLookupKey() {
        return DbContextHolder.getDbType();
    }
}
