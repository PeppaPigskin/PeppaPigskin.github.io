package com.wcc.service;

import com.wcc.pojo.Blog;
import com.wcc.pojo.Blogger;
import org.apache.ibatis.annotations.Param;

/**
 * @program: blog
 * @description: 博客账户业务层接口
 * @author: WuChen
 * @create: 2020-09-17 21:38
 */
public interface BloggerService {

    /**
     * 根据用户名获取账户信息
     *
     * @param userName 用户名
     * @return
     */
    Blogger getByUserName(String userName);


    /**
     * 更新账户信息
     *
     * @param blogger 账户信息
     * @return 操作结果
     */
    int updBloggerInfo(Blogger blogger);

    /**
     * 修改账户密码
     *
     * @param blog 账户信息
     * @return 操作结果
     */
    int updBloggerPassword(Blogger blogger);

}
