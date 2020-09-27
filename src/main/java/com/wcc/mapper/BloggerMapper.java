package com.wcc.mapper;

import com.wcc.pojo.Blog;
import com.wcc.pojo.Blogger;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.transaction.annotation.Transactional;

/**
 * @program: blog
 * @description: 博客账户数据访问层接口
 * @author: WuChen
 * @create: 2020-09-17 16:32
 */
public interface BloggerMapper {

    /**
     * 根据用户名获取账户信息
     *
     * @param userName 用户名
     * @return 博客账户
     */
    Blogger getByUserName(@Param("userName") String userName);

    /**
     * 根据主键获取博客账户对象
     *
     * @param id 主键
     * @return 博客对象
     */
    Blogger findById(@Param("id") Integer id);

    /**
     * 修改账户信息
     *
     * @param blogger 账户
     * @return
     */
    @Transactional
    int updBloggerInfo(Blogger blogger);
}
