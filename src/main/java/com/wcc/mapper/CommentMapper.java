package com.wcc.mapper;

import com.wcc.pojo.Comment;
import com.wcc.util.ConstantsUtil;
import org.apache.ibatis.annotations.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * CommentMapper:【blog-博客评论数数据访问层接口】
 *
 * @author: WuChen
 * @create: 2020-09-23 14:16
 * @modify:
 */
public interface CommentMapper {

    /**
     * 根据条件集合动态获取评论数据
     *
     * @param map 查询条件
     * @return
     */
    List<Comment> selCommentByMap(Map<String, Object> map);

    /**
     * 根据条件动态查询满足条件的评论数
     *
     * @param map 查询条件
     * @return
     */
    long selCommentCountByMap(Map<String, Object> map);

    /**
     * 新增一条评论
     *
     * @param comment 评论对象
     * @return 操作结果
     */
    @Transactional
    int insComment(Comment comment);

    /**
     * 根据主键删除一条评论数据
     *
     * @param id 评论主键
     * @return 操作结果
     */
    @Transactional
    int delCommentById(@Param("id") Integer id);

    /**
     * 根据博客主键集合删除对应评论数据
     *
     * @param blogIds 博客主键集合
     * @return 操作结果
     */
    @Transactional
    int delCommentByBlogIds(@Param("blogIds") List<Integer> blogIds);

    /**
     * 修改一条博客数据
     *
     * @param blogComment 修改的评论数据
     * @return 操作结果
     */
    @Transactional
    int updComment(Comment blogComment);

    /**
     * 根据主键集合批量修改评论状态
     *
     * @param ids   主键集合
     * @param state 状态
     * @return
     */
    @Transactional
    int updCommentStateByIds(@Param("ids") List<Integer> ids, @Param("state") ConstantsUtil.CommentStateEnum state);

}
