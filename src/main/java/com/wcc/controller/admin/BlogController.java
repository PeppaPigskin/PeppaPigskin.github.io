package com.wcc.controller.admin;

import com.wcc.lucene.BlogIndex;
import com.wcc.pojo.Blog;
import com.wcc.pojo.PageBean;
import com.wcc.service.BlogService;
import com.wcc.util.DateJsonValueProcessor;
import com.wcc.util.ResponseUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * @program: blog
 * @description: 博客管理控制层
 * @author: WuChen
 * @create: 2020-09-20 20:00
 */
@Controller
@RequestMapping("/admin/blog")
public class BlogController {
    @Resource
    private BlogService blogService;

    private BlogIndex blogIndex = new BlogIndex();


    /**
     * 保存一条博客数据
     *
     * @param blog     博客数据对象
     * @param response 响应流
     * @return
     */
    @RequestMapping("/save")
    public String saveBlog(Blog blog, HttpServletResponse response) throws Exception {
        int flag = blogService.insBlog(blog);
        //使用lucene工具类的添加方法
        blogIndex.addIndex(blog);
        return ResponseUtil.setInsOrDelOrUpdResult(response, flag > 0, null);

    }


    /**
     * 获取博客列表数据
     *
     * @param page
     * @param rows
     * @param blog
     * @param response
     * @return
     */
    @RequestMapping("/list")
    public String list(@RequestParam(value = "page", required = false) String page,
                       @RequestParam(value = "rows", required = false) String rows,
                       Blog blog,
                       HttpServletResponse response) {
        PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("title", blog.getTitle());
        hashMap.put("start", pageBean.getStart());
        hashMap.put("size", pageBean.getPageSize());
        //获取博客分类分页数据
        List<Blog> blogList = blogService.findBlogList(hashMap);

        //获取博客分类总个数
        long total = blogService.getBlogCount(hashMap);
        JsonConfig config = new JsonConfig();
        config.registerJsonValueProcessor(Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
        //将数据写入响应流
        return ResponseUtil.setSelResult(response, total, JSONArray.fromObject(blogList, config));
    }

    /**
     * 根据id获取博客数据
     *
     * @param id       博客id
     * @param response 响应数据流
     * @return
     */
    @RequestMapping("/findById")
    public String findById(@RequestParam("id") String id, HttpServletResponse response) {
        Blog blog = blogService.selBlogById(Integer.parseInt(id));
        try {
            ResponseUtil.write(response, JSONObject.fromObject(blog));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 修改博客数据
     *
     * @param blog
     * @param response
     * @return
     */
    @RequestMapping("/editBlog")
    public String editBlog(Blog blog, HttpServletResponse response) throws Exception {
        Integer flag = blogService.updateBlog(blog);
        blogIndex.updateIndex(blog);
        return ResponseUtil.setInsOrDelOrUpdResult(response, flag > 0, null);
    }


    /**
     * 根据博客ID删除博客数据
     *
     * @param ids      id字符串
     * @param response 响应流对象
     * @return 操作结果
     */
    @RequestMapping("/delBlogById")
    public String delBlogById(@RequestParam("ids") String ids, HttpServletResponse response) {

        String[] idsStr = ids.split(",");
        List<Integer> delIDs = new ArrayList<>();
        for (String idStr : idsStr) {
            delIDs.add(Integer.parseInt(idStr));
        }
        int flag = -1;
        try {
            flag = blogService.delBlogByIds(delIDs);
            for (int i = 0; i < delIDs.size(); i++) {
                blogIndex.deleteIndex(delIDs.get(i).toString());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseUtil.setInsOrDelOrUpdResult(response, flag > 0, null);
    }
}
