package com.krt.sys.controller;

import com.google.common.collect.Lists;
import com.krt.common.annotation.KrtLog;
import com.krt.common.base.BaseController;
import com.krt.common.bean.ReturnBean;
import com.krt.common.util.DateUtils;
import com.krt.common.util.PrettyMemoryUtils;
import lombok.extern.slf4j.Slf4j;
import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;
import net.sf.ehcache.statistics.LiveCacheStatistics;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.ehcache.EhCacheCacheManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * @author 殷帅
 * @version 1.0
 * @Description:
 * @date 2017年05月24日
 */
@Slf4j
@Controller
public class  EhcacheController extends BaseController {

   @Autowired
    private EhCacheCacheManager ehCacheCacheManager;

    /**
     * 缓存管理
     * @return
     */
    @RequiresPermissions("sys:ehcache:list")
    @GetMapping("sys/ehcache/list")
    public String list() {
        CacheManager cacheManager = ehCacheCacheManager.getCacheManager();
        List list = new ArrayList();
        String[] cacheNames = cacheManager.getCacheNames();
        for(String cacheName:cacheNames){
            Cache cache = cacheManager.getCache(cacheName);
            //缓存统计
            cache.setStatisticsEnabled(true);
            Map map = new HashMap(9);
            LiveCacheStatistics statistics =  cache.getLiveCacheStatistics();
            map.put("cacheName",cacheName);
            map.put("cacheHitCount",statistics.getCacheHitCount());
            map.put("cacheMissCount",statistics.getCacheMissCount());
            Long  totalCount= statistics.getCacheHitCount()+statistics.getCacheMissCount();
            totalCount =  totalCount >0?totalCount:1;
            map.put("totalCount",totalCount);
            map.put("cacheHitPercent",String.format("%.2f", Double.valueOf(statistics.getCacheHitCount()*100/totalCount)));
            map.put("localHeapCount",statistics.getLocalHeapSize());
            map.put("localDiskCount",statistics.getLocalDiskSize());
            map.put("localHeapSize", PrettyMemoryUtils.prettyByteSize(cache.getLiveCacheStatistics().getLocalHeapSizeInBytes()));
            map.put("localDiskSize", PrettyMemoryUtils.prettyByteSize(cache.getLiveCacheStatistics().getLocalDiskSizeInBytes()));
            list.add(map);
        }

        request.setAttribute("list", list);
        return "sys/ehcache/list";
    }

    /**
     * 缓存详情
     * @param cacheName
     * @return
     */
    @RequiresPermissions("sys:cache:cacheNameDetail")
    @GetMapping("sys/ehcache/cacheNameDetail")
    public String cacheNameDetail(String cacheName) {
        CacheManager cacheManager = ehCacheCacheManager.getCacheManager();
        List<Object> nonExpiryKeys = cacheManager.getCache(cacheName).getKeys();
        List<Object> caches = Lists.newArrayList();
        for (Object key : nonExpiryKeys) {
            Element element = cacheManager.getCache(cacheName).get(key);
            Map map = new HashMap(10);
            map.put("key",key);
            map.put("objectValue", element.getObjectValue());
            map.put("size", PrettyMemoryUtils.prettyByteSize(element.getSerializedSize()));
            map.put("hitCount", element.getHitCount());
            Date latestOfCreationAndUpdateTime = new Date( element.getLatestOfCreationAndUpdateTime());
            map.put("latestOfCreationAndUpdateTime", DateUtils.dateToString("yyyy-MM-dd HH:mm:ss",latestOfCreationAndUpdateTime));
            Date lastAccessTime = new Date(element.getLastAccessTime());
            map.put("lastAccessTime",  DateUtils.dateToString("yyyy-MM-dd HH:mm:ss",lastAccessTime));
            if(element.getExpirationTime() == Long.MAX_VALUE) {
                map.put("expirationTime", "不过期");
            } else {
                Date expirationTime = new Date(element.getExpirationTime());
                map.put("expirationTime",  DateUtils.dateToString("yyyy-MM-dd HH:mm:ss",expirationTime));
            }
            map.put("timeToIdle", element.getTimeToIdle());
            map.put("timeToLive", element.getTimeToLive());
            map.put("version", element.getVersion());
            caches.add(map);
        }
        request.setAttribute("caches", caches);
        request.setAttribute("cacheName", cacheName);
        return "sys/ehcache/cacheNameDetail";
    }

    /**
     * 删除缓存
     * @param cacheName
     * @param key
     * @return
     */
    @KrtLog(description = "删除缓存")
    @RequiresPermissions("sys:cache:delete")
    @PostMapping("sys/ehcache/delete")
    @ResponseBody
    public ReturnBean delete(String cacheName, String key) {
        CacheManager cacheManager = ehCacheCacheManager.getCacheManager();
        Cache cache = cacheManager.getCache(cacheName);
        //删除单个缓存
        if(key!=null && !"".equals(key)) {
            cache.remove(key);
        }else{
            //删除单类缓存
            cache.removeAll();
        }
        return ReturnBean.ok();
    }

    /**
     * 清空系统缓存
     * @return
     */
    @KrtLog(description = "清空系统缓存")
    @RequiresPermissions("sys:cache:deleteAll")
    @PostMapping("sys/ehcache/deleteAll")
    @ResponseBody
    public ReturnBean deleteAll() {
        CacheManager cacheManager = ehCacheCacheManager.getCacheManager();
        cacheManager.clearAll();
        return ReturnBean.ok();
    }


}
