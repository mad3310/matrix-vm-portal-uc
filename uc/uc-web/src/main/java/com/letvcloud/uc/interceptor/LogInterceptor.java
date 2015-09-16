package com.letvcloud.uc.interceptor;

import com.letvcloud.saas.util.RandomUtil;
import com.letvcloud.saas.util.StringUtil;
import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;
import java.util.Map.Entry;


/**
 * @author liufengyu
 * @date 2012-01-04
 */
public class LogInterceptor implements HandlerInterceptor {
    private static final Logger logger = LoggerFactory.getLogger(LogInterceptor.class);

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        try {
            if (handler instanceof HandlerMethod) {
                HandlerMethod handlerMethod = (HandlerMethod) handler;
                long end = System.currentTimeMillis();
                long start = Long.parseLong(request.getAttribute("requestStart").toString());
                long cost = end - start;
                logger.info("cost:{}ms;method:{}", cost, handlerMethod.getMethod().getName());
            }

            MDC.clear();
        } catch (Exception e) {
            logger.error("日志拦截器异常：" + e.getMessage(), e);
        }
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView model)
            throws Exception {
        try {
            if (logger.isDebugEnabled()) {
                if (handler instanceof HandlerMethod) {
                    HandlerMethod handlerMethod = (HandlerMethod) handler;
                    logger.debug("controler={};method={};view={};model=[{}]", handlerMethod.getBean().getClass()
                                    .getSimpleName(), handlerMethod.getMethod().getName(),
                            model == null ? null : model.getViewName(),
                            model == null ? null : this.modelToString(model));
                }
            }
        } catch (Exception e) {
            logger.warn("日志拦截器异常postHandle：" + e.getMessage(), e);
        }
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        try {
            MDC.put("SeqId", RandomUtil.generateNumAndLetterStr(8));
            long start = System.currentTimeMillis();
            request.setAttribute("requestStart", start);

            // 输入参数debug日志
            if (logger.isDebugEnabled()) {
                if (!(handler instanceof HandlerMethod)) {
                    return true;
                }
                HandlerMethod handlerMethod = (HandlerMethod) handler;
                if (MapUtils.isEmpty(request.getParameterMap())) {
                    logger.debug("controler={};method={};", handlerMethod.getBean().getClass().getSimpleName(),
                            handlerMethod.getMethod().getName());
                    return true;
                }
                StringBuffer sb = new StringBuffer();
                // 必须这么些，其他方式遍历不出来
                for (Object key : request.getParameterMap().keySet()) {
                    sb.append(key.toString()).append("=")
                            .append(ServletRequestUtils.getStringParameter(request, key.toString(), "")).append(";");
                }

                logger.debug("controler={};method={};input={}", handlerMethod.getBean().getClass().getSimpleName(),
                        handlerMethod.getMethod().getName(), limitTo100(sb.toString()));
            }
        } catch (Exception e) {
            logger.error("日志拦截器异常：" + e.getMessage(), e);
        }
        return true;
    }

    private String modelToString(ModelAndView modelAndView) {
        StringBuffer sb = new StringBuffer();
        if (modelAndView == null) {
            return "";
        }
        Map<String, Object> model = modelAndView.getModel();
        if (model == null) {
            return "";
        }
        for (Entry<String, Object> entry : model.entrySet()) {
            sb.append(entry.getKey()).append("=").append(this.limitTo100(StringUtil.object2Str(entry.getValue())))
                    .append(";");
        }

        return sb.toString();
    }

    private String limitTo100(String value) {
        if (value != null && value.length() > 500) {
            value = value.substring(0, 500);
            return value + " ...";
        }
        return value;
    }
}
