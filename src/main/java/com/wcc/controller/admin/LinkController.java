package com.wcc.controller.admin;

import com.wcc.pojo.Link;
import com.wcc.pojo.PageBean;
import com.wcc.service.LinkService;
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
 * LinkController:【blog-友情链接控制层】
 *
 * @author: WuChen
 * @create: 2020-09-27 09:47
 * @modify:
 */
@Controller
@RequestMapping("/admin/link")
public class LinkController {

    @Resource
    private LinkService linkService;

    /**
     * 获取友情链接列表
     *
     * @param page     当前页（可不设置）
     * @param rows     每页记录数（可不设置）
     * @param response 响应流
     * @return
     */
    @RequestMapping("/list")
    public String linkList(@RequestParam(value = "page", required = false) String page,
                           @RequestParam(value = "rows", required = false) String rows,
                           HttpServletResponse response) {
        PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
        Map<String, Object> map = new HashMap<>();
        map.put("start", pageBean.getStart());
        map.put("size", pageBean.getPageSize());
        List<Link> links = linkService.selLinkByMap(map);
        long count = linkService.selLinkCountByMap(map);
        return ResponseUtil.setSelResult(response, count, JSONArray.fromObject(links));
    }

    /**
     * 保存友情链接数据
     *
     * @param link     友情链接
     * @param response 响应流
     * @return
     */
    @RequestMapping("/save")
    public String save(Link link, HttpServletResponse response) {
        int flag = -1;
        if (link.getId() != null) {//修改操作
            flag = linkService.updLink(link);
        } else {//新增操作
            flag = linkService.insLink(link);
        }
        return ResponseUtil.setInsOrDelOrUpdResult(response, flag > 0, null);
    }


    /**
     * 批量删除友情链接操作
     *
     * @param ids      主键
     * @param response 响应流
     * @return
     */
    @RequestMapping("/remove")
    public String remove(@RequestParam("ids") String ids, HttpServletResponse response) {
        String[] idsStr = ids.split(",");
        int flag = -1;
        try {
            for (String idStr : idsStr) {
                flag = linkService.delLink(Integer.parseInt(idStr));
            }
        } catch (Exception e) {
            e.printStackTrace();
            flag = -1;
        }
        return ResponseUtil.setInsOrDelOrUpdResult(response, flag > 0, null);
    }


}
