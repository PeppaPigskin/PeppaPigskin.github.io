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
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * IndexController:【blog-首页控制器】
 *
 * @author: WuChen
 * @create: 2020-09-27 22:56
 * @modify:
 */
@Controller
public class IndexController {

    @Resource
    private BlogService blogService;

    @RequestMapping("/index")
    public ModelAndView index(@RequestParam(value = "page", required = false) String page,
                              @RequestParam(value = "typeId", required = false) String typeId,
                              @RequestParam(value = "releaseDateStr", required = false) String releaseDateStr,
                              HttpServletRequest request,
                              HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("title", "博客首页");
        if (StringUtil.isEmpty(page)) {
            page = "1";
        }
        PageBean pageBean = new PageBean(Integer.parseInt(page), 5);
        Map<String, Object> map = new HashMap<>();
        map.put("start", pageBean.getStart());
        map.put("size", pageBean.getPageSize());
        map.put("typeId", typeId);
        map.put("releaseDateStr", releaseDateStr);
        List<Blog> blogList = blogService.findBlogList(map);
        StringBuffer param = new StringBuffer();
        if (StringUtil.isNotEmpty(typeId)) {
            param.append("typeId=" + typeId + "&");
        }
        if (StringUtil.isNotEmpty(releaseDateStr)) {
            param.append("releaseDateStr=" + releaseDateStr + "&");
        }
        long blogSum = blogService.getBlogCount(map);
        String pageCode = PageUtil.genPagination(request.getContextPath() + "/index.html", blogSum, Integer.parseInt(page), 5, param.toString());
        mav.addObject("mainPage", "blogList.jsp");
        mav.addObject("blogSum", blogSum);
        mav.addObject("pageCode", pageCode);
        mav.addObject("blogList", blogList);
        return mav;

    }
}
