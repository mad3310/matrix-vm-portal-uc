package com.letvcloud.uc.filter;

import com.letvcloud.uc.utils.constant.UserSessionKey;
import com.letvcloud.uc.service.UserService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.HttpCookie;
import java.util.UUID;


/**
 * Created by zhaoliang5 on 2015/6/19 14:37.
 */
public class LoginFilter implements Filter {

    private UserService userService;

    private String sessionIdName = "lecloud_uc_jsessionid";

    private ApplicationContext applicationContext;

    private String[] notInterceptorReq;

    public void init(FilterConfig filterConfig) throws ServletException {
        String notInterceptorReqStr = filterConfig.getInitParameter("notInterceptorReq");
        if (StringUtils.isNotBlank(notInterceptorReqStr)) {
            notInterceptorReq = notInterceptorReqStr.split(",");
        }
    }

    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        Cookie[] cookies = request.getCookies();
        String sessionId = null;
        for(Cookie cookie :cookies){
            if(sessionIdName.equals(cookie.getName())){
              sessionId = cookie.getValue();

            }
        }

        if(sessionId == null){
            sessionId = UUID.randomUUID().toString();

        }

        String requestURI = request.getRequestURI();
        String backUrl = request.getHeader("Referer");

        if (StringUtils.isBlank(backUrl)) {
            backUrl = request.getRequestURL().toString();
        }


//        Object userId = session.getAttribute(UserSessionKey.USER_SESSION_KEY);
        String contextPath = request.getContextPath();
//
//        if (notInterceptorReq != null && notInterceptorReq.length > 0) {
//            for (String notInterceptorReqVal : notInterceptorReq) {
//                if (userId != null || requestURI.endsWith(notInterceptorReqVal)) {
//                    filterChain.doFilter(request, servletResponse);
//                    return;
//                }
//            }
//        }
        response.sendRedirect(contextPath + "/login/loginView.do?backUrl=" + backUrl);
    }

    public void destroy() {

    }
}