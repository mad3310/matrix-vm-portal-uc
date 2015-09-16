package com.letvcloud.uc.service;

import com.letvcloud.uc.dao.dto.EnterpriseDto;
import com.letvcloud.uc.mapper.UserMapper;
import com.letvcloud.uc.po.User;
import com.letvcloud.uc.utils.constant.UserExamineContant;
import com.letvcloud.uc.vo.AuthenVo;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service(value="enterpriseAuthenService")
public class EnterpriseAuthenServiceImpl implements EnterpriseAuthenService{
	@Autowired
	private UserMapper userMapperDao;
	public void updateEnterpriseAuthen(Long entId, AuthenVo authenVo){
		EnterpriseDto enterpriseDto = new EnterpriseDto();
		BeanUtils.copyProperties(authenVo, enterpriseDto);
		int count = userMapperDao.updateEnterpriseAuthen(entId, enterpriseDto);
	}
	@Override
	public boolean getEnterproseAuthenStatus(Long entId) {
		User user = userMapperDao.getUserById(entId);
		if(user!=null&&user.getExamineStatus()!=null&&UserExamineContant.THROUGH.intValue()==user.getExamineStatus().intValue()){
			return true;
		}
		return false;
	}


	@Override
	public Integer getEnterproseAuthenStatusInfo(Long entId) {
		User user = userMapperDao.getUserById(entId);

		return user.getExamineStatus();
	}

	@Override
	public boolean isToAuthen(Long entId) {
		User user = userMapperDao.getUserById(entId);
		if(user!=null&&(user.getExamineStatus()==null||user.getExamineStatus().intValue()==UserExamineContant.NOT_THROUGH.intValue())){
			return true;
		}
		return false;
	}

	@Override
	public void toAuthen(Long entId, Integer authenFlag) {
		userMapperDao.modifyQualificationsAuthen(entId,authenFlag);
	}


}
