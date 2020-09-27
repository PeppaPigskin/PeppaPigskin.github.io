package com.wcc.pojo;

import java.io.Serializable;

/**
 * Link:【blog-友情链接】
 *
 * @author: WuChen
 * @create: 2020-09-25 17:58
 * @modify:
 */
public class Link implements Serializable {

    public static final Long serialVersionUID = 1L;

    /**
     * 主键
     */
    private Integer id;
    /**
     * 网站名称
     */
    private String linkName;
    /**
     * 网址
     */
    private String linkUrl;
    /**
     * 序号
     */
    private Integer orderNo;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLinkName() {
        return linkName;
    }

    public void setLinkName(String linkName) {
        this.linkName = linkName;
    }

    public String getLinkUrl() {
        return linkUrl;
    }

    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl;
    }

    public Integer getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }

    @Override
    public String toString() {
        return "Link{" +
                "id=" + id +
                ", linkName='" + linkName + '\'' +
                ", linkUrl='" + linkUrl + '\'' +
                ", orderNo=" + orderNo +
                '}';
    }
}
