package com.letv.uc.ms.controller;

import com.letvcloud.saas.util.session.SessionProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * index页面和登陆页面controller
 *
 * @author liufengyu
 * @date 2014年4月15日
 */
@Controller
@RequestMapping(value = "/*")
public class IndexController {
    @Autowired
    private SessionProvider sessionProvider;

    /**
     * 进入index页面
     *
     * @param request request
     * @return
     * @author fangqi
     * @date 2012-9-25
     */
    @RequestMapping(value = {"/", "/index"}, method = RequestMethod.GET)
    public ModelAndView index(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView("index");

        // 设置session不过期
        modelAndView.addObject("userName", sessionProvider.getAttribute(request, "userName"));
        modelAndView.addObject("tel", sessionProvider.getAttribute(request, "tel"));
        modelAndView.addObject("userId", sessionProvider.getAttribute(request, "userId"));

        return modelAndView;
    }
}
