package com.wcc.util;

/**
 * PageUtil:【blog-翻页工具类】
 *
 * @author: WuChen
 * @create: 2020-09-29 17:40
 * @modify:
 */
public class PageUtil {

    /**
     * 翻页方法
     *
     * @param targetUrl   跳转的地址
     * @param totalNum    总数
     * @param currentPage 当前页
     * @param pageSize    页面大小
     * @param param       参数
     * @return
     */
    public static String genPagination(String targetUrl, long totalNum, int currentPage, int pageSize, String param) {
        if (totalNum == 0) {
            return "";
        }
        long pageCount = 1;
        if (totalNum % pageSize == 0) {
            pageCount = totalNum % pageSize;
        } else {
            pageCount = totalNum / pageSize + 1;
        }
        StringBuffer pageCode = new StringBuffer();
        pageCode.append("<div class='column'>");

        //上一页设定
        if (currentPage > 1) {//当前页不是第一页,上一页可以点击
            pageCode.append("<a href='" + targetUrl + "?page=1&" + param + "' class='ui mini teal basic button'>首页</a>");
            pageCode.append("<a href='" + targetUrl + "?page=" + (currentPage - 1) + "&" + param + "' class='ui mini teal basic button'>上一页</a>");
        } else {//当前页是第一页,上一页不可以点击
            pageCode.append("<a href='#' class='disabled ui mini teal basic button'>首页</a>");
            pageCode.append("<a class='disabled ui mini teal basic button' href='#'>上一页</a>");
        }

        //中部显示页码设定（只显示showNums个页码）
        pageCode.append("</div>");
        pageCode.append("<div class='column center aligned'>");
        int showNums = 5;
        int midNum = showNums / 2;
        if (pageCount <= showNums) {
            for (int i = 1; i <= pageCount; i++) {
                if (i == currentPage) {
                    pageCode.append("<a class='ui mini teal basic button secondary  active' href='" + targetUrl + "?page=" + i + "&" + param + "'>" + i + "</a>");
                } else {
                    pageCode.append("<a class='ui mini teal basic button' href='" + targetUrl + "?page=" + i + "&" + param + "'>" + i + "</a>");
                }
            }
        } else {
            if ((pageCount - currentPage >= midNum) && (currentPage > midNum)) {
                for (int i = 1; i <= pageCount; i++) {
                    if (showNums % 2 == 0) {
                        if ((currentPage - midNum < i && i <= currentPage) || (i > currentPage && i <= currentPage + midNum)) {
                            if (i == currentPage) {
                                pageCode.append("<a class='ui mini teal basic button secondary  active' href='" + targetUrl + "?page=" + i + "&" + param + "'>" + i + "</a>");
                            } else {
                                pageCode.append("<a class='ui mini teal basic button' href='" + targetUrl + "?page=" + i + "&" + param + "'>" + i + "</a>");
                            }
                        }
                    } else {
                        if ((currentPage - midNum <= i && i <= currentPage) || (i > currentPage && i <= currentPage + midNum)) {
                            if (i == currentPage) {
                                pageCode.append("<a class='ui mini teal basic button secondary  active' href='" + targetUrl + "?page=" + i + "&" + param + "'>" + i + "</a>");
                            } else {
                                pageCode.append("<a class='ui mini teal basic button' href='" + targetUrl + "?page=" + i + "&" + param + "'>" + i + "</a>");
                            }
                        }
                    }
                }
            } else if (pageCount - currentPage < midNum) {
                for (int i = 1; i <= pageCount; i++) {
                    if ((pageCount - showNums + 1) <= i) {
                        if (i == currentPage) {
                            pageCode.append("<a class='ui mini teal basic button secondary  active' href='" + targetUrl + "?page=" + i + "&" + param + "'>" + i + "</a>");
                        } else {
                            pageCode.append("<a class='ui mini teal basic button' href='" + targetUrl + "?page=" + i + "&" + param + "'>" + i + "</a>");
                        }
                    }
                }
            } else if (currentPage <= midNum) {
                for (int i = 1; i <= pageCount; i++) {
                    if (i <= showNums) {
                        if (i == currentPage) {
                            pageCode.append("<a class='ui mini teal basic button secondary  active' href='" + targetUrl + "?page=" + i + "&" + param + "'>" + i + "</a>");
                        } else {
                            pageCode.append("<a class='ui mini teal basic button' href='" + targetUrl + "?page=" + i + "&" + param + "'>" + i + "</a>");
                        }
                    }
                }
            }
        }
        pageCode.append("</div>");

        //下一页设定
        pageCode.append(" <div class='column right aligned'>");
        if (currentPage < pageCount) {
            pageCode.append("<a class='ui mini teal basic button' href='" + targetUrl + "?page=" + (currentPage + 1) + "&" + param + "'>下一页</a>");
            pageCode.append("<a class='ui mini teal basic button' href='" + targetUrl + "?page=" + pageCount + "&" + param + "'>尾页</a>");
        } else {//当前页是最后一页,上一页不可以点击
            pageCode.append("<a class='ui mini teal basic button disabled' href='#'>下一页</a>");
            pageCode.append("<a class='ui mini teal basic button disabled' href='#'>尾页</a>");
        }

        pageCode.append("</div>");
        /*<div class="column">
            <a href="#" class="ui mini teal basic button">首页</a>
            <a href="#" class="ui mini teal basic button">上一页</a>
        </div>
        <div class="column center aligned">
            <a class="ui mini teal basic button">1</a>
            <a class="ui mini teal basic button">2</a>
            <a class="ui mini teal basic button">3</a>
        </div>
        <div class="column right aligned">
            <a href="#" class="ui mini teal basic button">下一页</a>
            <a href="#" class="ui mini teal basic button">尾页</a>
        </div>*/
        return pageCode.toString();
    }

}
