package com.krt.common.cache;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.apache.shiro.dao.DataAccessException;
import org.apache.shiro.session.Session;
import org.apache.shiro.util.CollectionUtils;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;

import java.util.*;
import java.util.concurrent.TimeUnit;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: redis实现shiro的cache接口
 * @date 2017年07月8日
 */
public class RedisShiroCache<K, V> implements Cache<K, V> {

    private RedisTemplate<K, V> redisTemplate;

    private String keyPrefix;

    /**
     * 获取缓存
     *
     * @param name
     * @return
     */
    public void getCache(String name) {
        this.keyPrefix = name + ":";
    }

    @Override
    public V get(K key) throws CacheException {
        if (key.toString().startsWith(keyPrefix)) {
            return redisTemplate.opsForValue().get(key);
        } else {
            return redisTemplate.opsForValue().get(getKey(key));
        }
    }

    @Override
    public V put(K key, V value) throws CacheException {
        if (value instanceof Session) {
            redisTemplate.opsForValue().set(getKey(key), value, ((Session) value).getTimeout() / 1000, TimeUnit.SECONDS);
        } else {
            redisTemplate.opsForValue().set(getKey(key), value);
        }
        return value;
    }

    @Override
    public V remove(K key) throws CacheException {
        V value = redisTemplate.opsForValue().get(getKey(key));
        redisTemplate.delete(getKey(key));
        return value;
    }

    @Override
    public void clear() throws CacheException {
        redisTemplate.execute(new RedisCallback() {
            @Override
            public String doInRedis(RedisConnection connection) throws DataAccessException {
                connection.flushDb();
                return "ok";
            }
        });
    }

    @Override
    public int size() {
        Long count = (Long) redisTemplate.execute(new RedisCallback() {
            @Override
            public Long doInRedis(RedisConnection connection) throws DataAccessException {
                return connection.dbSize();
            }
        });
        return count.intValue();
    }

    @Override
    public Set<K> keys() {
        return redisTemplate.keys((K) (this.keyPrefix + "*"));
    }

    @Override
    public Collection<V> values() {
        Set<K> keys = redisTemplate.keys((K) (this.keyPrefix + "*"));
        if (!CollectionUtils.isEmpty(keys)) {
            List<V> values = new ArrayList<V>(keys.size());
            for (K key : keys) {
                V value = get((K) key);
                if (value != null && value instanceof Session) {
                    values.add(value);
                }
            }
            return Collections.unmodifiableList(values);
        } else {
            return Collections.emptyList();
        }
    }

    /**
     * 获取key
     *
     * @param key
     * @return
     */
    public K getKey(K key) {
        return (K) (keyPrefix + key);
    }


    /**
     * set注入
     *
     * @param redisTemplate
     */
    public void setRedisTemplate(RedisTemplate<K, V> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }
}
