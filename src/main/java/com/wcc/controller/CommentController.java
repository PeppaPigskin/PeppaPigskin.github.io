package com.wcc.controller;

import com.wcc.pojo.Blog;
import com.wcc.pojo.Comment;
import com.wcc.service.BlogService;
import com.wcc.service.CommentService;
import com.wcc.util.ConstantsUtil;
import com.wcc.util.ResponseUtil;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

/**
 * CommentController:【blog-前台博客评论控制器】
 *
 * @author: WuChen
 * @create: 2020-10-10 11:39
 * @modify:
 */
@Controller
@RequestMapping("/comment")
public class CommentController {

    @Resource
    private CommentService commentService;

    @Resource
    private BlogService blogService;


    /**
     * 发表评论
     *
     * @param comment   评论对象
     * @param imageCode 验证码
     * @param request   请求
     * @param response  响应
     * @return
     */
    @RequestMapping("/save")
    public String save(Comment comment, @RequestParam("imageCode") String imageCode, HttpServletRequest request, HttpServletResponse response) throws IOException {
        String sRand = (String) request.getSession().getAttribute("sRand");
        JSONObject result = new JSONObject();
        if (!imageCode.equals(sRand)) {
            result.put("success", Boolean.FALSE);
            result.put("errInfo", "验证码输入不正确");
        } else {
            int flag = 0;
            /*TODO:获取请求IP*/
            String userIp = request.getRemoteAddr();
            comment.setUserIp(userIp);
            comment.setState(ConstantsUtil.CommentStateEnum.COMMENT_STATE_PENDING);
            comment.setCommentDate(new Date());
            if (comment.getId() == null) {
                flag = commentService.insComment(comment);
                //给对应博客的评论数加一
                Blog blog = blogService.selBlogById(comment.getBlog().getId());
                blog.setReplyHit(blog.getReplyHit() + 1);
                blogService.updateBlog(blog);

            }
            if (flag > 0) {
                result.put("success", Boolean.TRUE);
            } else {
                result.put("success", Boolean.FALSE);
                result.put("errInfo", "评论表失败！");
            }
        }
        ResponseUtil.write(response, result);
        return null;
    }

}
