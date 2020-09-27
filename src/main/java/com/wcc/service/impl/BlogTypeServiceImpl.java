package com.wcc.service.impl;

import com.wcc.mapper.BlogTypeMapper;
import com.wcc.pojo.BlogType;
import com.wcc.service.BlogTypeService;
import com.wcc.util.StringUtil;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * @program: blog
 * @description: 博客分类业务层实现类
 * @author: WuChen
 * @create: 2020-09-18 15:16
 */
@Service("blogTypeService")
public class BlogTypeServiceImpl implements BlogTypeService {

    @Resource
    private BlogTypeMapper blogTypeMapper;

    @Override
    public int insBlogType(BlogType blogType) {
        return blogTypeMapper.insBlogType(blogType);
    }

    @Override
    public int delBlogType(int id) {
        return blogTypeMapper.delBlogType(id);
    }

    @Override
    public int delBlogTypeByIds(List<Integer> blogTypeIds) {
        return blogTypeMapper.delBlogTypeByIds(blogTypeIds);
    }

    @Override
    public int updBlogType(BlogType blogType) {
        return blogTypeMapper.updBlogType(blogType);
    }

    @Override
    public List<BlogType> selAllBlogType() {
        return blogTypeMapper.selAllBlogType();
    }

    @Override
    public BlogType findById(int id) {
        return blogTypeMapper.findById(id);
    }

    @Override
    public List<BlogType> findBlogTypeList(Map<String, Object> paramMap) {
        return blogTypeMapper.findBlogTypeList(paramMap);
    }

    @Override
    public long getCount(Map<String, Object> paramMap) {
        return blogTypeMapper.getCount(paramMap);
    }
}
