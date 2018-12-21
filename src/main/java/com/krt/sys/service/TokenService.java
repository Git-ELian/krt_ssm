package com.krt.sys.service;

import com.krt.common.base.BaseService;
import com.krt.sys.entity.Token;

import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 用户token表服务接口层
 * @date 2017年04月28日
 */
public interface TokenService extends BaseService<Token> {

    /**
     * 创建token
     *
     * @param userId
     * @return
     */
    Map<String, Object> createToken(Integer userId);

    /**
     * 更新token
     *
     * @param tokenEntity
     * @param oldToken
     */
    void updateToken(Token tokenEntity, Token oldToken);

    /**
     * 根据accessToken查询token实体
     *
     * @param accessToken
     * @return
     */
    Token selectEntityByAccessToken(String accessToken);

    /**
     * 根据refreshToken查询token实体
     *
     * @param refreshToken
     * @return
     */
    Token selectEntityByRefreshToken(String refreshToken);
}
