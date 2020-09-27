package com.wcc.realm;

import com.wcc.pojo.Blogger;
import com.wcc.service.BloggerService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;

/**
 * @program: blog
 * @description: 安全管理(登录权限验证)
 * @author: WuChen
 * @create: 2020-09-17 12:52
 */
public class MyRealm extends AuthorizingRealm {


    @Resource
    private BloggerService bloggerService;

    /**
     * 获取授权信息
     *
     * @param principalCollection
     * @return
     */
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        return null;
    }

    /**
     * 登录验证
     *
     * @param authenticationToken 令牌，基于用户名和密码的令牌
     * @return
     * @throws AuthenticationException
     */
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        //从令牌中取出用户名
        String userName = (String) authenticationToken.getPrincipal();
        //让Shiro去验证账号密码
        Blogger blogger = bloggerService.getByUserName(userName);
        if (null != blogger) {
            SecurityUtils.getSubject().getSession().setAttribute("currentUser", blogger);
            SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(blogger.getUserName(), blogger.getPassword(), getName());
            return authenticationInfo;
        }
        return null;
    }
}
