package com.wcc.controller.admin;

import com.wcc.pojo.BlogType;
import com.wcc.pojo.PageBean;
import com.wcc.service.BlogTypeService;
import com.wcc.util.ResponseUtil;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @program: blog
 * @description: 博客分类控制器层
 * @author: WuChen
 * @create: 2020-09-18 15:30
 */
@Controller
@RequestMapping("/admin/blogType")
public class BlogTypeController {

    @Resource
    private BlogTypeService blogTypeService;

    /**
     * 获取博客分类列表
     *
     * @param page
     * @param rows
     * @param response
     * @return
     */
    @RequestMapping("/list")
    public String list(@RequestParam(value = "page", required = false) String page,
                       @RequestParam(value = "rows", required = false) String rows,
                       HttpServletResponse response) {
        PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("start", pageBean.getStart());
        hashMap.put("size", pageBean.getPageSize());
        //获取博客分类分页数据
        List<BlogType> blogTypes = blogTypeService.findBlogTypeList(hashMap);

        //获取博客分类总个数
        long total = blogTypeService.getCount(hashMap);

        //将数据写入响应流
        return ResponseUtil.setSelResult(response, total, JSONArray.fromObject(blogTypes));
    }

    /**
     * 保存博客类别信息（可新增可修改）
     *
     * @param blogType 博客类型对象
     * @param response 响应流对象
     */
    @RequestMapping("/saveBlogType")
    public String saveBlogType(BlogType blogType, HttpServletResponse response) {
        int flag = -1;
        if (blogType.getId() == null) {
            //添加操作
            flag = blogTypeService.insBlogType(blogType);
        } else {
            //更新操作
            flag = blogTypeService.updBlogType(blogType);
        }
        return ResponseUtil.setInsOrDelOrUpdResult(response, flag > 0, null);
    }

    /**
     * 删除博客信息
     *
     * @param ids
     * @param response
     * @return
     */
    @RequestMapping("/deleteBlogType")
    public String deleteBlogType(@RequestParam("ids") String ids, HttpServletResponse response) {
        String[] idsStr = ids.split(",");
        List<Integer> delIDs = new ArrayList<>();
        for (String idStr : idsStr) {
            delIDs.add(Integer.parseInt(idStr));
        }
        Map<String, Object> map = new HashMap<>();
        int flag = -1;
        try {
            flag = blogTypeService.delBlogTypeByIds(delIDs);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("message", "存在已被使用的博客类别，删除失败！");
        }
        return ResponseUtil.setInsOrDelOrUpdResult(response, flag > 0, map);
    }
}
