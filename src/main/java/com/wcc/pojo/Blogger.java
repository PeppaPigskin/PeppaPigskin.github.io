package com.wcc.pojo;

import com.wcc.util.ConstantsUtil.BloggerTypeEnum;

import java.io.Serializable;

/**
 * 博客账户实体类
 *
 * @author: WuChen
 * @create: 2020-09-17 16:41
 */
public class Blogger implements Serializable {

    /**
     * 序列化ID
     */
    private static final long serialVersionUID = 1L;
    /**
     * 主键
     */
    private Integer id;
    /**
     * 用户名
     */
    private String userName;
    /**
     * 密码
     */
    private String password;
    /**
     * 个人信息
     */
    private String profile;
    /**
     * 昵称
     */
    private String nickName;
    /**
     * 个性签名
     */
    private String sign;
    /**
     * 头像地址
     */
    private String imageName;
    /**
     * 账户类型
     */
    private BloggerTypeEnum accountType;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

    public String getImageName() {
        return imageName;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    public BloggerTypeEnum getAccountType() {
        return accountType;
    }

    public void setAccountType(BloggerTypeEnum accountType) {
        this.accountType = accountType;
    }

    @Override
    public String toString() {
        return "Blogger{" +
                "id=" + id +
                ", userName='" + userName + '\'' +
                ", password='" + password + '\'' +
                ", profile='" + profile + '\'' +
                ", nickName='" + nickName + '\'' +
                ", sign='" + sign + '\'' +
                ", imageName='" + imageName + '\'' +
                ", accountType=" + accountType +
                '}';
    }
}
