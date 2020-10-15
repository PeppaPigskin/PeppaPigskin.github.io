package com.wcc.pojo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @program: blog
 * @description: 博客实体类
 * @author: WuChen
 * @create: 2020-09-20 10:29
 */
public class Blog implements Serializable {

    /**
     * 序列化ID
     */
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    private Integer id;

    /**
     * 标题
     */
    private String title;

    /**
     * 摘要
     */
    private String summary;

    /**
     * 发表时间
     */
    private Date releaseDate;

    /**
     * 发表时间(字符串格式)
     */
    private String releaseDateStr;

    /**
     * 被访问次数
     */
    private Integer clickHit;

    /**
     * 评论数
     */
    private Integer replyHit;

    /**
     * 内容
     */
    private String content;

    /**
     * 纯文本格式内容
     */
    private String contextNoTag;


    /**
     * 最新修改日期
     */
    private Date modifyDate;

    /**
     * 最新修改日期(字符串格式)
     */
    private String modifyDateStr;

    /**
     * 所属分类
     */
    private BlogType blogType;

    /**
     * 关键字
     */
    private String keyWord;

    /**
     * 所属博主
     */
    private Blogger blogger;

    /**
     * 博客数量
     */
    private Integer blogCount;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public String getReleaseDateStr() {
        return releaseDateStr;
    }

    public void setReleaseDateStr(String releaseDateStr) {
        this.releaseDateStr = releaseDateStr;
    }

    public Integer getClickHit() {
        return clickHit;
    }

    public void setClickHit(Integer clickHit) {
        this.clickHit = clickHit;
    }

    public Integer getReplyHit() {
        return replyHit;
    }

    public void setReplyHit(Integer replyHit) {
        this.replyHit = replyHit;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getContextNoTag() {
        return contextNoTag;
    }

    public void setContextNoTag(String contextNoTag) {
        this.contextNoTag = contextNoTag;
    }

    public Date getModifyDate() {
        return modifyDate;
    }

    public void setModifyDate(Date modifyDate) {
        this.modifyDate = modifyDate;
    }

    public String getModifyDateStr() {
        return modifyDateStr;
    }

    public void setModifyDateStr(String modifyDateStr) {
        this.modifyDateStr = modifyDateStr;
    }

    public BlogType getBlogType() {
        return blogType;
    }

    public void setBlogType(BlogType blogType) {
        this.blogType = blogType;
    }

    public String getKeyWord() {
        return keyWord;
    }

    public void setKeyWord(String keyWord) {
        this.keyWord = keyWord;
    }

    public Blogger getBlogger() {
        /*将密码信息置空，防止造成不安全隐患*/
        if (blogger != null) {
            blogger.setPassword(null);
        }
        return blogger;
    }

    public void setBlogger(Blogger blogger) {
        /*将密码信息置空，防止造成不安全隐患*/
        if (blogger != null) {
            blogger.setPassword(null);
        }
        this.blogger = blogger;
    }

    public Integer getBlogCount() {
        return blogCount;
    }

    public void setBlogCount(Integer blogCount) {
        this.blogCount = blogCount;
    }


    @Override
    public String toString() {
        return "Blog{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", summary='" + summary + '\'' +
                ", releaseDate=" + releaseDate +
                ", releaseDateStr='" + releaseDateStr + '\'' +
                ", clickHit=" + clickHit +
                ", replyHit=" + replyHit +
                ", content='" + content + '\'' +
                ", contextNoTag='" + contextNoTag + '\'' +
                ", modifyDate=" + modifyDate +
                ", modifyDateStr='" + modifyDateStr + '\'' +
                ", blogType=" + blogType +
                ", keyWord='" + keyWord + '\'' +
                ", blogger=" + blogger +
                ", blogCount=" + blogCount +
                '}';
    }
}
