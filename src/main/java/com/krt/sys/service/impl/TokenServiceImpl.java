package com.krt.sys.service.impl;

import com.krt.common.base.BaseServiceImpl;
import com.krt.common.util.DateUtils;
import com.krt.common.util.Md5Utils;
import com.krt.common.util.RandomUtils;
import com.krt.sys.entity.Token;
import com.krt.sys.mapper.TokenMapper;
import com.krt.sys.service.TokenService;
import org.springframework.aop.framework.AopContext;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.Caching;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 用户token表服务实现层
 * @date 2017年04月28日
 */
@Service
public class TokenServiceImpl extends BaseServiceImpl<TokenMapper, Token> implements TokenService {

    /**
     * 12小时后过期
     */
    private final static int EXPIRE = 3600 * 12;

    /**
     * 创建token
     *
     * @param userId
     * @return
     */
    @Override
    public Map<String, Object> createToken(Integer userId) {
        //生成一个token
        String accessToken = Md5Utils.encoderByMd5With32Bit(userId + DateUtils.dateToString("yyyyMMddHHmmsss", new Date()) + RandomUtils.getRandomStr(1));
        String refreshToken = Md5Utils.encoderByMd5With32Bit(userId + DateUtils.dateToString("yyyyMMddHHmmsss", new Date()) + RandomUtils.getRandomStr(2));
        //当前时间
        Date now = new Date();
        //过期时间
        Date expireTime = new Date(now.getTime() + EXPIRE * 1000);
        //判断是否生成过token
        Token tokenEntity = baseMapper.selectEntityByUserId(userId);
        if (tokenEntity == null) {
            tokenEntity = new Token();
            tokenEntity.setUserId(userId);
            tokenEntity.setAccessToken(accessToken);
            tokenEntity.setRefreshToken(refreshToken);
            tokenEntity.setInsertTime(now);
            tokenEntity.setUpdateTime(now);
            tokenEntity.setExpireTime(expireTime);
            //保存token
            insert(tokenEntity);
        } else {
            //删除缓存
            Token oldToken = tokenEntity;
            tokenEntity.setId(tokenEntity.getId());
            tokenEntity.setAccessToken(accessToken);
            tokenEntity.setRefreshToken(refreshToken);
            tokenEntity.setExpireTime(expireTime);
            tokenEntity.setUpdateTime(now);
            //更新token
            ((TokenServiceImpl) AopContext.currentProxy()).updateToken(tokenEntity, oldToken);
        }
        Map<String, Object> map = new HashMap<>(2);
        map.put("accessToken", accessToken);
        map.put("refreshToken", refreshToken);
        map.put("expire", EXPIRE);
        return map;
    }

    /**
     * 更新token
     *
     * @param tokenEntity
     * @param oldToken
     */
    @Caching(
            evict = {
                    @CacheEvict(value = "accessTokenCache", key = "#oldToken.accessToken"),
                    @CacheEvict(value = "refreshTokenCache", key = "#oldToken.refreshToken")
            }
    )
    @Override
    public void updateToken(Token tokenEntity, Token oldToken) {
        super.update(tokenEntity);

    }

    /**
     * 根据accessToken查询token实体
     *
     * @param accessToken
     * @return
     */
    @Override
    @Cacheable(value = "accessTokenCache", key = "#accessToken", unless = "#result == null")
    public Token selectEntityByAccessToken(String accessToken) {
        return baseMapper.selectEntityByAccessToken(accessToken);
    }

    /**
     * 根据refreshToken查询token实体
     *
     * @param refreshToken
     * @return
     */
    @Override
    @Cacheable(value = "refreshTokenCache", key = "#refreshToken", unless = "#result == null")
    public Token selectEntityByRefreshToken(String refreshToken) {
        return baseMapper.selectEntityByRefreshToken(refreshToken);
    }
}
