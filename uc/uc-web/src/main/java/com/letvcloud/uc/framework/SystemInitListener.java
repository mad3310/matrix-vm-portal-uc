package com.letvcloud.uc.framework;

import com.letvcloud.saas.exception.MessageHelper;
import com.letvcloud.saas.exception.ProgramException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.io.File;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 系统初始化
 *
 * @author liufengyu
 * @date 2012-9-11
 */
public class SystemInitListener implements ServletContextListener {
    private static final Logger logger = LoggerFactory.getLogger(SystemInitListener.class);
    private static String confPath = null;

    /**
     * 取得配置文件的Map
     *
     * @param filePath 文件路径
     * @return
     * @author fangqi
     * @date 2012-9-11
     */
    public static Map<String, File> getConFileMap(File filePath) {
        Map<String, File> confFilesMap = new LinkedHashMap<String, File>();
        for (File file : filePath.listFiles()) {
            if (file.isFile()) {
                confFilesMap.put(file.getName(), file);
            }
        }
        return confFilesMap;
    }

    /**
     * 初始化方法
     *
     * @param sce 上下文
     */
    public void contextInitialized(ServletContextEvent sce) {
//        confPath = sce.getServletContext().getRealPath("/") + "WEB-INF" + File.separator + "conf";
//
//        // 初始化日志
//        try {
//            LogConfig.config(confPath + File.separator + "logback.xml");
//        } catch (JoranException e) {
//            throw new ProgramException(e);
//        }

        logger.info("RtmpLive-Api System initializing...");

        try {
            MessageHelper.getInstance().addMessageFile("message_saas-util.xml");
            MessageHelper.getInstance().addMessageFile("message_uc-web.xml");
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            throw new ProgramException(e);
        }

        logger.info("Live-Api System initialized");
    }

    /**
     * 上下文销毁
     *
     * @param sce 上下文
     */
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
