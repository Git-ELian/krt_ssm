package com.krt.sys.mapper;

import com.krt.common.base.BaseMapper;
import com.krt.sys.entity.Token;
import org.apache.ibatis.annotations.Param;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: 用户token表映射层
 * @date 2017年04月28日
 */
public interface TokenMapper extends BaseMapper<Token> {

    /**
     * 根据token查询token实体
     *
     * @param accessToken
     * @return
     */
    Token selectEntityByAccessToken(@Param("accessToken") String accessToken);

    /**
     * 根据refreshToken查询token实体
     *
     * @param refreshToken
     * @return
     */
    Token selectEntityByRefreshToken(@Param("refreshToken") String refreshToken);

    /**
     * 根据用户id查询token
     *
     * @param userId
     * @return
     */
    Token selectEntityByUserId(@Param("userId") Integer userId);
}
