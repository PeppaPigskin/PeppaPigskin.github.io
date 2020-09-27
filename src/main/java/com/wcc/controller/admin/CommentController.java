package com.wcc.controller.admin;

import com.wcc.pojo.Comment;
import com.wcc.pojo.PageBean;
import com.wcc.service.CommentService;
import com.wcc.util.ConstantsUtil.CommentStateEnum;
import com.wcc.util.DateJsonValueProcessor;
import com.wcc.util.ResponseUtil;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * CommentController:【blog-评论管理控制层】
 *
 * @author: WuChen
 * @create: 2020-09-23 16:45
 * @modify:
 */
@Controller
@RequestMapping("/admin/comment")
public class CommentController {

    @Resource
    private CommentService commentService;

    /**
     * @param page
     * @param pageSize
     * @param response
     * @return
     */
    @RequestMapping("/list")
    public String list(@RequestParam(value = "page", required = false) String page, @RequestParam(value = "rows", required = false) String pageSize, HttpServletResponse response) {
        PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(pageSize));
        HashMap<String, Object> map = new HashMap<>();
        map.put("start", pageBean.getStart());
        map.put("size", pageBean.getPageSize());
        List<Comment> comments = commentService.selCommentByMap(map);
        long count = commentService.selCommentCountByMap(map);
        JsonConfig config = new JsonConfig();
        config.registerJsonValueProcessor(Date.class, new DateJsonValueProcessor("yyyy-MM-dd HH:mm:ss"));
        return ResponseUtil.setSelResult(response, count, JSONArray.fromObject(comments, config));
    }

    /**
     * 删除评论数据
     *
     * @param idStr
     * @param response
     * @return
     */
    @RequestMapping("/delComment")
    public String delComment(@RequestParam("idStr") String idStr, HttpServletResponse response) {
        List<Integer> ids = new ArrayList<Integer>();
        String[] strings = idStr.split(",");
        int flag = -1;
        try {
            for (String id : strings) {
                flag = commentService.delCommentById(Integer.parseInt(id));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseUtil.setInsOrDelOrUpdResult(response, flag > 0, null);
    }

    /**
     * 进行评论审核及敏感词汇处理
     *
     * @param sensitiveWord 敏感词汇
     * @param ids           被审核评论主键拼接字符串
     * @param state         选择的要更改为的状态
     * @param response      响应流
     * @return
     */
    @RequestMapping("/saveReview")
    public String saveReview(@RequestParam("sensitiveWord") String sensitiveWord,
                             @RequestParam("modifyCommentIds") String ids,
                             @RequestParam("state") CommentStateEnum state,
                             HttpServletResponse response) {
        List<String> sensitiveWords = Arrays.asList(sensitiveWord.split("[,，]"));
        String[] idStr = ids.split(",");
        List<Integer> commentIDs = new ArrayList<>();
        for (String str : idStr) {
            commentIDs.add(Integer.parseInt(str));
        }
        try {
            if (commentService.updReviewComment(commentIDs, sensitiveWords, state)) {
                return ResponseUtil.setInsOrDelOrUpdResult(response, true, null);
            } else {
                return ResponseUtil.setInsOrDelOrUpdResult(response, false, null);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseUtil.setInsOrDelOrUpdResult(response, false, null);
        }
    }

}
