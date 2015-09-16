package com.letvcloud.uc.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.letvcloud.uc.utils.constant.CacheHeadContant;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.letvcloud.saas.exception.BusinessException;
import com.letvcloud.saas.util.IPUtil;
import com.letvcloud.saas.util.StringUtil;
import com.letvcloud.saas.util.cache.CacheClient;
import com.letvcloud.uc.po.Country;
import com.letvcloud.uc.po.User;
import com.letvcloud.uc.service.CountryService;
import com.letvcloud.uc.service.MessageBusService;
import com.letvcloud.uc.service.UserService;
import com.letvcloud.uc.utils.Const;
import com.letvcloud.uc.utils.MD5Utils;
import com.letvcloud.uc.utils.constant.FlagContant;

/**
 * Created by Steven on 2015/7/5.
 */

@RequestMapping("/restPassword")
@Controller
public class RestPasswordController extends BaseController {

    Logger modifyPwdLogger = LoggerFactory.getLogger("modifyPwd");


    @Autowired
    private UserService userService;
    @Autowired
    private MessageBusService messageBusService;

    @Autowired
    private CountryService countryService;

    @Value("#{configProperties['pathPwdByEmail']}")
    private String pathPwdByEmail;
    @Autowired
    private CacheClient cacheClient;


    @RequestMapping(value = "/backPasswordView", method = RequestMethod.GET)
    public String backPasswordView(HttpServletRequest request) {

        List<Country> countryList = countryService.getCountryList();
        request.setAttribute("countryList", countryList);
        return "backPassword";
    }

    /**
     * 通过邮箱找回密码
     * @param request
     * @return
     */
    @RequestMapping(value = "/backPasswordByEmail")
    @ResponseBody
    public String backPasswordByEmail(HttpServletRequest request,String email,String captcha) throws IOException, BusinessException {
        String oldCaptcha = (String) cacheClient.get(Const.captchaHead+request.getSession().getId());
        if(StringUtils.isEmpty(oldCaptcha)||!oldCaptcha.toUpperCase().equals(captcha.toUpperCase())){
            return "restPasswordByEmail";
        }
        User user = userService.getUserByEmail(email);
        messageBusService.sendVerificationEmail(IPUtil.getIpAddr(request),user.getId());
        cacheClient.delete(Const.captchaHead+request.getSession().getId());
        return FlagContant.SUCCESS_FLAG;
    }

    /**
     * 通过邮箱修改密码视图
     * @param request
     * @return
     */
    @RequestMapping(value = "/modifyPwdByEmailView")
    public String modifyPwdByEmailView(HttpServletRequest request,String id,String sign,Long time) {
        Long currentData = System.currentTimeMillis();
        Long diff = currentData-time;
        Long min= (diff % (1000 * 60 * 60)) / (1000 * 60);
        if(min>15){
            //超时
            request.setAttribute("flag",false);
            return "restPasswordResult";
        }
        String key = MD5Utils.getKey();

        String checkSign = MD5Utils.str2MD5(id + time.toString() + key);
        if(checkSign.equals(sign)){
            User user = userService.getUserById(Long.parseLong(id));
            user.getEmail();
            request.setAttribute("email", user.getEmail());
            String a  = (String) cacheClient.get(CacheHeadContant.emailPwdCount + user.getEmail());
            if(user==null||"1".equals(cacheClient.get(CacheHeadContant.emailPwdCount + user.getEmail()))){
                request.setAttribute("flag", false);
                return "restPasswordResult";
            }
            cacheClient.set(CacheHeadContant.emailPwdCount+user.getEmail(),900,"1");
            cacheClient.set(CacheHeadContant.emailKey+user.getEmail(),900,user.getEmail());
            return "restPasswordByEmail";
        }else{
            request.setAttribute("flag", false);
            return "restPasswordResult";
        }

    }

    /**
     * 通过邮箱修改密码
     * @param request
     * @param email
     * @param password
     * @return
     * @throws BusinessException
     */
    @RequestMapping(value = "/modifyPwdByEmail")
    public String modifyPwdByEmail(HttpServletRequest request,String email,String password) throws BusinessException {
        if(email.equals(cacheClient.get(CacheHeadContant.emailKey+email))){

            String flag="";
            String error="";
            if(StringUtil.isEmpty(password)){

                flag="error";
                error="param password is null";
            }else{
                flag ="success";
            }
            User currentUser = this.getCurrentUser(request);





            User user = userService.getUserByEmail(email);
            Map<String,String> logParams = getLogParam(request);
            String ip = logParams.get("ip");
            String currentDate = logParams.get("currentDate");
            String mobile =user.getMobile();
            String user_unique =user.getUserUnique();

            try{
                userService.modifyPassword(user.getId(), password);
            }catch (Exception e){
                error=e.getMessage();
            }
            modifyPwdLogger.info("inEmailModifypwd###user_unique:{}###username:{}###mobile:{}###ip:{}###state:{}###failereason:{}###date:{}", user_unique,
                    email, mobile, ip, flag, error,currentDate);
            request.setAttribute("email", email);
            request.setAttribute("flag",true);
            cacheClient.delete(CacheHeadContant.emailKey + user.getEmail());
        }else{
            request.setAttribute("flag",false);
        }
        return "restPasswordResult";
    }
    /**
     * 通过手机号修改密码视图
     * @param mobile
     * @return
     */
    @RequestMapping(value="backPasswordByMobileView")
    public String backPasswordByMobileView(HttpServletRequest request ,String mobile,String areaInput,String checkcode){
        request.setAttribute("mobile", mobile);
        request.setAttribute("areaInput", areaInput);
        if(StringUtils.isNotBlank(areaInput)&&StringUtils.isNotBlank(mobile)&&StringUtils.isNotBlank(checkcode)){
            if(checkcode.equals(cacheClient.get(areaInput + mobile))){
                cacheClient.delete(areaInput+mobile);
                cacheClient.set(CacheHeadContant.mobileKey+mobile,900,mobile);
                return "restPasswordByMobile";
            }

        }
        request.setAttribute("flag",false);
        return "restPasswordResult";


    }


    /**
     * 通过手机号改密码
     * @param request
     * @param mobile
     * @param password
     * @return
     * @throws BusinessException
     */
    @RequestMapping(value = "/modifyPwdByMobile")
    public String modifyPwdByMobile(HttpServletRequest request,String areaInput,String mobile,String password) throws BusinessException {

        User user = userService.getUserByMobile(mobile,areaInput);
        Map<String,String> logParams = getLogParam(request);
        String ip = logParams.get("ip");
        String currentDate = logParams.get("currentDate");
        String flag="";
        String error="";

        if(user==null||StringUtils.isEmpty(mobile)||StringUtils.isEmpty(password)||
                !mobile.equals(cacheClient.get(CacheHeadContant.mobileKey+mobile))){
            request.setAttribute("flag",false);
            error="user or mobile password is null or authen check is illegal";
            modifyPwdLogger.info("inMobileModifypwd###user_unique:{}###username:{}###mobile:{}###ip:{}###state:{}###failereason:{}###date:{}","",
                    "",mobile,ip,flag,error,currentDate);
            return "restPasswordResult";
        }else{
            flag="success";
            String user_unique =user.getUserUnique();
            modifyPwdLogger.info("inMobileModifypwd###user_unique:{}###username:{}###mobile:{}###ip:{}###state:{}###failereason:{}###date:{}", user_unique,
                    user.getEmail(), mobile, ip, flag, error, currentDate);

            userService.modifyPassword(user.getId(), password);
            request.setAttribute("email", user.getEmail());
            request.setAttribute("flag", true);
            cacheClient.delete(CacheHeadContant.mobileKey + mobile);
        }
        return "restPasswordResult";
    }



}
