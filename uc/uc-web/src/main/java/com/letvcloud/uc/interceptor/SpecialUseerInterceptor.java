package com.letvcloud.uc.interceptor;

import com.letvcloud.uc.po.User;
import com.letvcloud.uc.security.UserContext;
import com.letvcloud.uc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author hanfeng
 * @date 15/8/2
 */

public class SpecialUseerInterceptor implements HandlerInterceptor {

    private String vodServiceUrl = "http://vod.letvcloud.com/";

    @Autowired
    private UserService userService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {


        User user = UserContext.currUser();
        if(user!=null){
            User user1 =  userService.getUserById(UserContext.currUser().getId());
            if(user1.getUserType() == 7){
                response.sendRedirect(vodServiceUrl);
                return  false;
            }else{
                return true;
            }
        }else{
            return true;
        }
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
