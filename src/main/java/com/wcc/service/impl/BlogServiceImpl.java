package com.wcc.service.impl;

import com.wcc.mapper.BlogMapper;
import com.wcc.mapper.CommentMapper;
import com.wcc.pojo.Blog;
import com.wcc.service.BlogService;
import com.wcc.util.DateUtil;
import com.wcc.util.StringUtil;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
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
        if (paramMap != null) {
            //TODO:转换为模糊查询
            if (paramMap.containsKey("title") && paramMap.get("title") != null) {
                paramMap.put("title", StringUtil.formatLike(paramMap.get("title").toString()));
            }
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

    @Override
    public Map<String, List<Blog>> getBlogGroupByReleaseDate(Map map) {
        List<Blog> blogList = findBlogList(map);
        Map<String, List<Blog>> blogMap = new HashedMap();
        for (Blog blog : blogList) {
            String releaseDateStr = DateUtil.formatDate(blog.getReleaseDate(), "yyyy年MM月");
            if (StringUtil.isNotEmpty(releaseDateStr))
                if (blogMap.containsKey(releaseDateStr)) {
                    blogMap.get(releaseDateStr).add(blog);
                } else {
                    List<Blog> blogs = new ArrayList<>();
                    blogs.add(blog);
                    blogMap.put(releaseDateStr, blogs);
                }
        }
        return blogMap;
    }

    @Override
    public Blog selLastBLog(Integer id) {
        return blogMapper.selLastBLog(id);
    }

    @Override
    public Blog selNextBlog(int id) {
        return blogMapper.selNextBlog(id);
    }

    @Override
    public List<Blog> findNewestBlogList() {
        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("status", 1);
        List<Blog> blogList = findBlogList(hashMap);
        if (blogList != null && blogList.size() >= 3) {
            return blogList.subList(0, 3);
        }
        return blogList;
    }
}
