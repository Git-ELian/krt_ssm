package com.krt.sys.service.impl;

import com.krt.common.bean.DataTable;
import com.krt.common.util.ShiroUtils;
import com.krt.sys.entity.UserOnline;
import com.krt.sys.service.SessionService;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: session管理服务实现层
 * @date 2017年10月25日
 */
@Service
public class SessionServiceImpl implements SessionService{

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    
    @Resource
    private SessionDAO sessionDAO;

    /**
     * 获取在线session信息
     * @param para
     * @return
     */
    @Override
    public DataTable selectList(Map para) {
        List<UserOnline> list = new ArrayList<>();
        Collection<Session> sessions = sessionDAO.getActiveSessions();
        Session currentSession = ShiroUtils.getSession();
        for (Session session : sessions) {
            UserOnline userOnline = new UserOnline();
            SimplePrincipalCollection principalCollection;
            if (session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY) == null) {
                logger.debug("PRINCIPALS_SESSION_KEY----------空");
                continue;
            } else {
                principalCollection = (SimplePrincipalCollection) session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
            }
            String username = (String) principalCollection.getPrimaryPrincipal();
            userOnline.setUsername(username);
            userOnline.setId((String)session.getId());
            userOnline.setHost(session.getHost());
            userOnline.setStartTimestamp(session.getStartTimestamp());
            userOnline.setLastAccessTime(session.getLastAccessTime());
            userOnline.setTimeout(session.getTimeout());
            if(currentSession.getId().equals(session.getId())){
                userOnline.setSelf(true);
            }else{
                userOnline.setSelf(false);
            }
            list.add(userOnline);
        }
        DataTable dataTable = new DataTable();
        dataTable.setData(list);
        dataTable.setRecordsFiltered(Long.valueOf(list.size()));
        return dataTable;
    }

    /**
     * 获取session
     *
     * @param sessionId
     * @return
     */
    @Override
    public Session getSessionById(String sessionId){
        Collection<Session> sessions = sessionDAO.getActiveSessions();
        for(Session session : sessions){
            if( sessionId.equals(session.getId())){
                return session;
            }
        }
        return null;
    }

    /**
     * 踢出用户
     *
     * @param sessionId
     */
    @Override
    public void deleteUser(String sessionId){
        Session session = getSessionById(sessionId);
        if(session!=null) {
            sessionDAO.delete(session);
        }
    }

    /**
     * 批量踢出用户
     *
     * @param sessionIds
     */
    @Override
    public void deleteUsers(String sessionIds){
        String[] sessionIdArr = sessionIds.split(",");
        for(String sessionId:sessionIdArr){
            deleteUser(sessionId);
        }
    }
}
