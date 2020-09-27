package com.wcc.util;

/**
 * @program: blog
 * @description: 字符串操作工具类
 * @author: WuChen
 * @create: 2020-09-20 20:46
 */
public class StringUtil {

    /**
     * 字符串前后添加%
     *
     * @param str 操作字符串
     * @return 操作结果
     */
    public static String formatLike(String str) {
        if (isNotEmpty(str)) {
            return '%' + str + '%';
        }
        return null;

    }

    /**
     * 进行去前后空格判空
     *
     * @param str 需要判断的字符串
     * @return
     */
    public static Boolean isNotEmpty(String str) {
        if (str != null && !"".equals(str.trim())) {
            return true;
        } else {
            return false;
        }
    }
}
