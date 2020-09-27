package com.wcc.service.impl;

import com.wcc.mapper.BloggerMapper;
import com.wcc.pojo.Blogger;
import com.wcc.service.BloggerService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @program: blog
 * @description: 博客账户业务层实现类
 * @author: WuChen
 * @create: 2020-09-17 21:41
 */
@Service("bloggerService")
public class BloggerServiceImpl implements BloggerService {

    @Autowired
    private BloggerMapper bloggerMapper;

    @Override
    public Blogger getByUserName(String userName) {
        return bloggerMapper.getByUserName(userName);
    }

    @Override
    public int updBloggerInfo(Blogger blogger) {
        /*TODO:修改了信息之后需要重新设置session中保存的数据*/
        SecurityUtils.getSubject().getSession().setAttribute("currentUser", blogger);
        return bloggerMapper.updBloggerInfo(blogger);
    }

    @Override
    public int updBloggerPassword(Blogger blogger) {
        return bloggerMapper.updBloggerInfo(blogger);
    }
}
