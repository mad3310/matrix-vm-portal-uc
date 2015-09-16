package com.letvcloud.uc.service;

import com.letvcloud.uc.dao.dto.PersonDto;
import com.letvcloud.uc.mapper.UserMapper;
import com.letvcloud.uc.po.User;
import com.letvcloud.uc.utils.constant.UserExamineContant;
import com.letvcloud.uc.vo.AuthenVo;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service(value="personAuthenService")
public class PersonAuthenServiceImpl implements PersonAuthenService{
	@Autowired
	private UserMapper userMapperDao;
	public void updateEnterpriseAuthen(Long entId, AuthenVo authenVo) {
		PersonDto personDto = new PersonDto();
		BeanUtils.copyProperties(authenVo, personDto);
		userMapperDao.updatePersonAuthen(entId, personDto);
	}
	@Override
	public boolean getPersonAuthenStatus(Long userId) {
		User user = userMapperDao.getUserById(userId);
		if(user!=null&&UserExamineContant.THROUGH.equals(user.getExamineStatus())){
			return true;
		}else{
			return false;
		}
	}
	
	
}
