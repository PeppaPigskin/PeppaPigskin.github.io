package com.wcc.controller.admin;

import com.wcc.pojo.Blog;
import com.wcc.pojo.BlogType;
import com.wcc.pojo.Blogger;
import com.wcc.pojo.Link;
import com.wcc.service.BlogService;
import com.wcc.service.BlogTypeService;
import com.wcc.service.BloggerService;
import com.wcc.service.LinkService;
import com.wcc.util.ConstantsUtil.Const;
import com.wcc.util.ResponseUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * @program: blog
 * @description: 系统管理控制器
 * @author: WuChen
 * @create: 2020-09-22 22:16
 */
@Controller
@RequestMapping("/admin/systemManager")
public class SystemManagerController {

    @Resource
    private BlogTypeService blogTypeService;

    @Resource
    private BloggerService bloggerService;

    @Resource
    private BlogService blogService;

    @Resource
    private LinkService linkService;

    /**
     * 刷新系统资源
     *
     * @param request  请求
     * @param response 响应流
     * @return 刷新结果（true/false）
     */
    @RequestMapping("/refreshSystemResource")
    public String refreshSystemResource(HttpServletRequest request, HttpServletResponse response) {
        try {
            //获取ApplicationContext对象
            ServletContext application = RequestContextUtils.getWebApplicationContext(request).getServletContext();
            //博客类别
            List<BlogType> allBlogTypes = blogTypeService.selAllBlogType();
            application.setAttribute(Const.RESOURCE_PARAM_BLOG_TYPE_LIST_NAME, allBlogTypes);
            //博主信息
            Blogger blogger = bloggerService.findBloggerAdmin();
            blogger.setPassword(null);
            application.setAttribute(Const.RESOURCE_PARAM_BLOGGER_NAME, blogger);
            //按年月归档博客数量
            List<Blog> blogs = blogService.selAllBlogs();
            application.setAttribute(Const.RESOURCE_PARAM_BLOG_COUNT_LIST, blogs);
            //友情链接
            List<Link> allLink = linkService.getAllLink();
            application.setAttribute(Const.RESOURCE_PARAM_LINK_LIST, allLink);
            return ResponseUtil.setInsOrDelOrUpdResult(response, true, null);
        } catch (Exception e) {
            return ResponseUtil.setInsOrDelOrUpdResult(response, false, null);
        }

    }

}
