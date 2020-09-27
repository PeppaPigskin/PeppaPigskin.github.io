package com.wcc.service.impl;

import com.wcc.pojo.BlogType;
import com.wcc.service.BlogTypeService;
import com.wcc.util.ConstantsUtil.Const;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.List;

/**
 * @program: blog
 * @description: 用于进行服务器加载时的数据缓存
 * @author: WuChen
 * @create: 2020-09-17 11:29
 */
@Component
public class InitComponent implements ServletContextListener, ApplicationContextAware {

    private static ApplicationContext applicationContext;

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        ServletContext application = servletContextEvent.getServletContext();
        BlogTypeService blogTypeService = applicationContext.getBean("blogTypeService", BlogTypeService.class);
        List<BlogType> blogTypes = blogTypeService.selAllBlogType();
        application.setAttribute(Const.RESOURCE_PARAM_BLOG_TYPE_LIST_NAME, blogTypes);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }

    /**
     * @param applicationContext
     * @throws BeansException
     */
    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }
}
