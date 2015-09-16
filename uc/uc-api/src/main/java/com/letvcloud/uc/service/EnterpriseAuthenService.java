package com.letvcloud.uc.service;

import com.letvcloud.uc.vo.AuthenVo;

/**
 * 企业认证服务
 * @author lyx
 *
 */
public interface EnterpriseAuthenService {
	public void updateEnterpriseAuthen(Long entId, AuthenVo authenVo);
	/**
	 * 获取资质认证状态
	 * @param entId 账户id
	 * @return true 通过 flase 尚未通过
	 */
	public boolean getEnterproseAuthenStatus(Long entId);


	/**
	 * 获取资质认证状态
	 * @param entId 账户id
	 * @return 0 未通过 ，1 通过 ，2 等待审核， NULL 用户未上传资质信息
	 */
	public Integer getEnterproseAuthenStatusInfo(Long entId);

	/**
	 * 未通过及未进行过认证的可以进行资质认证
	 * @param entId
	 * @return
	 */
	public boolean isToAuthen(Long entId);

	/**
	 * 进行资质审核
	 * @param entId
	 * @param authenFlag   0 通过，1 等待，2 未通过，null 用户从未上传资质信息
	 */
	public void toAuthen(Long entId,Integer authenFlag);
}
