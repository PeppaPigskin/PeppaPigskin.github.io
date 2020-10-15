package com.wcc.controller;

import com.wcc.lucene.BlogIndex;
import com.wcc.pojo.Blog;
import com.wcc.service.BlogService;
import com.wcc.service.CommentService;
import com.wcc.util.ConstantsUtil;
import com.wcc.util.StringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * BlogDetaiController:【blog-博客详情控制器】
 *
 * @author: WuChen
 * @create: 2020-09-28 17:41
 * @modify:l
 */
@Controller
public class BlogDetailController {

    @Resource
    private BlogService blogService;

    @Resource
    private CommentService commentService;

    private BlogIndex blogIndex = new BlogIndex();


    /**
     * 显示博客详细信息
     *
     * @param id       要显示详细信息的博客主键
     * @param request  请求
     * @param response 响应
     * @return
     */
    @RequestMapping("/blog/{id}")
    public ModelAndView blog(@PathVariable("id") Integer id, HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("title", "博客详情");
        //根据主键查询博客信息
        Blog blog = blogService.selBlogById(id);
        List<String> blogKeyWords = new ArrayList<>();
        blogKeyWords.addAll(Arrays.asList(blog.getKeyWord().split(" ")));

        Map map = new HashMap();
        map.put("blogId", id);
        map.put("state", ConstantsUtil.CommentStateEnum.COMMENT_STATE_REVIEW_PASSED.getValue());
        /*获取到评论数据*/
        List comments = commentService.selCommentByMap(map);
        mav.addObject("commentList", comments);

        mav.addObject("blog", blog);
        mav.addObject("blogKeyWords", blogKeyWords);
        /*上一页与下一页*/
        mav.addObject("pageCode", genUpAndDownPageCode(blogService.selLastBLog(id), blogService.selNextBlog(id), request.getServletContext().getContextPath()));
        //点击量加一
        blog.setClickHit(blog.getClickHit() + 1);
        blogService.updateBlog(blog);
        mav.setViewName("blog");
        return mav;
    }

    /**
     * 上一篇与下一篇
     *
     * @param lastBlog       上一篇对象
     * @param nextBlog       下一篇对象
     * @param projectContext 当前相对路径
     * @return 拼写出来的Code
     */
    private String genUpAndDownPageCode(Blog lastBlog, Blog nextBlog, String projectContext) {
        StringBuffer pageCode = new StringBuffer();
        if (lastBlog == null || lastBlog.getId() == null) {
            pageCode.append("<p style='float:left;padding-left:10px'>上一篇：没有了</p>");
        } else {
            pageCode.append("<p style='float:left;padding-left:10px'>上一篇：<a href='" + projectContext + "/blog/" + lastBlog.getId() + ".do'>"
                    + lastBlog.getTitle() + "</a></p>");
        }
        if (nextBlog == null || nextBlog.getId() == null) {
            pageCode.append("<p style='float:right;padding-right:10px'>下一篇：没有了</p>");
        } else {
            pageCode.append("<p style='float:right;padding-right:10px'>下一篇：<a href='" + projectContext + "/blog/" + nextBlog.getId() + ".do'>"
                    + nextBlog.getTitle() + "</a></p>");
        }
        pageCode.append("<p style='clear:both'></p>");
        return pageCode.toString();
    }

    /**
     * 根据关键字查询博客
     *
     * @param q       查询条件
     * @param page    当前页
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/q"})
    public ModelAndView q(@RequestParam(value = "q", required = false) String q,
                          @RequestParam(value = "mainPageName", required = false) String mainPageName,
                          @RequestParam(value = "page", required = false) String page,
                          HttpServletRequest request) throws Exception {

        if (StringUtil.isEmpty(page)) {
            page = "1";
        }
        ModelAndView mav = new ModelAndView();
        mav.addObject("mainPage", "result.jsp");
        //在lucene中查询
        List<Blog> blogList = blogIndex.searchBlog(q, blogService);

        mav.addObject("q", q);
        mav.addObject("blogList", blogList);
        mav.addObject("resultTotal", blogList.size());
        mav.addObject("title", "搜索关键字【" + q + "】结果_个人博客");
        mav.setViewName(mainPageName);
        return mav;
    }

}
