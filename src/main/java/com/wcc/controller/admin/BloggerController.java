package com.wcc.controller.admin;

import com.wcc.pojo.Blog;
import com.wcc.pojo.Blogger;
import com.wcc.service.BloggerService;
import com.wcc.util.ConstantsUtil;
import com.wcc.util.ConstantsUtil.Const;
import com.wcc.util.DateUtil;
import com.wcc.util.MD5Util;
import com.wcc.util.ResponseUtil;
import net.sf.json.JSONObject;
import org.apache.ibatis.annotations.Param;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;


/**
 * BloggerController:【blog-博客账户管理控制层】
 *
 * @author: WuChen
 * @create: 2020-09-25 14:23
 * @modify:
 */
@Controller
@RequestMapping("/admin/blogger")
public class BloggerController {

    @Resource
    private BloggerService bloggerService;

    /**
     * 修改账户信息
     *
     * @param blogger  账户信息
     * @param response 响应流
     * @return
     */
    @RequestMapping("/updBlogger")
    public String updBlogger(@RequestParam("imageFile") MultipartFile imageFile, Blogger blogger,
                             HttpServletRequest request,
                             HttpServletResponse response) {
        /*TODO:文件上传处理*/
        if (!imageFile.isEmpty()) {
            String filePath = request.getServletContext().getRealPath("/");
            /*TODO:设置新的文件名*/
            String fileName = DateUtil.getCurrentDateStr() + "." + imageFile.getOriginalFilename().split("\\.")[1];
            try {
                imageFile.transferTo(new File(filePath + "static/userIcon/" + fileName));
                blogger.setImageName(fileName);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        int flag = bloggerService.updBloggerInfo(blogger);
        StringBuffer result = new StringBuffer();
        /*TODO:在前台弹出响应信息*/
        if (flag > 0) {
            result.append("<script language='javascript'>alert('修改成功');</script>");
        } else {
            result.append("<script language='javascript'>alert('修改失败！');</script>");
        }
        try {
            ResponseUtil.write(response, result);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }


    /**
     * 获取博主的Json格式数据
     *
     * @param response
     * @return
     */
    @RequestMapping("/find")
    public String find(HttpServletResponse response) {
        Blogger blogger = (Blogger) SecurityUtils.getSubject().getSession().getAttribute(Const.CURRENT_USER);
        try {
            ResponseUtil.write(response, JSONObject.fromObject(blogger));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 修改密码
     *
     * @param id
     * @param password
     * @param response
     * @return
     */
    @RequestMapping("/modifyPassword")
    public String modifyPassword(@RequestParam("id") String id, @RequestParam("newPassword") String password, HttpServletResponse response) {
        Blogger blogger = new Blogger();
        blogger.setId(Integer.parseInt(id));
        blogger.setPassword(MD5Util.md5(password, ConstantsUtil.SALT));
        int flag = bloggerService.updBloggerPassword(blogger);
        return ResponseUtil.setInsOrDelOrUpdResult(response, flag > 0, null);
    }

    /**
     * 用户退出
     *
     * @return
     */
    @RequestMapping("/logout")
    public String logout() {
        /*TODO:清空缓存*/
        SecurityUtils.getSubject().logout();
        return "redirect:/login.jsp";
    }

}
