package com.wcc.service.impl;


import com.wcc.mapper.CommentMapper;
import com.wcc.pojo.Comment;
import com.wcc.service.CommentService;
import com.wcc.util.ConstantsUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * CommentServiceImpl:【blog-博客评论业务层接口实现类】
 *
 * @author: WuChen
 * @create: 2020-09-23 15:55
 * @modify: 2020年9月24日14点48分
 */
@Service("commentService")
public class CommentServiceImpl implements CommentService {

    @Resource
    private CommentMapper commentMapper;

    @Override
    public List<Comment> selCommentByMap(Map<String, Object> map) {
        return commentMapper.selCommentByMap(map);
    }

    @Override
    public long selCommentCountByMap(Map<String, Object> map) {
        return commentMapper.selCommentCountByMap(map);
    }

    @Override
    public int insComment(Comment comment) {
        return commentMapper.insComment(comment);
    }

    @Override
    public int delCommentById(Integer id) {
        return commentMapper.delCommentById(id);
    }

    @Override
    public int updComment(Comment comment) {
        return commentMapper.updComment(comment);
    }

    @Override
    public boolean updReviewComment(List<Integer> ids, List<String> sensitiveWords, ConstantsUtil.CommentStateEnum state) throws Exception {

        if (ids != null && ids.size() > 0) {
            HashMap<String, Object> map = new HashMap<>();
            map.put("ids", ids);
            List<Comment> comments = selCommentByMap(map);
            if (comments != null && comments.size() > 0) {
                if (sensitiveWords != null && sensitiveWords.size() > 0) {/*即需要修改状态，又需要去处理敏感词汇*/
                    /*TODO:集合去重-jdk1.8才有的去重方式(慎用，哈哈，搭建完，需要整理一下相关新特性呦：ArrayList.stream().distinct()！)*/
                    sensitiveWords = sensitiveWords.stream().distinct().collect(Collectors.toList());
                    for (Comment c : comments) {
                        c.setState(state);
                        String word = c.getSensitiveWord();
                        /*TODO:因为直接使用Arrays.asList()产生的数组无法add和remove,所以处理一下*/
                        List<String> oldSensitives = (word == null || "".equals(word)) ? new ArrayList<>() : new ArrayList<>(Arrays.asList(word.split(",")));
                        String content = c.getContent();
                        if (content != null && !"".equals(content)) {
                            /*TODO:ArrayList集合遍历做移除操作时，需要使用其迭代器，防止出现并发修改操作：java.util.ConcurrentModificationException*/
                            Iterator<String> iterator = oldSensitives.iterator();
                            while (iterator.hasNext()) {
                                String os = iterator.next();
                                if (!sensitiveWords.contains(os)) {
                                    iterator.remove();
                                }
                            }
                            for (String s : sensitiveWords) {
                                if (!oldSensitives.contains(s) && content.contains(s)) {
                                    oldSensitives.add(s);
                                } else if (oldSensitives.contains(s) && !content.contains(s)) {
                                    oldSensitives.remove(s);
                                }
                            }
                        }
                        if (oldSensitives.size() > 0) {
                            /*TODO:这里采用了apache的字符串集合使用指定分隔符进行字符串的拼接：StringUtils.join(ArrayList,String)*/
                            c.setSensitiveWord(StringUtils.join(oldSensitives, ","));
                        }
                        updComment(c);
                    }
                    return true;
                } else {/*只需修改状态*/
                    return commentMapper.updCommentStateByIds(ids, state) > 0;
                }

            }
        }
        return false;
    }
}
