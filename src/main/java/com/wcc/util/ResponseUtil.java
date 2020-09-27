package com.wcc.util;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

/**
 * @program: blog
 * @description: 写入response的工具类
 * @author: WuChen
 * @create: 2020-09-18 16:28
 */
public class ResponseUtil {

    /**
     * 向响应流中写入对象
     *
     * @param response
     * @param o
     * @throws IOException
     */
    public static void write(HttpServletResponse response, Object o) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        PrintWriter writer = response.getWriter();
        writer.println(o.toString());
        writer.flush();
        writer.close();
    }

    /**
     * 设置增删改操作处理结果
     *
     * @param response   响应流对象
     * @param flag       处理标志(true：处理成功；false:处理失败)
     * @param messageMap 附加的响应数据集合
     * @return
     */
    public static String setInsOrDelOrUpdResult(HttpServletResponse response, boolean flag, Map<String, Object> messageMap) {
        JSONObject result = new JSONObject();
        if (messageMap != null && messageMap.size() > 0) {
            for (Map.Entry<String, Object> entry : messageMap.entrySet()) {
                result.put(entry.getKey(), entry.getValue());
            }
        }
        if (flag) {
            result.put("success", Boolean.valueOf(true));
        } else {
            result.put("success", Boolean.valueOf(false));
        }
        try {
            write(response, result);
        } catch (IOException e) {
            result.put("success", Boolean.valueOf(false));
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 设置查询列表数据响应流结果集
     *
     * @param response  响应流对象
     * @param count     结果数
     * @param jsonArray 对象JSONArray
     * @return
     */
    public static String setSelResult(HttpServletResponse response, Long count, JSONArray jsonArray) {
        JSONObject result = new JSONObject();
        JSONArray array = jsonArray;
        result.put("rows", array);
        if (count != null)
            result.put("total", count);
        try {
            ResponseUtil.write(response, result);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
