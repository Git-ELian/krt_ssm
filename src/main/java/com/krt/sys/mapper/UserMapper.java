package com.krt.sys.mapper;

import com.krt.common.base.BaseMapper;
import com.krt.sys.entity.User;
import org.apache.ibatis.annotations.Param;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 用户映射层
 * @date 2017年03月9:44日
 */
public interface UserMapper extends BaseMapper<User> {

    /**
     * 根据用户名查询用户
     * @param username
     * @return
     */
    User selectByUsername(@Param("username") String username);

    /**
     * 检测用户名称
     * @param username
     * @param id
     * @return
     */
    Integer checkUsername(@Param("username") String username, @Param("id") Integer id);
}
