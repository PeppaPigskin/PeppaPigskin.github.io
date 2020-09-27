package com.wcc.service;

import com.wcc.pojo.BlogType;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @program: blog
 * @description: 博客分类业务层接口
 * @author: WuChen
 * @create: 2020-09-18 15:09
 */
public interface BlogTypeService {


    /**
     * 新增博客分类
     *
     * @param blogType 被添加的博客分类对象
     * @return 操作结果
     */
    int insBlogType(BlogType blogType);

    /**
     * 删除博客分类
     *
     * @param id 被删除的博客分类ID
     * @return 操作结果
     */
    int delBlogType(int id);

    /**
     * 根据博客分类ID集合批量删除博客分类
     *
     * @param blogTypeIds 被删除的博客分类ID集合
     * @return 操作结果
     */
    int delBlogTypeByIds(List<Integer> blogTypeIds);

    /**
     * 更新博客分类信息
     *
     * @param blogType 被更新博客分类信息
     * @return 操作结果
     */
    int updBlogType(BlogType blogType);

    /**
     * 获取所有博客类型
     *
     * @return 博客类型集合
     */
    List<BlogType> selAllBlogType();

    /**
     * 根据分类ID查询分类
     *
     * @param id 博客分类ID
     * @return 博客分类
     */
    BlogType findById(int id);

    /**
     * 根据传入的参数集合查询博客分类
     *
     * @param paramMap 查询条件集合
     * @return 博客类型集合
     */
    List<BlogType> findBlogTypeList(Map<String, Object> paramMap);

    /**
     * 获取满足指定条件的博客类型个数
     *
     * @param paramMap 查询条件集合
     * @return 博客类型数
     */
    long getCount(Map<String, Object> paramMap);
}
