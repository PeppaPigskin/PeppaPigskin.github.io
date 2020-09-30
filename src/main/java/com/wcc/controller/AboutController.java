package com.wcc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * AboutController:【blog-关于博主控制层】
 *
 * @author: WuChen
 * @create: 2020-09-28 17:39
 * @modify:
 */
@Controller
public class AboutController {
    @RequestMapping("/about")
    public ModelAndView about(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("title", "关于博主");
        return mav;

    }
}
