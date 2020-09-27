package com.wcc.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * DateUtil:【blog-日期工具类】
 *
 * @author: WuChen
 * @create: 2020-09-25 14:53
 * @modify:
 */
public class DateUtil {

    /**
     * 获取当前时间精确到秒的时间字符串
     *
     * @return
     */
    public static String getCurrentDateStr() {
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMddhhmmss");
        return format.format(date);
    }
}
