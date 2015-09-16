package com.letvcloud;

import com.letvcloud.saas.exception.MessageHelper;
import com.letvcloud.saas.exception.ProgramException;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

/**
 * @author liufengyu
 * @date 2014年11月12日
 */
@Component
public class SystemInit {
//	private static final Logger logger = LoggerFactory.getLogger(SystemInit.class);

    @PostConstruct
    public void initialize() {
        try {
            // 初始化异常消息
            MessageHelper.getInstance().addMessageFile("message_uc.xml");
            MessageHelper.getInstance().addMessageFile("message_saas-util.xml");
        } catch (Exception e) {
            throw new ProgramException(e);
        }
    }
}
