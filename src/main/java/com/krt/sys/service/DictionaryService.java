package com.krt.sys.service;

import com.krt.common.base.BaseService;
import com.krt.sys.entity.Dictionary;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 字典表服务接口层
 * @date 2017年04月11日
 */
public interface DictionaryService extends BaseService<Dictionary> {


    /**
     * 检测字典代码是否重复
     *
     * @param type 字典类型
     * @param code 字典代码
     * @param id
     * @return
     */
    Integer checkCode(String type, String code, Integer id);

    /**
     * 根据pid 和 type查询字典
     *
     * @param pid
     * @param type
     * @return
     */
    List selectDicByPidAndType(Integer pid, String type);

    /**
     * type查询字典
     *
     * @param type
     * @return
     */
    List selectDicByType(String type);

    /**
     * 根据code查询实体
     *
     * @param code
     * @return
     */
    Dictionary selectEntityByCode(String code);
}
