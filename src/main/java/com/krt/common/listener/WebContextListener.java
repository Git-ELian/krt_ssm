package com.krt.common.listener;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.context.WebApplicationContext;
import javax.servlet.ServletContext;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 上下文监听器
 * @date 2018年5月2日
 */
@Slf4j
public class WebContextListener extends org.springframework.web.context.ContextLoaderListener {

    @Override
    public WebApplicationContext initWebApplicationContext(ServletContext servletContext) {
        log.debug("==========================================================");
        log.debug("                    科睿特通用开发平台                      ");
        log.debug("==========================================================");
        return super.initWebApplicationContext(servletContext);
    }
}

