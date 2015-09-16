package com.letvcloud.uc.controller;

import com.letvcloud.saas.util.IPUtil;
import com.letvcloud.uc.security.UserContext;
import com.letvcloud.uc.po.User;
import com.letvcloud.uc.service.UserService;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by zhaoliang5 on 2015/6/30.
 */
@Controller
public class BaseController {
    @Autowired
    private  UserService userService;
    public User getCurrentUser(HttpServletRequest request) {
        User user = UserContext.currUser();
        if(user!=null){
            return userService.getUserById(UserContext.currUser().getId());
        }else{
            return null;
        }

    }
    /**
     * 向ftl模板渲染数据
     *
     * @param template
     * @param model
     * @return
     */
    public static String renderTemplate(Template template, Object model) {
        StringWriter result = new StringWriter();
        try {
            template.process(model, result);
        } catch (TemplateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result.toString();
    }

    /**
     * 获取日志记录参数
     * @param req
     * @return
     */
    public Map getLogParam(HttpServletRequest req){
        String ip = IPUtil.getIpAddr(req);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String currentDate = sdf.format(new Date());
        Map<String,String> logParams = new HashMap<String,String>();
        logParams.put("ip",ip);
        logParams.put("currentDate",currentDate);
        return logParams;
    }

}
