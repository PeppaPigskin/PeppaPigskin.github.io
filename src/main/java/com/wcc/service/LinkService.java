package com.wcc.service;

import com.wcc.pojo.Link;
import org.apache.ibatis.annotations.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * LinkService:【blog-友情链接业务层接口】
 *
 * @author: WuChen
 * @create: 2020-09-26 17:51
 * @modify:
 */
public interface LinkService {
    /**
     * 新增友情链接
     *
     * @param link 友情链接
     * @return 操作结果影响行数
     */
    @Transactional
    int insLink(Link link);

    /**
     * 修改友情链接数据
     *
     * @param link 友情链接
     * @return 操作结果影响行数
     */
    @Transactional
    int updLink(Link link);

    /**
     * 根据主键删除一条友情链接
     *
     * @param id 主键
     * @return 操作结果影响行数
     */
    @Transactional
    int delLink(Integer id);

    /**
     * 获取所有友情链接
     *
     * @return 数据集合
     */
    List<Link> getAllLink();

    /**
     * 根据主键获取一条友情链接
     *
     * @param id 主键
     * @return 友情链接
     */
    Link selLinkById(Integer id);

    /**
     * 动态查询友情链接数据
     *
     * @param map 查询条件
     * @return 数据集合
     */
    List<Link> selLinkByMap(Map<String, Object> map);

    /**
     * 动态查询友情链接数据条数
     *
     * @param map 查询条件
     * @return 个数
     */
    long selLinkCountByMap(Map<String, Object> map);
}
