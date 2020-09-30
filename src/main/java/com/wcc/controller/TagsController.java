package com.wcc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * TagsController:【blog-标签控制层】
 *
 * @author: WuChen
 * @create: 2020-09-28 17:36
 * @modify:
 */
@Controller
public class TagsController {
    @RequestMapping("/tags")
    public ModelAndView tags(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("title", "标签");
        return mav;

    }
}
