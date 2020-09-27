package com.wcc.util;

import org.apache.shiro.crypto.hash.Md5Hash;

/**
 * @program: blog
 * @description: MD5加密
 * @author: WuChen
 * @create: 2020-09-17 15:54
 */
public class MD5Util {

    /**
     * md5加密
     *
     * @param str  明文
     * @param salt 密钥
     * @return 密文
     */
    public static String md5(String str, String salt) {
        return new Md5Hash(str, salt).toString();
    }

    /**
     * 测试MD5加密
     *
     * @param args
     */
    public static void main(String[] args) {
        System.out.println(md5("1", ConstantsUtil.SALT));
    }

}
