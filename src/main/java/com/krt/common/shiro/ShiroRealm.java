package com.krt.common.shiro;

import com.krt.common.constant.SysConstant;
import com.krt.common.util.ShiroUtils;
import com.krt.sys.entity.Res;
import com.krt.sys.entity.User;
import com.krt.sys.enums.UserStatus;
import com.krt.sys.service.ResService;
import com.krt.sys.service.UserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: 自定义Realm
 * @date 2016年4月18日
 */
@Component
public class ShiroRealm extends AuthorizingRealm {

    @Autowired
    private UserService userService;

    @Autowired
    private ResService resService;

    /**
     * 为当前登录的Subject授予角色和权限
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        //为当前用户设置角色和权限
        SimpleAuthorizationInfo simpleAuthorInfo = new SimpleAuthorizationInfo();
        User currentUser = ShiroUtils.getCurrentUser();
        String roleCode = currentUser.getRoleCode();
        //为当前用户设置角色
        simpleAuthorInfo.addRole(roleCode);
        //获取角色权限
        List<Res> list = resService.selectListByRoleCode(roleCode);
        for (Res res : list) {
            String permission = res.getPermission();
            if (permission != null && !"".equals(permission)) {
                simpleAuthorInfo.addStringPermission(permission);
            }
        }
        return simpleAuthorInfo;
    }


    /**
     * 验证当前登录的Subject
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {
        //获取基于用户名和密码的令牌  
        //实际上这个authcToken是从LoginController里面currentUser.login(token)传过来的
        String password = new String((char[]) authcToken.getCredentials());
        //两个token的引用都是一样的
        UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
        User currentUser = userService.selectByUsername(token.getUsername());
        //账号不存在
        if (currentUser == null) {
            throw new UnknownAccountException("账号或密码不正确");
        }
        //密码错误
        if (!password.equals(currentUser.getPassword())) {
            throw new IncorrectCredentialsException("账号或密码不正确");
        }
        //账号锁定
        if (UserStatus.FORBIDDEN.getStatus().equals(currentUser.getStatus())) {
            throw new LockedAccountException("账号已被锁定,请联系管理员");
        }
        AuthenticationInfo authcInfo = new SimpleAuthenticationInfo(currentUser.getUsername(), currentUser.getPassword(), "");
        ShiroUtils.setSessionAttribute(SysConstant.CURRENT_USER, currentUser);
        return authcInfo;
    }

}