package com.letvcloud.uc.filter;

import com.letvcloud.saas.util.RandomUtil;
import com.letvcloud.uc.service.UserService;
import org.apache.commons.lang.StringUtils;
import org.slf4j.MDC;
import org.springframework.context.ApplicationContext;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;


/**
 * Created by zhaoliang5 on 2015/6/19 14:37.
 */
public class SeqIdSetFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {
    }

    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        MDC.put("SeqId", RandomUtil.generateNumAndLetterStr(8));
        filterChain.doFilter(servletRequest, servletResponse);
        MDC.clear();
    }

    public void destroy() {

    }
}