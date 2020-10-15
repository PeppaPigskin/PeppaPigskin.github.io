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

    /**
     * 获取相应日期的指定格式
     *
     * @param date   日期对象
     * @param format 指定格式
     * @return
     */
    public static String formatDate(Date date, String format) {
        String result = "";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
        if (date != null) {
            result = simpleDateFormat.format(date);
        }
        return result;
    }
}
