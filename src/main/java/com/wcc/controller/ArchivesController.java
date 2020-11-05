package com.wcc.controller;

import com.wcc.pojo.Blog;
import com.wcc.pojo.PageBean;
import com.wcc.service.BlogService;
import com.wcc.util.PageUtil;
import com.wcc.util.StringUtil;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * ArchivesController:【blog-博客归档控制层】
 *
 * @author: WuChen
 * @create: 2020-09-28 17:37
 * @modify:
 */
@Controller
public class ArchivesController {


    @Resource
    private BlogService blogService;

    @RequestMapping("/archives")
    public ModelAndView archives(@RequestParam(value = "page", required = false) String page,

                                 HttpServletRequest request,
                                 HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("title", "博客归档");
        if (StringUtil.isEmpty(page)) {
            page = "1";
        }
        PageBean pageBean = new PageBean(Integer.parseInt(page), 15);
        Map<String, Object> map = new HashedMap();
        map.put("start", pageBean.getStart());
        map.put("size", pageBean.getPageSize());
        map.put("status",1);
        Map<String, List<Blog>> blogGroupByReleaseDate = blogService.getBlogGroupByReleaseDate(map);
        //TODO:map按照键排序
        Map<String, List<Blog>> blogNewMap = new LinkedHashMap<>();
        blogGroupByReleaseDate.entrySet().stream().sorted(Map.Entry.<String, List<Blog>>comparingByKey().reversed()).
                forEachOrdered(e -> blogNewMap.put(e.getKey(), e.getValue()));
        long count = blogService.getBlogCount(map);
        String pageCode = PageUtil.genPagination(request.getContextPath().trim() + "/archives.html", count, Integer.parseInt(page), 15, null);
        mav.addObject("blogSum", count);
        mav.addObject("pageCode", pageCode);
        mav.addObject("blogNewMap", blogNewMap);
        return mav;
    }
}
