package com.letvcloud.uc.mapper;

import java.util.List;

import com.letvcloud.uc.dao.dto.EnterpriseDto;
import com.letvcloud.uc.dao.dto.PersonDto;
import com.letvcloud.uc.dao.dto.UserDto;
import com.letvcloud.uc.mapper.annotations.MyBatisDao;
import com.letvcloud.uc.po.User;
import org.apache.ibatis.annotations.Param;

/**
 * Created by zhaoliang5 on 2015/6/17.
 */
@MyBatisDao
public interface UserMapper {
    User getUserById(Long id);

    int savePersonalUser(User user);

    int saveEnterpriseUser(User user);

    List<User> getUserByEmail(String email);

    List<User> getUserByMobile(@Param("mobile") String mobile,@Param("areaInput") String areaInput);

    User getUserByUnique(String unique);

    int modifyPersonalUserById(@Param("userDto") UserDto userDto, @Param("id")Long id);

    int modifyEnterPriseUserById(@Param("userDto") UserDto userDto, @Param("id") Long id);

    int modifyPasswordById(@Param("id") Long id, @Param("password") String password);

    int modifyMobileById(@Param("id") Long id,@Param("countryCode")String countryCode, @Param("mobile") String mobile);

    //User getUserByUsernameAndPassword(@Param("username") String username, @Param("password") String password);

    int addEnterpriseAuthen(@Param("id") Long entId, @Param("enterpriseDto") EnterpriseDto enterpriseDto);

    int modifyUserEmailStatus(@Param("id") Long id, @Param("status") Integer status);

    int updateEnterpriseAuthen(@Param("id") Long entId, @Param("enterpriseDto") EnterpriseDto enterpriseDto);

    int updatePersonAuthen(@Param("id") Long entId, @Param("personDto") PersonDto personDto);

    int updateUserAvatar(@Param("id") Long entId, @Param("userAvatar") String userAvatar);

    List<User> findGreaterIds(@Param("id") Long id);

    void startOrStopCustomer(@Param("id")Long id,@Param("userStatus")int userStatus);

    int modifyProxyUserById(@Param("userDto") UserDto userDto, @Param("id") Long id);

    void modifyUserOldStatus(Long id, Integer isOld);

    void modifyQualificationsAuthen(@Param("id")Long id,@Param("examineStatus")Integer examineStatus);
}