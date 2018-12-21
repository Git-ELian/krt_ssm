package com.krt.common.base;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.krt.common.bean.DataTable;
import com.krt.common.constant.SysConstant;
import com.krt.common.validator.Assert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 公共抽取服务层的实现
 * @date 2016年7月16日
 */
public abstract class BaseServiceImpl<M extends BaseMapper<T>, T extends BaseEntity> implements BaseService<T> {


    @Autowired
    protected M baseMapper;

    /**
     * 插入
     *
     * @param entity
     * @return
     */
    @Override
    public Integer insert(T entity) {
        entity.preInsert();
        baseMapper.insert(entity);
        return entity.getId();
    }

    /**
     * 批量插入
     *
     * @param entityList
     * @return
     */
    @Override
    public Integer insertBatch(List<T> entityList) {
        for (T entity : entityList) {
            entity.preInsert();
        }
        return baseMapper.insertBatch(entityList);
    }

    /**
     * 根据id删除
     *
     * @param id
     */
    @Override
    public void delete(Integer id) {
        baseMapper.delete(id);
    }

    /**
     * 根据ids批量删除
     *
     * @param idsStr
     */
    @Override
    public void deleteByIds(String idsStr) {
        if (!Assert.isEmpty(idsStr)) {
            String[] ids = idsStr.split(",");
            baseMapper.deleteByIds(ids);
        }
    }

    /**
     * 更新
     *
     * @param entity
     * @throws Exception
     */
    @Override
    public void update(T entity) {
        entity.preUpdate();
        entity.setUpdateTime(new Date());
        baseMapper.update(entity);
    }

    /**
     * 根据id查询
     *
     * @param id
     * @return
     */
    @Override
    public Map selectById(Integer id) {
        return baseMapper.selectById(id);
    }

    /**
     * 根据id查询实体
     *
     * @param id
     * @return
     */
    @Override
    public T selectEntityById(Integer id) {
        return baseMapper.selectEntityById(id);
    }


    /**
     * 查询全部
     *
     * @return
     */
    @Override
    public List selectAll() {
        return baseMapper.selectAll();
    }

    /**
     * 分页
     *
     * @return
     */
    @Override
    public DataTable selectList(Map para) {
        DataTable dataTable = new DataTable();
        // 下面两句要连着写在一起，就可以实现分页
        dataTable.setLength(Integer.valueOf(para.get(SysConstant.LENGTH).toString()));
        dataTable.setPageNum(Integer.valueOf(para.get(SysConstant.START).toString()));
        PageHelper.startPage(dataTable.getPageNum(), dataTable.getLength());
        List<Map> list = baseMapper.selectList(para);
        // 下面这句是为了获取分页信息，比如记录总数等等
        PageInfo<Map> pageInfo = new PageInfo(list);
        dataTable.setData(list);
        dataTable.setRecordsFiltered(pageInfo.getTotal());
        return dataTable;
    }


}