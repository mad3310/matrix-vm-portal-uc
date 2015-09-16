package com.letvcloud.uc.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.letvcloud.saas.util.cache.CacheClient;
import com.letvcloud.uc.po.User;
import com.letvcloud.uc.service.UserService;
import com.letvcloud.uc.utils.Const;
import com.letvcloud.uc.utils.constant.UserStatusContant;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.web.util.SavedRequest;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.util.HtmlUtils;

import java.util.Map;


@Controller
public class Login2Controller extends BaseController {


    Logger logger = LoggerFactory.getLogger("login");

    @Autowired
    CacheClient cacheClient;

    @Autowired
    SecurityManager securityManager;

    @Autowired
    UserService userService;

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(HttpServletRequest req, HttpServletResponse response, String username, String password, boolean remember, String backUrl, String captchaCode, Model model) {
        String error = null;

        username = HtmlUtils.htmlEscape(username);
        password = HtmlUtils.htmlEscape(password);
        backUrl = HtmlUtils.htmlEscape(backUrl);
        captchaCode = HtmlUtils.htmlEscape(captchaCode);

        SecurityUtils.setSecurityManager(securityManager);
        //3、得到Subject及创建用户名/密码身份验证Token（即用户身份/凭证）
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(username, password, remember);
        Map<String, String> logParams = getLogParam(req);
        String ip = logParams.get("ip");
        String currentDate = logParams.get("currentDate");
        String user_unique = "";
        String mobile = "";
        String errorReason = "";

        try {
            //4、登录，即身份验证

            String cacheCaptchParam = (String) cacheClient.get(Const.captchaHead + subject.getSession().getId());
            cacheClient.delete(Const.captchaHead + subject.getSession().getId());
            if (StringUtils.isNotEmpty(captchaCode) && captchaCode.equalsIgnoreCase(cacheCaptchParam)) {
                subject.login(token);

                User user = getCurrentUser(req);
                if (user.getUserStatus() != UserStatusContant.ENABLE) {
                    error = "该用户已停用";
                }

                user_unique = user.getUserUnique();
                mobile = user.getMobile();
                user_unique = user.getUserUnique();

                logger.info("inLogin###user_unique:{}###username:{}###mobile:{}###ip:{}###state:{}###failereason:{}###date:{}", user_unique, username, mobile
                        , ip, "success", errorReason, currentDate);

            } else {
                model.addAttribute("password", password);
                error = "验证码错误";
                logger.info("inLogin###user_unique:{}###username:{}###mobile:{}###ip:{}###state:{}###failereason:{}###date:{}", user_unique, username, mobile
                        , ip, "failed", error, currentDate);
            }
        } catch (AuthenticationException e) {
            String exceptionClassName = e.getClass().getName();
            if (UnknownAccountException.class.getName().equals(exceptionClassName)) {
                error = "用户名/密码错误";
            } else if (LockedAccountException.class.getName().equals(exceptionClassName)) {
                error = "用户名/密码错误";
            } else if (DisabledAccountException.class.getName().equals(exceptionClassName)) {
                error = "用户名/密码错误";
            } else if (IncorrectCredentialsException.class.getName().equals(exceptionClassName)) {
                error = "用户名/密码错误";
            } else if (AuthenticationException.class.getName().equals(exceptionClassName)) {
                error = "用户名/密码错误";
            } else if (exceptionClassName != null) {
                error = "其他错误：" + exceptionClassName;
            }
            logger.info("inLogin###user_unique:{}###username:{}###mobile:{}###ip:{}###state:{}###failereason:{}###date:{}", user_unique, username, mobile
                    , ip, "failed", error, currentDate);

        }
        if (error != null) {
            logger.info("inLogin###userName:{}###error:{}", username, error);
            if (StringUtils.isNotBlank(backUrl)) {
                model.addAttribute("backUrl", backUrl);
            }
            model.addAttribute("username", username);
            model.addAttribute("error", error);
            return "login";
        }
        if (StringUtils.isNotBlank(backUrl)) {
            return "redirect:" + backUrl;
        }

        SavedRequest savedRequest = WebUtils.getSavedRequest(req);
        if (savedRequest != null) {
            String url = savedRequest.getRequestUrl();
            if (url != null && !url.contains("logout")) {
                return "redirect:" + url;
            }
        }

        return "redirect:/userView/ucOverview.do";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String gotoLogin(HttpServletRequest req, HttpServletResponse response, String backUrl, Model model) {
        User user = getCurrentUser(req);

        if (user != null) {
            if (StringUtils.isNotBlank(backUrl)) {
                return "redirect:" + backUrl;
            } else {
                return "redirect:/userView/ucOverview.do";
            }
        }
        model.addAttribute("backUrl", backUrl);

        return "login";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpServletRequest req, HttpServletResponse response, Model model) {
        Subject subject = SecurityUtils.getSubject();
        User user = getCurrentUser(req);
        if (user != null) {
            model.addAttribute("username", user.getEmail());
        }
        subject.logout();

        return "login";
    }

}