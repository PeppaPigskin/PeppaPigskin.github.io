package com.wcc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * TypesController:【blog-博客分类】
 *
 * @author: WuChen
 * @create: 2020-09-28 17:35
 * @modify:
 */
@Controller
public class TypesController {

    @RequestMapping("/types")
    public ModelAndView types(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("title", "博客分类");
        return mav;

    }
}
