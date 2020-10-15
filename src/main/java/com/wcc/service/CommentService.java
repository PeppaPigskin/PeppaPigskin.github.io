package com.wcc.service;

import com.wcc.pojo.Comment;
import com.wcc.util.ConstantsUtil;
import com.wcc.util.ConstantsUtil.CommentStateEnum;
import org.apache.ibatis.annotations.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * CommentService:【blog-博客评论业务层接口】
 *
 * @author: WuChen
 * @create: 2020-09-23 15:53
 * @modify:
 */
public interface CommentService {
    /**
     * 根据条件集合动态获取评论数据
     *
     * @param map 查询条件(条件为空时查询的是所有评论)
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
    int insComment(Comment comment);

    /**
     * 根据主键删除一条评论数据
     *
     * @param id 评论主键
     * @return 操作结果
     */
    int delCommentById(Integer id);

    /**
     * 修改一条博客评论数据
     *
     * @param comment 修改的评论数据
     * @return 操作结果
     */
    int updComment(Comment comment);

    /**
     * 评论审核
     *
     * @param ids            被审核的评论主键集合
     * @param sensitiveWords 需要处理的敏感词汇
     * @param state          设置的新审核状态
     * @return
     */
    boolean updReviewComment(List<Integer> ids, List<String> sensitiveWords, CommentStateEnum state) throws Exception;
}
