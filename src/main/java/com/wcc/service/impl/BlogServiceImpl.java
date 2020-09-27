package com.wcc.service.impl;

import com.wcc.mapper.BlogMapper;
import com.wcc.mapper.CommentMapper;
import com.wcc.pojo.Blog;
import com.wcc.service.BlogService;
import com.wcc.util.StringUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * @program: blog
 * @description: 博客业务层实现类
 * @author: WuChen
 * @create: 2020-09-20 14:30
 */
@Service("blogService")
public class BlogServiceImpl implements BlogService {
    @Resource
    private BlogMapper blogMapper;

    @Resource
    private CommentMapper commentMapper;

    @Override
    public List<Blog> selAllBlogs() {
        return blogMapper.selAllBlogs();
    }

    @Override
    public List<Blog> findBlogList(Map<String, Object> paramMap) {
        if (paramMap.containsKey("title") && paramMap.get("title") != null) {
            paramMap.put("title", StringUtil.formatLike(paramMap.get("title").toString()));
        }
        return blogMapper.findBlogList(paramMap);
    }

    @Override
    public long getBlogCount(Map<String, Object> paramMap) {
        if (paramMap.containsKey("title") && paramMap.get("title") != null) {
            paramMap.put("title", StringUtil.formatLike(paramMap.get("title").toString()));
        }
        return blogMapper.getBlogCount(paramMap);
    }

    @Override
    public Blog selBlogById(Integer id) {
        return blogMapper.selBlogById(id);
    }

    @Override
    public int insBlog(Blog blog) {
        return blogMapper.insBlog(blog);
    }

    @Override
    public int updateBlog(Blog blog) {
        return blogMapper.updateBlog(blog);
    }

    @Override
    public int delBlogByIds(List<Integer> ids) {
        /*TODO:删除博客前，先删除对应的评论数据:
         * 方式一：业务处理
         * 方式二：级联删除（创建表建立外键关联时，添加级联删除关系
         *        例如：foreign key (blogId) references t_blog(id) ON Delete cascade  --级联删除语句
         * */
        commentMapper.delCommentByBlogIds(ids);
        return blogMapper.delBlogByIds(ids);
    }
}
