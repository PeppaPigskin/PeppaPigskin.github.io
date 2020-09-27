package com.wcc.pojo;

/**
 * @program: blog
 * @description: 分页Bean
 * @author: WuChen
 * @create: 2020-09-18 15:34
 */
public class PageBean {
    /**
     * 当前第几页,从1开始
     */
    private Integer page;

    /**
     * 页面大小
     */
    private Integer pageSize;

    /**
     * 查询起始数据
     */
    private Integer start;


    public Integer getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getStart() {
        return (this.page - 1) * this.pageSize;
    }

    public PageBean(int page, int pageSize) {
        this.page = page;
        this.pageSize = pageSize;
    }
}
