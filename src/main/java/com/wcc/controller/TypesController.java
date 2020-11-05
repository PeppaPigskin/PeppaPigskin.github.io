package com.wcc.controller;

import com.wcc.pojo.Blog;
import com.wcc.pojo.PageBean;
import com.wcc.service.BlogService;
import com.wcc.util.PageUtil;
import com.wcc.util.StringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * TypesController:【blog-博客分类】
 *
 * @author: WuChen
 * @create: 2020-09-28 17:35
 * @modify:
 */
@Controller
public class TypesController {

    @Resource
    private BlogService blogService;

    @RequestMapping("/types")
    public ModelAndView types(@RequestParam(value = "page", required = false) String page,
                              @RequestParam(value = "typeId", required = false) String typeId,
                              HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("title", "博客分类");
        if (StringUtil.isEmpty(page)) {
            page = "1";
        }
        PageBean pageBean = new PageBean(Integer.parseInt(page), 10);
        Map<String, Object> map = new HashMap<>();
        map.put("start", pageBean.getStart());
        map.put("size", pageBean.getPageSize());
        map.put("typeId", typeId);
        map.put("status", 1);
        List<Blog> blogList = blogService.findBlogList(map);
        StringBuffer param = new StringBuffer();
        if (StringUtil.isNotEmpty(typeId)) {
            param.append("typeId=" + typeId + "&");
        }
        long blogSum = blogService.getBlogCount(map);
        String pageCode = PageUtil.genPagination(request.getContextPath() + "/types.html", blogSum, Integer.parseInt(page), 10, param.toString());
        mav.addObject("mainPage", "blogList.jsp");
        mav.addObject("pageCode", pageCode);
        mav.addObject("blogList", blogList);
        mav.addObject("blogSum", blogSum);

        return mav;

    }
}
