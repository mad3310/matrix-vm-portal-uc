package com.letvcloud.uc.dao;

import com.letvcloud.saas.util.cache.CacheClient;
import com.letvcloud.saas.util.cache.IValueGetter;
import com.letvcloud.uc.dao.dto.EnterpriseDto;
import com.letvcloud.uc.dao.dto.PersonDto;
import com.letvcloud.uc.dao.dto.UserDto;
import com.letvcloud.uc.mapper.UserMapper;
import com.letvcloud.uc.po.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @author hanfeng
 * @date 15/8/6
 */

@Component("userMapperDao")
public class UserMapperDao implements UserMapper{

    @Autowired
    private UserMapper userMaper;

    @Autowired
    private CacheClient cacheClient;

    @Override
    public User getUserById(final  Long id) {
        return (User) cacheClient.get(getUserIdKey(id),600, new IValueGetter() {
            @Override
            public Object getValue(String s) {
                return userMaper.getUserById(id);
            }
        });
    }

    private String getUserIdKey(Long id) {
        return "uc:userId: " + id;
    }
    private String getUserEmailKey(String email) {
        return "uc:userEmail:" + email;
    }

   private String getUserUUKey(String unique){
       return "uc:userUu:" + unique;
    }
    @Override
    public int savePersonalUser(User user) {
        cacheClient.delete(getUserIdKey(user.getId()));
        cacheClient.delete(getUserEmailKey(user.getEmail()));
        cacheClient.delete(getUserUUKey(user.getUserUnique()));
        return userMaper.savePersonalUser(user);
    }

    @Override
    public int saveEnterpriseUser(User user) {

        cacheClient.delete(getUserIdKey(user.getId()));
        cacheClient.delete(getUserEmailKey(user.getEmail()));
        cacheClient.delete(getUserUUKey(user.getUserUnique()));
        return userMaper.saveEnterpriseUser(user);
    }

    @Override
    public List<User> getUserByEmail(final String email) {

        return (List<User>) cacheClient.get(getUserEmailKey(email),600,new IValueGetter() {
            @Override
            public Object getValue(String s) {
                return userMaper.getUserByEmail(email);
            }
        });

    }

    @Override
    public List<User> getUserByMobile(String mobile,String areaInput) {
        return userMaper.getUserByMobile(mobile,areaInput);
    }

    @Override
    public User getUserByUnique(final String unique) {
        return (User) cacheClient.get(getUserUUKey(unique),600, new IValueGetter() {
            @Override
            public Object getValue(String s) {
                return userMaper.getUserByUnique(unique);
            }
        });
    }

    @Override
    public int modifyPersonalUserById(@Param("userDto") UserDto userDto, @Param("id") Long id) {

        User user = getUserById(id);
        if(user == null){
            return 0;
        }

        cacheClient.delete(getUserIdKey(id));
        cacheClient.delete(getUserEmailKey(user.getEmail()));
        cacheClient.delete(getUserUUKey(user.getUserUnique()));

        return userMaper.modifyPersonalUserById(userDto,id);

    }

    @Override
    public int modifyEnterPriseUserById(@Param("userDto") UserDto userDto, @Param("id") Long id) {

        User user = getUserById(id);
        if(user == null){
            return 0;
        }

        cacheClient.delete(getUserIdKey(id));
        cacheClient.delete(getUserEmailKey(user.getEmail()));
        cacheClient.delete(getUserUUKey(user.getUserUnique()));
        return userMaper.modifyEnterPriseUserById(userDto, id);
    }

    @Override
    public int modifyPasswordById(@Param("id") Long id, @Param("password") String password) {
        User user = getUserById(id);
        if(user == null){
            return 0;
        }

        cacheClient.delete(getUserIdKey(id));
        cacheClient.delete(getUserEmailKey(user.getEmail()));
        cacheClient.delete(getUserUUKey(user.getUserUnique()));
        return userMaper.modifyPasswordById(id, password);
    }

    @Override
    public int modifyMobileById(@Param("id") Long id,@Param("countryCode")String countryCode, @Param("mobile") String mobile) {
        User user = getUserById(id);
        if(user == null){
            return 0;
        }

        cacheClient.delete(getUserIdKey(id));
        cacheClient.delete(getUserEmailKey(user.getEmail()));
        cacheClient.delete(getUserUUKey(user.getUserUnique()));
        return userMaper.modifyMobileById(id,countryCode,mobile);
    }

    @Override
    public int addEnterpriseAuthen(@Param("id") Long entId, @Param("enterpriseDto") EnterpriseDto enterpriseDto) {
        User user = getUserById(entId);
        if(user == null){
            return 0;
        }

        cacheClient.delete(getUserIdKey(entId));
        cacheClient.delete(getUserEmailKey(user.getEmail()));
        cacheClient.delete(getUserUUKey(user.getUserUnique()));
        return userMaper.addEnterpriseAuthen(entId, enterpriseDto);
    }

    @Override
    public int modifyUserEmailStatus(@Param("id") Long id, @Param("status") Integer status) {
        User user = getUserById(id);
        if(user == null){
            return 0;
        }

        cacheClient.delete(getUserIdKey(id));
        cacheClient.delete(getUserEmailKey(user.getEmail()));
        cacheClient.delete(getUserUUKey(user.getUserUnique()));

        return userMaper.modifyUserEmailStatus(id, status);
    }

    @Override
    public int updateEnterpriseAuthen(@Param("id") Long entId, @Param("enterpriseDto") EnterpriseDto enterpriseDto) {
        User user = getUserById(entId);
        if(user == null){
            return 0;
        }

        cacheClient.delete(getUserIdKey(entId));
        cacheClient.delete(getUserEmailKey(user.getEmail()));
        cacheClient.delete(getUserUUKey(user.getUserUnique()));
        return userMaper.updateEnterpriseAuthen(entId, enterpriseDto);
    }

    @Override
    public int updatePersonAuthen(@Param("id") Long entId, @Param("personDto") PersonDto personDto) {
        User user = getUserById(entId);
        if(user == null){
            return 0;
        }

        cacheClient.delete(getUserIdKey(entId));
        cacheClient.delete(getUserEmailKey(user.getEmail()));
        cacheClient.delete(getUserUUKey(user.getUserUnique()));
        return userMaper.updatePersonAuthen(entId, personDto);
    }

    @Override
    public int updateUserAvatar(@Param("id") Long entId, @Param("userAvatar") String userAvatar) {
        User user = getUserById(entId);
        if(user == null){
            return 0;
        }

        cacheClient.delete(getUserIdKey(entId));
        cacheClient.delete(getUserEmailKey(user.getEmail()));
        cacheClient.delete(getUserUUKey(user.getUserUnique()));
        return userMaper.updateUserAvatar(entId, userAvatar);
    }

    @Override
    public List<User> findGreaterIds(@Param("id") Long id) {
        return userMaper.findGreaterIds(id);
    }

    @Override
    public void startOrStopCustomer(@Param("id") Long id, @Param("userStatus") int userStatus) {
        User user = getUserById(id);
        if(user == null){
            return ;
        }

        cacheClient.delete(getUserIdKey(id));
        cacheClient.delete(getUserEmailKey(user.getEmail()));
        cacheClient.delete(getUserUUKey(user.getUserUnique()));

        userMaper.startOrStopCustomer(id,userStatus);

    }

    @Override
    public int modifyProxyUserById(@Param("userDto") UserDto userDto, @Param("id") Long id) {
        User user = getUserById(id);
        if(user == null){
            return 0;
        }

        cacheClient.delete(getUserIdKey(id));
        cacheClient.delete(getUserEmailKey(user.getEmail()));
        cacheClient.delete(getUserUUKey(user.getUserUnique()));
        return userMaper.modifyProxyUserById(userDto,id);
    }

    @Override public void modifyUserOldStatus(Long id, Integer isOld) {
        cacheClient.delete(getUserIdKey(id));
        userMaper.modifyUserOldStatus(id,isOld);
    }

    @Override
    public void modifyQualificationsAuthen(Long id, Integer examineStatus) {
        User user = getUserById(id);
        if(user == null){
            return ;
        }

        cacheClient.delete(getUserIdKey(id));
        cacheClient.delete(getUserEmailKey(user.getEmail()));
        cacheClient.delete(getUserUUKey(user.getUserUnique()));
        userMaper.modifyQualificationsAuthen(id,examineStatus);
    }

}
