package com.letvcloud.uc.service;

import com.letvcloud.uc.po.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * @author hanfeng
 * @date 15/7/15
 */
@RunWith(SpringJUnit4ClassRunner.class)
// 指定测试用例的运行器 这里是指定了Junit4
@ContextConfiguration({"/applicationContext_junit.xml"})
public class userUniqueTest {

    @Autowired
    UserService userService;

    @Test
    public void testMakeUserUniqe() {
            UserServiceImpl userService1 = (UserServiceImpl) userService;
            String unique = userService1.makeUnique();
            System.out.println(unique);
    }

    @Test
    public void testGetUserId(){
        for(int i=0;i<10;i++){
            System.out.println(userService.getUserId());

        }
    }
}
