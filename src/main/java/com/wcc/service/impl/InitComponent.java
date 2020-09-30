package com.wcc.service.impl;

import com.wcc.pojo.Blog;
import com.wcc.pojo.BlogType;
import com.wcc.pojo.Blogger;
import com.wcc.pojo.Link;
import com.wcc.service.BlogService;
import com.wcc.service.BlogTypeService;
import com.wcc.service.BloggerService;
import com.wcc.service.LinkService;
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
        //博客类别
        BlogTypeService blogTypeService = applicationContext.getBean("blogTypeService", BlogTypeService.class);
        List<BlogType> blogTypes = blogTypeService.selAllBlogType();
        application.setAttribute(Const.RESOURCE_PARAM_BLOG_TYPE_LIST_NAME, blogTypes);
        //博主信息
        BloggerService bloggerService = applicationContext.getBean("bloggerService", BloggerService.class);
        Blogger blogger = bloggerService.findBloggerAdmin();
        blogger.setPassword(null);
        application.setAttribute(Const.RESOURCE_PARAM_BLOGGER_NAME, blogger);
        //按年月分类的博客数量
        BlogService blogService = applicationContext.getBean("blogService", BlogService.class);
        List<Blog> blogs = blogService.selAllBlogs();
        application.setAttribute(Const.RESOURCE_PARAM_BLOG_COUNT_LIST, blogs);
        //友情链接
        LinkService linkService = applicationContext.getBean("linkService", LinkService.class);
        List<Link> allLink = linkService.getAllLink();
        application.setAttribute(Const.RESOURCE_PARAM_LINK_LIST, allLink);

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
