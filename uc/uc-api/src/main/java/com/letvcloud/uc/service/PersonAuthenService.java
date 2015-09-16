package com.letvcloud.uc.service;

import com.letvcloud.uc.vo.AuthenVo;

/**
 * 个人资质认证服务
 * @author lyx
 *
 */
public interface PersonAuthenService {
	public void updateEnterpriseAuthen(Long userId, AuthenVo authenVo);
	public boolean getPersonAuthenStatus(Long userId);
}
