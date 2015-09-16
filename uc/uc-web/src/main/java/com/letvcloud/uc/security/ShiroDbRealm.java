package com.letvcloud.uc.security;

import javax.annotation.PostConstruct;

import com.letvcloud.saas.exception.BusinessException;
import com.letvcloud.uc.service.UserService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import com.letvcloud.uc.po.User;
/**
 * 认证鉴权实现类
 * @author wanghui7
 *
 */
public class ShiroDbRealm extends AuthorizingRealm{
	@Autowired
	private UserService userService;
	
	/**
	 * 鉴权
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection arg0) {
		return null;
	}
	
	/**
	 * 认证
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken arg0) throws AuthenticationException {
		UsernamePasswordToken token = (UsernamePasswordToken) arg0;
		
		User user = null;
		try {
			user = userService.getUserByEmail(token.getUsername());
		} catch (BusinessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new UnknownAccountException();
		}
		
		if(user==null) {
			throw new UnknownAccountException();
		}
		return new SimpleAuthenticationInfo(user,user.getPassword(),getName());
	}
	
	@PostConstruct
	public void initCredentialsMatcher() {
		setCredentialsMatcher(new CustomCredentialsMatcher(userService));
	}
	
	@Override
    public void clearCachedAuthorizationInfo(PrincipalCollection principals) {
        super.clearCachedAuthorizationInfo(principals);
    }

    @Override
    public void clearCachedAuthenticationInfo(PrincipalCollection principals) {
        super.clearCachedAuthenticationInfo(principals);
    }
    
    @Override
    protected Object getAuthorizationCacheKey(PrincipalCollection principals) {
        User user = (User)principals.getPrimaryPrincipal();
        return user.getEmail();
    }
    
    @Override
    protected Object getAuthenticationCacheKey(AuthenticationToken token) {
        return token.getPrincipal();
    }
    
    @Override
    protected Object getAuthenticationCacheKey(PrincipalCollection principals) {
        User user = (User)super.getAvailablePrincipal(principals);
        return user.getEmail();
    }
}
