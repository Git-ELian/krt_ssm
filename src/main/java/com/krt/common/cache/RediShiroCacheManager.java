package com.krt.common.cache;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.apache.shiro.cache.CacheManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 实现shiro的缓存管理
 * @date 2017年07月8日
 */
public class RediShiroCacheManager implements CacheManager {

    private RedisShiroCache redisShiroCache;

    @Override
    public <K, V> Cache<K, V> getCache(String name) throws CacheException {
        redisShiroCache.getCache(name);
        return redisShiroCache;
    }


    /**
     * set注入
     *
     * @param redisShiroCache
     */
    public void setRedisShiroCache(RedisShiroCache redisShiroCache) {
        this.redisShiroCache = redisShiroCache;
    }
}
