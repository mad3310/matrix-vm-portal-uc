package com.letvcloud.uc.service;


import com.letvcloud.saas.exception.BusinessException;
import com.letvcloud.uc.po.User;
import com.letvcloud.uc.vo.UserVo;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Steven on 2015/6/14.
 */
public interface UserService {

    long getUserId();
    boolean setUserId(long FirstUserId,boolean forced);

    User registerUser(UserVo userVo);

    User getUserById(Long id);

    User getUserByEmail(String email) throws BusinessException;

    User getUserByMobile(String mobile,String areaInput) throws BusinessException;
    User getUserByUnique(String unique);

    void modifyUserInfo(Long id, UserVo userVo);

    void modifyPassword(Long id, String password);

    void modifyMobile(Long id, String countryCode,String mobile);

    //User checkUser(String username, String password);

    void modifyUserEmailStatus(Long id, Integer status);

    void modifyUserAvatar(Long id, String userAvatar);

    User getUser4Login(String loginName,String areaInput) throws BusinessException;


    String computePassword(String userPassword,String salt);

    List<Long> findGreaterIds(Long id);

    void startCustomer(Long id);

    void stopCustomer(Long id);

    void modifyOld(Long id, Integer isOld);

    String sendRegMobileMsg(String countryCode, String mobile, String ipAddr) throws BusinessException;
}
