package com.krt.common.base;

import com.krt.common.bean.DataTable;

import java.util.List;
import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 抽取公共服务层接口
 * @date 2016年7月16日
 */
public interface BaseService<T> {
    /**
     * 插入
     *
     * @param entity
     * @return
     */
    Integer insert(T entity);

    /**
     * 批量插入
     *
     * @param entityList
     * @return
     */
    Integer insertBatch(List<T> entityList);

    /**
     * 根据id删除
     *
     * @param id
     */
    void delete(Integer id);

    /**
     * 根据ids删除
     *
     * @param ids
     */
    void deleteByIds(String ids);

    /**
     * 更新
     *
     * @param entity
     * @throws Exception
     */
    void update(T entity);

    /**
     * 根据id查询
     *
     * @param id
     * @return
     */
    Map selectById(Integer id);

    /**
     * 根据id查询实体
     *
     * @param id
     * @return
     */
    T selectEntityById(Integer id);

    /**
     * 查询全部
     *
     * @return
     */
    List selectAll();


    /**
     * 分页
     *
     * @param para 参数
     * @return
     */
    DataTable selectList(Map para);

}
