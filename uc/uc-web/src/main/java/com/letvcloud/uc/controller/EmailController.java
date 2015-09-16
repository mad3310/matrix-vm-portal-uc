package com.letvcloud.uc.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.letvcloud.uc.po.User;
import com.letvcloud.uc.service.MessageBusService;
import com.letvcloud.uc.service.UserService;
import com.letvcloud.uc.utils.MD5Utils;
import com.letvcloud.uc.utils.constant.EmailStatusContant;
import com.letvcloud.uc.utils.constant.FlagContant;

/**
 * Created by zhaoliang5 on 2015/7/4.
 */


@Controller
@RequestMapping("/email")
public class EmailController extends BaseController {


    @Autowired
    private UserService userService;

    @Autowired
    private MessageBusService messageBusService;
    @Value("#{configProperties['path']}")
    private String path;

    @RequestMapping("/activate")
    public String activate(HttpServletRequest request,String id, String time, String sign) {

        String result = StringUtils.EMPTY;

        if (StringUtils.isNotBlank(id) && StringUtils.isNotBlank(time) && StringUtils.isNotBlank(sign)) {
            String srcSign = MD5Utils.str2MD5(id + time + MD5Utils.getKey());
            if (srcSign.equals(sign)) {
                userService.modifyUserEmailStatus(Long.parseLong(id), EmailStatusContant.ACTIVATE);
                request.setAttribute("activeFlag","邮箱激活成功");
            }
        } else {
            request.setAttribute("activeFlag","邮箱激活失败");
        }


        return "activeEmailResult";
    }


    @RequestMapping("/sendActivateEmail")
    @ResponseBody
    public String sendActivateEmail(HttpServletRequest request) throws IOException {
        User user = getCurrentUser(request);
        messageBusService.sendRegMobileEmail(user.getId());
        return FlagContant.SUCCESS_FLAG;
    }




}