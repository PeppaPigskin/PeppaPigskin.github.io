package com.wcc.controller.admin;

import com.wcc.pojo.BlogType;
import com.wcc.service.BlogTypeService;
import com.wcc.util.ConstantsUtil.Const;
import com.wcc.util.ResponseUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * @program: blog
 * @description: 系统管理控制器
 * @author: WuChen
 * @create: 2020-09-22 22:16
 */
@Controller
@RequestMapping("/admin/systemManager")
public class SystemManagerController {

    @Resource
    private BlogTypeService blogTypeService;

    /**
     * 刷新系统资源
     *
     * @param request  请求
     * @param response 响应流
     * @return 刷新结果（true/false）
     */
    @RequestMapping("/refreshSystemResource")
    public String refreshSystemResource(HttpServletRequest request, HttpServletResponse response) {
        try {
            //获取ApplicationContext对象
            ServletContext application = RequestContextUtils.getWebApplicationContext(request).getServletContext();
            List<BlogType> allBlogTypes = blogTypeService.selAllBlogType();
            application.setAttribute(Const.RESOURCE_PARAM_BLOG_TYPE_LIST_NAME, allBlogTypes);
            return ResponseUtil.setInsOrDelOrUpdResult(response, true, null);
        } catch (Exception e) {
            return ResponseUtil.setInsOrDelOrUpdResult(response, false, null);
        }

    }

}
