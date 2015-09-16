package com.letvcloud.uc.framework.exceptionResolver;

import com.letvcloud.saas.controller.FastJsonView;
import com.letvcloud.saas.exception.BusinessException;
import com.letvcloud.saas.exception.UnknownExceptionAlerter;
import com.letvcloud.saas.util.IPUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 统一异常处理类
 *
 * @author fangqi
 * @date 2013-2-25
 */
@Component
public class CommonExceptionResolver implements HandlerExceptionResolver {
    private Logger logger = LoggerFactory.getLogger(CommonExceptionResolver.class);

    //	private static final int FAILURE = 0;
    @Autowired
    private UnknownExceptionAlerter unknownExceptionAlerter;

    @Override
    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
                                         Exception ex) {
        ModelAndView model = new ModelAndView();
        String clientIp = IPUtil.getIpAddr(request);

        String ajaxHeader = request.getHeader("X-Requested-With");// 获取是否为ajax请求

        // **data
        if (ex instanceof BusinessException) { // 业务逻辑异常,给前台用户交互message
            String errCode = ((BusinessException) ex).getErrorCode();
            String errMsg = ex.getMessage();
            logger.error("业务逻辑异常:clientIp={}，errorcode={},errormessage={}", clientIp, errCode, errMsg);

            model.addObject("errCode", ((BusinessException) ex).getErrorCode());
            model.addObject("errMsg", errMsg);
            if(StringUtils.isEmpty(ajaxHeader)){
                model.setViewName("400");
            }else{
                model.setView(new FastJsonView());
            }
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);

            return model;
        } else {
            // 其他异常
            logger.error(clientIp + "，" + ex.getMessage(), ex);
            model.addObject("errMsg", "[" + MDC.get("SeqId") + "] other Exception。");

            try {
                sendEmail(ex, request, response); // 发送报警邮件
            } catch (Exception e) {
                logger.error(e.getMessage(), e);
            }
            if(StringUtils.isEmpty(ajaxHeader)){
                model.setViewName("500");
            }else{
                model.setView(new FastJsonView());
            }
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return model;
        }
    }

    /**
     * 发送邮件，对html语法支持不是很好，有空开发个txt发送邮件接口
     *
     * @param ex       异常
     * @param request  request
     * @param response response
     * @author piaohailin
     * @date 2012-3-19
     */
    public void sendEmail(Throwable ex, HttpServletRequest request, HttpServletResponse response) {
        unknownExceptionAlerter.sendEmail(ex, request);
    }

}
