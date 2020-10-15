package com.wcc.util;


/**
 * @program: blog
 * @description: 博客管理系统相关静态字段
 * @author: WuChen
 * @create: 2020-09-20 08:16
 */
public class ConstantsUtil {

    /**
     * 系统密钥
     */
    public static final String SALT = "java1234";

    /**
     * 博客账户类型枚举
     */
    public enum BloggerTypeEnum {
        /**
         * 超级管理员
         */
        BLOGGER_TYPE_ADMIN(0, "超级管理员"),
        /**
         * 普通管理员
         */
        BLOGGER_TYPE_MANAGER(1, "普通管理员"),
        /**
         * 普通用户
         */
        BLOGGER_TYPE_USER(2, "普通用户");

        /**
         * 枚举对应数据库实际存储值
         */
        private final int value;
        /**
         * 枚举值描述
         */
        private final String desc;

        /**
         * 构造器
         *
         * @param value
         * @param desc
         */
        private BloggerTypeEnum(int value, String desc) {
            this.value = value;
            this.desc = desc;
        }

        /**
         * 获取真实值
         */
        public int getValue() {
            return value;
        }

        /**
         * 获取描述信息
         */
        public String getDesc() {
            return desc;
        }

    }

    /**
     * 评论审核状态枚举
     */
    public enum CommentStateEnum {

        /**
         * 待审核
         */
        COMMENT_STATE_PENDING(0, "待审核"),
        /**
         * 审核已通过
         */
        COMMENT_STATE_REVIEW_PASSED(1, "审核已通过"),

        /**
         * 审核未通过
         */
        COMMENT_STATE_AUDIT_FAILED(2, "审核未通过");

        /**
         * 枚举对应数据库实际存储值
         */
        private final int value;
        /**
         * 枚举值描述
         */
        private final String desc;

        /**
         * 构造器
         *
         * @param value
         * @param desc
         */
        private CommentStateEnum(int value, String desc) {
            this.value = value;
            this.desc = desc;
        }

        /**
         * 获取真实值
         */
        public int getValue() {
            return value;
        }

        /**
         * 获取描述信息
         */
        public String getDesc() {
            return desc;
        }
    }


    /**
     * 系统常量类
     */
    public class Const {
        /**
         * 存储当前登录账户在session中的键
         */
        public static final String CURRENT_USER = "currentUser";
        /**
         * 博客类型集合名
         */
        public static final String RESOURCE_PARAM_BLOG_TYPE_LIST_NAME = "blogTypeListName";

        /**
         * 博主
         */
        public static final String RESOURCE_PARAM_BLOGGER_NAME = "bloggerAdmin";

        /**
         * 每个年月对应的博客数集合
         */
        public static final String RESOURCE_PARAM_BLOG_COUNT_LIST = "blogCountList";

        /**
         * 友情链接集合名
         */
        public static final String RESOURCE_PARAM_LINK_LIST = "linkList";

        /**
         * 最新博客集合名
         */
        public static final String RESOURCE_PARAM_NEWEST_BLOG = "newestBlog";


    }

}
