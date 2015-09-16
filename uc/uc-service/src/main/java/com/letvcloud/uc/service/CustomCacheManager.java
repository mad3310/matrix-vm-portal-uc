package com.letvcloud.uc.service;


import com.letvcloud.saas.util.cache.CacheClient;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.apache.shiro.cache.CacheManager;
import org.springframework.beans.factory.annotation.Autowired;


/**
 * 自定义shiro cacheManager，使用cbase缓存认证和授权信息
 * @author wanghui7
 *
 */
public class CustomCacheManager implements CacheManager{
    @Autowired
    private CacheClient cacheClient;
	private int expireTime;

    public CacheClient getCacheClient() {
        return cacheClient;
    }

    public void setCacheClient(CacheClient cacheClient) {
        this.cacheClient = cacheClient;
    }

    public void setExpireTime(int expireTime) {
		this.expireTime = expireTime;
	}

	@Override
	public <K, V> Cache<K, V> getCache(String name) throws CacheException {
		return new CustomCacheImpl<K,V>(name,cacheClient,expireTime);
	}
}
