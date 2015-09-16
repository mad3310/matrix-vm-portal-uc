package com.letvcloud.uc.security;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;

import com.letvcloud.uc.po.User;

/**
 * 登录用户上下文
 * @author wanghui7
 *
 */
public class UserContext {
	public static User currUser() {
		Subject subject = SecurityUtils.getSubject();
		if(subject!=null) {
			return (User)subject.getPrincipal();
		}
		return null;
	}
	
	public static String currUsername() {
		User user = currUser();
		return user==null?null:user.getEmail();
	}
}
