package com.wcc.mapper;

import com.wcc.pojo.Blog;
import org.apache.ibatis.annotations.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * @program: blog
 * @description: 博客数据访问层接口
 * @author: WuChen
 * @create: 2020-09-20 11:04
 */
public interface BlogMapper {

    /**
     * 获取所有博客数据
     *
     * @return 博客集合
     */
    List<Blog> selAllBlogs();

    /**
     * 根据条件查询博客数据
     *
     * @param map 查询条件集合
     * @return 博客集合
     */
    List<Blog> findBlogList(Map<String, Object> map);

    /**
     * 获取满足指定条件的博客数
     *
     * @param map 查询条件集合
     * @return 博客数量
     */
    long getBlogCount(Map<String, Object> map);

    /**
     * 根据主键查询指定博客数据
     *
     * @param id 主键
     * @return 博客数据
     */
    Blog selBlogById(@Param("id") Integer id);


    /**
     * 新增一条博客数据
     *
     * @param blog 博客对象
     * @return 操作结果
     */
    @Transactional
    int insBlog(Blog blog);

    /**
     * 修改博客数据
     *
     * @param blog 博客对象
     * @return 操作结果
     */
    @Transactional
    int updateBlog(Blog blog);

    /**
     * 根据主键集合批量删除博客数据
     *
     * @param blogIds 主键集合
     * @return 操作结果
     */
    @Transactional
    int delBlogByIds(@Param("blogIds") List<Integer> blogIds);

    /**
     * 根据当前博客主键获取其上一篇博客
     *
     * @param id 当前博客主键
     * @return 当前博客的上一篇博客
     */
    Blog selLastBLog(@Param("id") Integer id);

    /**
     * 根据当前博客主键查询下一篇博客
     *
     * @param id 当前博客主键
     * @return 当前博客的下一篇博客
     */
    Blog selNextBlog(@Param("id") int id);
}
