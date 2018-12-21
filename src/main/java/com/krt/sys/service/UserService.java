package com.krt.sys.service;

import com.krt.common.base.BaseService;
import com.krt.sys.entity.User;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: 用户服务接口层
 * @date 2017年03月29日
 */
public interface UserService extends BaseService<User>{

    /**
     * 根据用户名查询用户
     *
     * @param username
     * @return
     */
    User selectByUsername(String username);

    /**
     * 检测用户账号是否重复
     *
     * @param username
     * @param id
     * @return
     */
    Integer checkUsername(String username, Integer id);
}
