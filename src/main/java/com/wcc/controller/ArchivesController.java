package com.wcc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * ArchivesController:【blog-博客归档控制层】
 *
 * @author: WuChen
 * @create: 2020-09-28 17:37
 * @modify:
 */
@Controller
public class ArchivesController {
    @RequestMapping("/archives")
    public ModelAndView archives(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("title", "博客归档");
        return mav;
    }
}
