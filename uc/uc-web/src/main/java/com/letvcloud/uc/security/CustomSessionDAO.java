package com.letvcloud.uc.security;

import java.io.Serializable;
import java.util.Collection;
import java.util.HashSet;

import com.letvcloud.saas.util.cache.CacheClient;
import com.letvcloud.uc.utils.constant.CacheHeadContant;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.UnknownSessionException;
import org.apache.shiro.session.mgt.eis.AbstractSessionDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 自定义shiro sessionDao，使用cbase实现session共享
 * @author wanghui7
 *
 */
public class CustomSessionDAO extends AbstractSessionDAO{
    private static final Logger logger = LoggerFactory.getLogger(CustomSessionDAO.class);

    @Autowired
    private CacheClient memcachedClient;


    @Override
    public void update(Session session) throws UnknownSessionException {
        logger.debug("更新session,sessionId={},session={}",session.getId(),session);
        String id = (String)session.getId();
        long expireTime = session.getTimeout()/1000;
        memcachedClient.set(getCacheId(id), (int)expireTime, session);
    }

    @Override
    public void delete(Session session) {
        logger.debug("删除session,sessionId={},session={}",session.getId(),session);
        String id = (String)session.getId();
        memcachedClient.delete(getCacheId(id));
    }

    @Override
    public Collection<Session> getActiveSessions() {
        return new HashSet<Session>();
    }

    @Override
    protected Serializable doCreate(Session session) {
        Serializable sessionId = this.generateSessionId(session);
        this.assignSessionId(session, sessionId);
        logger.debug("创建session,sessionId={},session={}",session.getId(),session);
        long expireTime = session.getTimeout()/1000;
        memcachedClient.set(getCacheId(sessionId), (int)expireTime,session);
        return sessionId;
    }

    @Override
    protected Session doReadSession(Serializable sessionId) {
        logger.debug("获取session,sessionId={}",sessionId);
        String id = (String)sessionId;
        return (Session)memcachedClient.get(getCacheId(id));
    }

    private  String getCacheId(Serializable sessionId){
        return CacheHeadContant.SessionPrefix+sessionId;
    }
}
