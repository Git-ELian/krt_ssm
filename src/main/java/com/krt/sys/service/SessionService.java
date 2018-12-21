package com.krt.sys.service;

import com.krt.common.bean.DataTable;
import com.krt.common.util.ShiroUtils;
import com.krt.sys.entity.UserOnline;
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
 * @Description: session管理服务接口层
 * @date 2017年10月25日
 */
public interface SessionService {

    /**
     * 获取在线session信息
     *
     * @param para
     * @return
     */
    DataTable selectList(Map para);

    /**
     * 获取session
     *
     * @param sessionId
     * @return
     */
    Session getSessionById(String sessionId);

    /**
     * 踢出用户
     *
     * @param sessionId
     */
    void deleteUser(String sessionId);

    /**
     * 批量踢出用户
     *
     * @param sessionIds
     */
    void deleteUsers(String sessionIds);
}
