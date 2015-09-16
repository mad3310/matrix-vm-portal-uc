package com.letvcloud.uc.service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.letvcloud.saas.exception.BusinessException;
import com.letvcloud.saas.util.RandomUtil;
import com.letvcloud.saas.util.redis.RedisService;
import com.letvcloud.uc.dao.dto.UserDto;
import com.letvcloud.uc.mapper.UserMapper;
import com.letvcloud.uc.po.User;
import com.letvcloud.uc.utils.CheckUtils;
import com.letvcloud.uc.utils.MD5Utils;
import com.letvcloud.uc.utils.constant.UserStatusContant;
import com.letvcloud.uc.utils.constant.UserTypeContant;
import com.letvcloud.uc.vo.UserVo;

/**
 * Created by zhaoliang5 on 2015/6/14.
 */
@Service("userService")
public class UserServiceImpl implements UserService {

    private static final Logger logger = Logger.getLogger(UserServiceImpl.class);

    @Resource
    private UserMapper userMapperDao;
/*
    @Autowired
    private CacheClient cacheClient;*/

    @Autowired
    RedisService redisService;

    @Autowired
    MessageBusService messageBusService;

    @Value("#{configProperties['runtime.environment']}")
    private String env;

    private String userIdCacheKey = "userCurId";

    Lock uniqueLock = new ReentrantLock();


    @Override
    public long getUserId() {
        long newUserId = redisService.incrBy(userIdCacheKey, 1L);
        if("prod".equals(env)){
            if (newUserId < 800000){
                synchronized (UserServiceImpl.class){
                    redisService.getRedisTemplate().opsForValue().set(userIdCacheKey,"800000");
                    newUserId = 800000;
                }
            }
        }else {
            if (newUserId < 400000){
                synchronized (UserServiceImpl.class){
                    redisService.getRedisTemplate().opsForValue().set(userIdCacheKey,"400000");
                    newUserId = 400000;
                }
            }
        }
        return newUserId;
 /*       long newUserId = 100000;
        Long userId =  (Long)cacheClient.get(userIdCacheKey);
        if(userId != null) {
            newUserId = userId + 1;
        }
        cacheClient.set(userIdCacheKey,0,newUserId);
        return newUserId;*/
    }

    @Override
    public boolean setUserId(long firstUserId,boolean forced) {
       /* if(forced || cacheClient.get(userIdCacheKey)== null) {
            cacheClient.set(userIdCacheKey,0, firstUserId);
            return Boolean.TRUE;
        }
        return Boolean.FALSE;*/
        if(forced || redisService.getRedisTemplate().opsForValue().get(userIdCacheKey)== null) {
            redisService.getRedisTemplate().opsForValue().set(userIdCacheKey, new Long(firstUserId).toString());
            return Boolean.TRUE;
        }
        return Boolean.FALSE;
    }

    //    @Transactional
    public User registerUser(UserVo userVo) {

        if (userVo == null) {
            return null;
        }

        User user = new User();

        BeanUtils.copyProperties(userVo, user);
        user.setUserStatus(UserStatusContant.ENABLE);


        String unique = makeUnique();

        user.setUserUnique(unique);


        user.setPassword(computePassword(user.getPassword(),unique));


        String userKey = user.getContacts() + user.getPassword();
        user.setUserKey(MD5Utils.str2MD5(userKey));

        Integer userType = user.getUserType();
        user.setId(getUserId());
        int total = 0;
        if (userType.intValue() == UserTypeContant.PERSONAL.intValue())
            total = userMapperDao.savePersonalUser(user);
        else if (userType.intValue() == UserTypeContant.ENTERPRISE.intValue() ||userType.intValue() == UserTypeContant.ENTERPRISEINPROXY.intValue()  )
            total = userMapperDao.saveEnterpriseUser(user);

        return total > 0 ? user : null;

    }

    public String makeUnique() {
        uniqueLock.lock();
        String unique = null;
        try {
            for (; ; ) {
                unique = RandomUtil.generateNumAndLetterStr(10).toLowerCase();
                User user = userMapperDao.getUserByUnique(unique);
                if (user == null) break;
            }
        }catch (Exception e){

        }finally {
            uniqueLock.unlock();
        }
        return unique;
    }

    public User getUserById(Long id) {
        return userMapperDao.getUserById(id);
    }

    public User getUserByEmail(String email) throws BusinessException {
    	List<User> list = userMapperDao.getUserByEmail(email);
    	if(list!=null&&list.size()==1){
    		return list.get(0);
    	}else if(list==null||list.size()==0){
    		return null;
    	}else{
    		throw new BusinessException("E05107",email,list.size());
    	}
    }

    public User getUserByMobile(String mobile,String areaInput) throws BusinessException {
    	List<User> list = userMapperDao.getUserByMobile(mobile,areaInput);
    	if(list!=null&&list.size()==1){
    		return list.get(0);
    	}else if(list==null||list.size()==0){
    		return null;
    	}else{
    		throw new BusinessException("E05106",mobile,list.size());
    	}
    }

    @Override
    public User getUserByUnique(String unique) {
        return userMapperDao.getUserByUnique(unique);
    }

    public void modifyUserInfo(Long id, UserVo userVo) {

        if (id == null || userVo == null) {
            //TODO:
        }
        int total = 0;
        Integer userType = userVo.getUserType();
        UserDto userDto = new UserDto();
        BeanUtils.copyProperties(userVo, userDto);
        if (userType.intValue() == UserTypeContant.PERSONAL.intValue())
            total = userMapperDao.modifyPersonalUserById(userDto, id);
        if (userType.intValue() == UserTypeContant.ENTERPRISE.intValue() || userType.intValue() == UserTypeContant.BIGENTERPRISE.intValue() ) {
            total = userMapperDao.modifyEnterPriseUserById(userDto, id);
        }
        if (userType.intValue() == UserTypeContant.ENTERPRISEINPROXY.intValue()) {
            total = userMapperDao.modifyProxyUserById(userDto, id);
        }
        if (total < 1){}
        //TODO:
    }

    public void modifyPassword(Long id, String password) {

        if (StringUtils.isNotBlank(password) && id != null) {

            User user = getUserById(id);
            if(user == null){
                return;
            }
            int total = userMapperDao.modifyPasswordById(id, computePassword(password, user.getUserUnique()));
            if (total < 1)
                //TODO:
            return;
        }
        //TODO:
    }

    public void modifyMobile(Long id, String countryCode,String mobile) {

        if (id != null && StringUtils.isNotBlank(mobile) && CheckUtils.isMobile(mobile)) {
            int total = userMapperDao.modifyMobileById(id, countryCode,mobile);
            if (total < 1)
                //TODO:
            return;
        }
        //TODO:
    }

   /* public User checkUser(String username, String password) {
        return userMapper.getUserByUsernameAndPassword(username, MD5Utils.str2MD5(password));
    }*/

    public void modifyUserEmailStatus(Long id, Integer status) {
        userMapperDao.modifyUserEmailStatus(id, status);
    }

	@Override
	public void modifyUserAvatar(Long id, String userAvatar) {
		if (id != null && StringUtils.isNotBlank(userAvatar)) {
            int total = userMapperDao.updateUserAvatar(id, userAvatar);
            if (total < 1)
                //TODO:
            return;
        }
        //TODO:
	}


    @Override
    public User getUser4Login(String loginName,String areaInput) throws BusinessException {
        if(loginName.contains("@")){
             return  getUserByEmail(loginName);
        }else {
            return getUserByMobile(loginName,areaInput);
        }
    }

    @Override
    public String computePassword(String userPassword, String salt) {
       return MD5Utils.str2MD5(MD5Utils.str2MD5(userPassword)+salt);
    }

    @Override
    public List<Long> findGreaterIds(Long id){
        List<Long> list = new ArrayList<Long>();
        List<User> users = userMapperDao.findGreaterIds(id);
        for(User user : users){
            list.add(user.getId());
        }
        return list;
    }

    @Override
    public void startCustomer(Long id){
        userMapperDao.startOrStopCustomer(id,1);
    }

    @Override
    public void stopCustomer(Long id){
        userMapperDao.startOrStopCustomer(id, 2);
    }

    @Override public void modifyOld(Long id, Integer isOld) {
        userMapperDao.modifyUserOldStatus(id, isOld);
    }
    @Override
    public String sendRegMobileMsg(String countryCode, String mobile, String ipAddr) {
        String mobileAll = countryCode+mobile;
        User userByMobile;
        String msg;
        try {
            userByMobile = this.getUserByMobile(mobile, countryCode);
        } catch (BusinessException e) {
           return "1";
        }
        if(userByMobile==null) {
            msg = messageBusService.sendRegMobileMsg(mobileAll, mobile, ipAddr);
            msg= msg.equals("ok")?"ok":"2";
        }else{
            msg = "1";
        }
        return msg;
    }

}