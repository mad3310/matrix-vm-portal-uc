package com.letvcloud.uc.controller;

import com.letvcloud.bill.service.BillUserAmountService;
import com.letvcloud.saas.exception.BusinessException;
import com.letvcloud.uc.po.User;
import com.letvcloud.uc.service.UserService;
import com.letvcloud.uc.vo.UserVo;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by zhaoliang5 on 2015/6/29.
 */

@Controller
@RequestMapping("/register")
public class RegisterController extends BaseController{

    Logger logger1 = LoggerFactory.getLogger(RegisterController.class);
    Logger logger = LoggerFactory.getLogger("register");

    @Autowired
    private UserService userService;


    @Autowired
    private BillUserAmountService billUserAmountService;



    @RequestMapping("registerUser")
    public String registerUser(HttpServletRequest request,UserVo userVo) throws BusinessException {
        String errorMsg="";
        String logFlag="";
        Map<String,String> logParams = this.getLogParam(request);
        String ip = logParams.get("ip");
        String currentDate = logParams.get("currentDate");
        String mobile = userVo.getMobile();
        if(userService.getUserByMobile(mobile, userVo.getCountryCode()) != null) {//如果手机号已经被注册过，就不能再注册了
            errorMsg="手机号已被使用";
            logFlag="error";
            request.setAttribute("errorMsg","您的手机号已经被使用!");
            logger.info("inRegister###user_unique:{}###username:{}###mobile:{}###ip:{}###refer:{}###state:{}###failereason:{}###date:{}", "", userVo.getEmail(), mobile
                    , ip, request.getHeader("REFERER"), logFlag, errorMsg, currentDate);
            return "regFailure";
        }
        String email = userVo.getEmail();
        if(userService.getUserByEmail(email) != null){
            errorMsg="邮箱被使用";
            logFlag = "error";
            request.setAttribute("errorMsg","您的邮箱已经被使用!");
            logger.info("inRegister###user_unique:{}###username:{}###mobile:{}###ip:{}###refer:{}###state:{}###failereason:{}###date:{}", "", userVo.getEmail(), mobile
                    , ip, request.getHeader("REFERER"), logFlag, errorMsg, currentDate);
            return "regFailure";
        }
        try{
            User user = userService.registerUser(userVo);
            if (user != null) {
                billUserAmountService.createUserAmount(user.getId());
            }
            request.setAttribute("type", "1");

            request.setAttribute("email",user.getEmail());
            request.setAttribute("mobile", user.getMobile());
            logFlag="success";
            logger.info("inRegister###user_unique:{}###username:{}###mobile:{}###ip:{}###refer:{}###state:{}###failereason:{}###date:{}",user.getUserUnique(),user.getEmail(),mobile
                    ,ip,request.getHeader("REFERER"),logFlag,errorMsg,currentDate);
        }catch (Exception e){//注册未成功
            logFlag="error";
            errorMsg=e.getMessage();
            e.printStackTrace();
            logger.error("", e);
            request.setAttribute("errorMsg", "系统异常!");
            logger.info("inRegister###user_unique:{}###username:{}###mobile:{}###ip:{}###refer:{}###state:{}###failereason:{}###date:{}", "", userVo.getEmail(), mobile
                    , ip, request.getHeader("REFERER"), logFlag, errorMsg, currentDate);
            return "regFailure";
        }

        try{
            login(userVo.getEmail(), userVo.getPassword());
        }catch (Exception e){//登录未成功！
            e.printStackTrace();
            logger.error("" , e);
        }


        return "regSuccess";
    }

    //登录
    private void login(String username,String password){
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(username, password, false);
        subject.login(token);
    }

}