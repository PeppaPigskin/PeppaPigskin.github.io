package com.wcc.service;

import com.wcc.pojo.Blog;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @program: blog
 * @description: 博客业务层接口
 * @author: WuChen
 * @create: 2020-09-20 14:29
 */
public interface BlogService {

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
     * 湖泊去满足指定条件的博客数
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
    Blog selBlogById(Integer id);


    /**
     * 新增一条博客数据
     *
     * @param blog 博客对象
     * @return 操作结果
     */
    int insBlog(Blog blog);

    /**
     * 修改博客数据
     *
     * @param blog 博客对象
     * @return 操作结果
     */
    int updateBlog(Blog blog);

    /**
     * 根据主键集合批量删除博客数据
     *
     * @param blogIds 主键集合
     * @return 操作结果
     */
    int delBlogByIds(List<Integer> blogIds);

    /**
     * 获取指定年月且满足指定条件所包含的博客数据
     *
     * @param map 条件
     * @return 博客集合
     */
    Map<String, List<Blog>> getBlogGroupByReleaseDate(Map map);

    /**
     * 根据当前博客主键获取其上一篇博客
     *
     * @param id 当前博客主键
     * @return 当前博客的上一篇博客
     */
    Blog selLastBLog(Integer id);

    /**
     * 根据当前博客主键查询下一篇博客
     *
     * @param id 当前博客主键
     * @return 当前博客的下一篇博客
     */
    Blog selNextBlog(int id);

    /**
     * 获取最新博客列表（最近发布的三条）
     *
     * @return 博客对象集合
     */
    List<Blog> findNewestBlogList();

}
