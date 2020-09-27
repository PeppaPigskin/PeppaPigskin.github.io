package com.wcc.controller;

import com.wcc.pojo.Blogger;
import com.wcc.util.ConstantsUtil;
import com.wcc.util.MD5Util;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * 系统登录控制器层
 */
@Controller
@RequestMapping("/manager")
public class LoginController {

    /**
     * 登录操作
     *
     * @param blogger 登录账户信息
     * @param request 请求
     * @return
     */
    @RequestMapping("/login")
    public String login(Blogger blogger, HttpServletRequest request) {
        String userName = blogger.getUserName();
        String password = blogger.getPassword();
        /*TODO:使用MD5进行加密操作*/
        String md5Pwd = MD5Util.md5(password, ConstantsUtil.SALT);
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(userName, md5Pwd);
        try {
            subject.login(token);
            return "redirect:/admin/main.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("blogger", blogger);
            request.setAttribute("errInfo", "用户名或密码错误！");
        }
        return "login";
    }
}
