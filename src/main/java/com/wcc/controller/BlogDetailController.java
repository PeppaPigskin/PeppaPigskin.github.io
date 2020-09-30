package com.wcc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * BlogDetaiController:【blog-博客详情控制器】
 *
 * @author: WuChen
 * @create: 2020-09-28 17:41
 * @modify:l
 */
@Controller
public class BlogDetailController {
    @RequestMapping("/blogDetail")
    public ModelAndView blogDetail(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("title", "博客详情");
        return mav;

    }
}
