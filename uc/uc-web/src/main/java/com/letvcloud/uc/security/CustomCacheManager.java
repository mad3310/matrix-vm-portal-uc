package com.letvcloud.uc.security;


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
	private CacheClient client;
	private int expireTime;

    public CacheClient getClient() {
        return client;
    }

    public void setClient(CacheClient client) {
        this.client = client;
    }

    public int getExpireTime() {
        return expireTime;
    }

    public void setExpireTime(int expireTime) {
		this.expireTime = expireTime;
	}

	@Override
	public <K, V> Cache<K, V> getCache(String name) throws CacheException {
		return new CustomCacheImpl<K,V>(name,client,expireTime);
	}
}
