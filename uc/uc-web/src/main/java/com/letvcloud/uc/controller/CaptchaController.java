package com.letvcloud.uc.controller;

import com.letvcloud.saas.util.cache.CacheClient;
import com.letvcloud.uc.utils.Captcha;
import com.letvcloud.uc.utils.Const;
import com.letvcloud.uc.utils.constant.FlagContant;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.awt.image.BufferedImage;
import java.io.IOException;

/**
 * Created by zhaoliang5 on 2015/7/4.
 */

@Controller
@RequestMapping("/captcha")
public class CaptchaController extends BaseController {

    Logger logger = LoggerFactory.getLogger(CaptchaController.class);
    @Autowired
    private CacheClient cacheClient;

    @Value("captcha.drawLine")
    private String drawLine;


    @RequestMapping("/createCaptcha")
    public void createCaptcha(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Captcha captcha = new Captcha();
        String value = captcha.getText(4);
//        暂时放到session中 后期放入分布式缓存中

        logger.info("session :{},write captcha :{}",request.getSession().getId(),value);
        cacheClient.set(Const.captchaHead+request.getSession().getId(), value);
        BufferedImage image = captcha.getImage(value,"true".equals(drawLine));
        ImageIO.write(image, "jpg", response.getOutputStream());
    }
    
    
    @RequestMapping("/checkCaptcha")
    @ResponseBody
    public String getCurrentCaptcha(HttpServletRequest request,String captcha) throws IOException {
       String oldCaptcha = (String) cacheClient.get(Const.captchaHead+request.getSession().getId());
       if(StringUtils.isNotBlank(oldCaptcha)&&oldCaptcha.toUpperCase().equals(captcha.toUpperCase())){
    	   return FlagContant.SUCCESS_FLAG;
       }else{
    	   return FlagContant.FAILURE_FLAG;
       }
       
    }

    @RequestMapping("/yzmCheck")
    @ResponseBody
    public String yzmCheck( HttpServletRequest request){
        String captchaCode = request.getParameter("captchaCode");
        Subject subject = SecurityUtils.getSubject();
        String cacheCaptchParam = (String) cacheClient.get(Const.captchaHead + subject.getSession().getId());
        if (StringUtils.isNotEmpty(captchaCode) && captchaCode.equalsIgnoreCase(cacheCaptchParam)) {
            return "ok";
        } else {
            return "-1";
        }
    }



    /**
     * 手机验证码
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/createCaptchaForPhone")
    public void createCaptchaForPhone(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Captcha captcha = new Captcha();
        String value = captcha.getText(4);

        logger.info("session :{},write captcha :{}",request.getSession().getId(),value);
        cacheClient.set(Const.captchaPhoneHead + request.getSession().getId(), value);
        BufferedImage image = captcha.getImage(value);
        ImageIO.write(image, "jpg", response.getOutputStream());
    }

    @RequestMapping("/checkCaptchaForPhone")
    @ResponseBody
    public String checkCaptchaForPhone(HttpServletRequest request) throws IOException {
        String captchaCode = request.getParameter("captchaCode");
        Subject subject = SecurityUtils.getSubject();
        String oldCaptcha = (String) cacheClient.get(Const.captchaPhoneHead + subject.getSession().getId());
        if(StringUtils.isNotBlank(oldCaptcha)&&oldCaptcha.toUpperCase().equals(captchaCode.toUpperCase())){
            return FlagContant.SUCCESS_FLAG;
        }else{
            return FlagContant.FAILURE_FLAG;
        }

    }
}