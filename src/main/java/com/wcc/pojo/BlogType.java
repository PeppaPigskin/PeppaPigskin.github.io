package com.wcc.pojo;

import java.io.Serializable;

/**
 * @program: blog
 * @description: 博客分类
 * @author: WuChen
 * @create: 2020-09-18 11:42
 */
public class BlogType implements Serializable {

    /**
     * 序列化ID
     */
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    private Integer id;
    /**
     * 类型名称
     */
    private String typeName;
    /**
     * 序号
     */
    private Integer orderNo;

    /**
     * 该类型下的博客数量
     */
    private Integer blogCount;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public Integer getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }

    public Integer getBlogCount() {
        return blogCount;
    }

    public void setBlogCount(Integer blogCount) {
        this.blogCount = blogCount;
    }

    @Override
    public String toString() {
        return "BlogType{" +
                "id=" + id +
                ", typeName='" + typeName + '\'' +
                ", orderNo=" + orderNo +
                ", blogCount=" + blogCount +
                '}';
    }
}
