package com.wcc.pojo;

import com.wcc.util.ConstantsUtil.CommentStateEnum;

import java.io.Serializable;
import java.util.Date;

/**
 * Comment:【blog-博客评论实体类】
 *
 * @author: WuChen
 * @create: 2020-09-23 09:41
 * @modify:
 */
public class Comment implements Serializable {

    /**
     * 序列化ID
     */
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    private Integer id;

    /**
     * 评论者IP
     */
    private String userIp;

    /**
     * 被评论博客
     */
    private Blog blog;

    /**
     * 评论内容
     */
    private String content;

    /**
     * 评论日期
     */
    private Date commentDate;

    /**
     * 评论审核状态
     */
    private CommentStateEnum state;

    /**
     * 评论状态对应中文描述-供前台展示使用
     */
    private String stateStr;

    /**
     * 包含的敏感词汇
     */
    private String sensitiveWord;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserIp() {
        return userIp;
    }

    public void setUserIp(String userIp) {
        this.userIp = userIp;
    }

    public Blog getBlog() {
        return blog;
    }

    public void setBlog(Blog blog) {
        this.blog = blog;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCommentDate() {
        return commentDate;
    }

    public void setCommentDate(Date commentDate) {
        this.commentDate = commentDate;
    }

    public CommentStateEnum getState() {
        return state;
    }

    public void setState(CommentStateEnum state) {
        this.state = state;
        setStateStr();
    }

    public String getStateStr() {
        return stateStr;
    }

    private void setStateStr() {
        if (this.state != null) {
            this.stateStr = this.state.getDesc();
            return;
        }
        this.stateStr = null;
    }

    public String getSensitiveWord() {
        return sensitiveWord;
    }

    public void setSensitiveWord(String sensitiveWord) {
        this.sensitiveWord = sensitiveWord;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id=" + id +
                ", userIp='" + userIp + '\'' +
                ", blog=" + blog +
                ", content='" + content + '\'' +
                ", commentDate=" + commentDate +
                ", state=" + state +
                ", stateStr='" + stateStr + '\'' +
                ", sensitiveWord='" + sensitiveWord + '\'' +
                '}';
    }
}
