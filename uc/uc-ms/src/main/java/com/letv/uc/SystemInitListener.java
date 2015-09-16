package com.letv.uc;

import ch.qos.logback.core.joran.spi.JoranException;
import com.letvcloud.saas.exception.MessageHelper;
import com.letvcloud.saas.exception.ProgramException;
import com.letvcloud.saas.util.LogConfig;
import com.letvcloud.saas.util.XmlFileConfigFactory;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.io.File;

/**
 * 系统初始化
 *
 * @author liufengyu
 * @date 2012-9-11
 */
public class SystemInitListener implements ServletContextListener {
    private static final Logger logger = LoggerFactory.getLogger(SystemInitListener.class);
    private static String confPath = null;
    public static String env = null;

    /**
     * 初始化方法
     *
     * @param sce 上下文
     */
    public void contextInitialized(ServletContextEvent sce) {
        env = System.getProperty("spring.profiles.active");
        if (StringUtils.isEmpty(env)) {
            env = "local";
            System.setProperty("spring.profiles.active", env);
        }
        confPath = sce.getServletContext().getRealPath("/") + "WEB-INF" + File.separator + "conf" + File.separator
                + env;

        // 初始化日志
        try {
            LogConfig.config(confPath + File.separator + "logback.xml");
        } catch (JoranException e) {
            throw new ProgramException(e);
        }

        logger.info("UC MS System initializing...");

        try {

            // 初始化异常消息
            MessageHelper.getInstance().addMessageFile("message_uc-ms.xml");

            // 常用配置初始化，比如缓存开关
            XmlFileConfigFactory.init("config.xml");
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            throw new ProgramException(e);
        }

        logger.info("UC MS System initialized");
    }

    /**
     * 上下文销毁
     *
     * @param sce 上下文
     */
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
