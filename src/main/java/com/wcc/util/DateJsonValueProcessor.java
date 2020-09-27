package com.wcc.util;

import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @program: blog
 * @description: 日期格式转换工具类
 * @author: WuChen
 * @create: 2020-09-20 21:57
 */
public class DateJsonValueProcessor implements JsonValueProcessor {

    /**
     * 日期格式
     */
    private String format;

    /**
     * 带参构造
     *
     * @param format
     */
    public DateJsonValueProcessor(String format) {
        this.format = format;
    }

    @Override
    public Object processArrayValue(Object o, JsonConfig jsonConfig) {
        return null;
    }

    /**
     * 对传入的日期按照指定格式输出
     *
     * @param key
     * @param value
     * @param jsonConfig
     * @return
     */
    @Override
    public Object processObjectValue(String key, Object value, JsonConfig jsonConfig) {
        if (value == null) {
            return null;
        }
        /*如果是一个时间戳*/
        if (value instanceof Timestamp) {
            return new SimpleDateFormat(this.format).format((Timestamp) value);
        }
        if (value instanceof Date) {
            return new SimpleDateFormat(this.format).format((Date) value);
        }
        return value.toString();
    }
}
