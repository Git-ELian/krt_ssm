package com.krt.sys.service.impl;

import com.krt.common.base.BaseServiceImpl;
import com.krt.sys.entity.User;
import com.krt.sys.mapper.UserMapper;
import com.krt.sys.service.UserService;
import org.springframework.stereotype.Service;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 用户服务实现层
 * @date 2017年03月29日
 */
@Service
public class UserServiceImpl extends BaseServiceImpl<UserMapper, User> implements UserService {

    /**
     * 根据用户名查询用户
     *
     * @param username
     * @return
     */
    @Override
    public User selectByUsername(String username) {
        return baseMapper.selectByUsername(username);
    }

    /**
     * 检测用户账号是否重复
     *
     * @param username
     * @param id
     * @return
     */
    @Override
    public Integer checkUsername(String username, Integer id) {
        return baseMapper.checkUsername(username, id);
    }


}
