package com.letvcloud.uc.security;

import java.util.Collection;
import java.util.Set;

import com.letvcloud.saas.util.cache.CacheClient;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 自定义shiro cache，使用cbase缓存认证和授权信息
 * @author wanghui7
 *
 * @param <K>
 * @param <V>
 */
public class CustomCacheImpl<K, V> implements Cache<K, V>{
	private static final Logger logger = LoggerFactory.getLogger(CustomCacheImpl.class);
	
	private String name;
	private int expireTime;
	private CacheClient memcachedClient;

	public CustomCacheImpl(String name, CacheClient cache, int expireTime){
		this.name = name;
		this.memcachedClient = cache;
		this.expireTime = expireTime;
	}

	@SuppressWarnings("unchecked")
	@Override
	public V get(K key) throws CacheException {
		logger.debug("获取缓存对象，key={}",getCacheKey(key));
		try {
			return (V)memcachedClient.get(getCacheKey(key));
		}catch(Exception e) {
			logger.error("获取缓存对象失败",e);
			throw new CacheException(e);
		}
	}

	@Override
	public V put(K key, V value) throws CacheException {
		logger.debug("保存缓存对象，key={}",getCacheKey(key));
		try {
			memcachedClient.set(getCacheKey(key),expireTime, value);
			return value;
		}catch(Exception e) {
			logger.error("保存缓存对象失败",e);
			throw new CacheException(e);
		}
	}

	@Override
	public V remove(K key) throws CacheException {
		logger.debug("删除缓存对象，key={}",getCacheKey(key));
		try {
			V v = get(key);
			memcachedClient.delete(getCacheKey(key));
			return v;
		}catch(Exception e) {
			logger.error("删除缓存对象失败",e);
			throw new CacheException(e);
		}
	}

	@Override
	public void clear() throws CacheException {
		logger.debug("删除所有缓存对象");
	}

	@Override
	public int size() {
		return 0;
	}

	@Override
	public Set<K> keys() {
		return null;
	}

	@Override
	public Collection<V> values() {
		return null;
	}
	
	private String getCacheKey(K key) {
		return SecurityConstants.CACHE_KEY_SUFFIX+"."+name+"."+key;
	}
}
