package com.krt.common.shiro;

import com.krt.common.util.ServletUtils;
import com.krt.common.util.StringUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.UnknownSessionException;
import org.apache.shiro.session.mgt.eis.CachingSessionDAO;
import org.apache.shiro.session.mgt.eis.EnterpriseCacheSessionDAO;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.util.Collection;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: redis 接管 shiro Session
 * @date 2017年07月08日
 */
public class RedisSessionDAO extends EnterpriseCacheSessionDAO implements SessionDAO {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Override
    protected void doUpdate(Session session) {
        if (session == null || session.getId() == null) {
            return;
        }
        HttpServletRequest request = ServletUtils.getRequest();
        if (request != null) {
            String uri = request.getServletPath();
            // 如果是静态文件，则不更新SESSION
            if (ServletUtils.isStaticFile(uri)) {
                return;
            }
        }
        createActiveSessionsCache().put(session.getId(), session);
    }

    @Override
    protected void doDelete(Session session) {
        if (session == null || session.getId() == null) {
            return;
        }
        createActiveSessionsCache().remove(session.getId());

    }

    @Override
    protected Serializable doCreate(Session session) {
        HttpServletRequest request = ServletUtils.getRequest();
        if (request != null) {
            String uri = request.getServletPath();
            // 如果是静态文件，则不创建SESSION
            if (ServletUtils.isStaticFile(uri)) {
                return null;
            }
        }
        Serializable sessionId = generateSessionId(session);
        assignSessionId(session, sessionId);
        if (session == null || session.getId() == null) {
            logger.debug("session不存在");
        } else {
            //保存session
            createActiveSessionsCache().put(sessionId, session);
        }
        return sessionId;
    }

    @Override
    public Session readSession(Serializable sessionId) throws UnknownSessionException {
        HttpServletRequest request = ServletUtils.getRequest();
        if (request != null) {
            String uri = request.getServletPath();
            // 如果是静态文件，则不获取SESSION
            if (ServletUtils.isStaticFile(uri)) {
                return null;
            }
        }
        return super.readSession(sessionId);
    }

    @Override
    protected Session doReadSession(Serializable sessionId) {
        return super.doReadSession(sessionId);
    }

    @Override
    public Collection<Session> getActiveSessions() {
        return createActiveSessionsCache().values();
    }
}