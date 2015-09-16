package com.letvcloud.uc.service;

import com.letvcloud.uc.exception.UcUserInfoException;
import com.letvcloud.uc.ms.model.UcUserInfo;
import com.letvcloud.uc.ms.service.UcUserInfoService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * @author hanfeng
 * @date 15/7/15
 */
@ActiveProfiles("local")
@RunWith(SpringJUnit4ClassRunner.class)
// 指定测试用例的运行器 这里是指定了Junit4
@ContextConfiguration({"/applicationContext_junit.xml"})
public class userInfoTest {

    @Autowired
    UcUserInfoService ucUserInfoService;

    @Test
    public void testGetUcUserInfo() throws UcUserInfoException {
        UcUserInfo ucUserInfo = ucUserInfoService.getUcUserInfo(10000l);
        String password = ucUserInfo.getPassword();
        System.out.println(password);
    }

}
