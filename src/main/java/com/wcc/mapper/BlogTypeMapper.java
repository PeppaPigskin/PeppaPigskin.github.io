package com.wcc.mapper;

import com.wcc.pojo.BlogType;
import org.apache.ibatis.annotations.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * @program: blog
 * @description: 博客类型数据访问层接口
 * @author: WuChen
 * @create: 2020-09-18 11:52
 */
public interface BlogTypeMapper {


    /**
     * 新增博客分类
     *
     * @param blogType 被添加的博客分类对象
     * @return
     */
    @Transactional
    int insBlogType(BlogType blogType);

    /**
     * 删除博客分类
     *
     * @param id 被删除的博客分类ID
     * @return
     */
    @Transactional
    int delBlogType(@Param("id") int id);

    /**
     * 根据博客分类ID集合批量删除博客分类
     *
     * @param blogTypeIds 被删除的博客分类ID集合
     * @return
     */
    @Transactional
    int delBlogTypeByIds(@Param("blogTypeIds") List<Integer> blogTypeIds);

    /**
     * 更新博客分类信息
     *
     * @param blogType 被更新博客分类信息
     * @return
     */
    @Transactional
    int updBlogType(BlogType blogType);

    /**
     * 获取所有博客类型
     *
     * @return
     */
    List<BlogType> selAllBlogType();

    /**
     * 根据分类ID查询分类
     *
     * @param id 博客分类ID
     * @return
     */
    BlogType findById(@Param("id") int id);

    /**
     * 根据传入的参数集合查询博客分类
     *
     * @param paramMap 查询条件集合
     * @return
     */
    List<BlogType> findBlogTypeList(Map<String, Object> paramMap);

    /**
     * 获取满足指定条件的博客类型个数
     *
     * @param paramMap 查询条件集合
     * @return
     */
    long getCount(Map<String, Object> paramMap);
}
