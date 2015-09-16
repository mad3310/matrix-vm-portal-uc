package com.letvcloud.uc.utils;

import org.springframework.core.env.Environment;

public class Env{
    
    private static Environment env;
    
    static {
        env = (Environment) SpringUtil.getBean(Environment.class);
    }
    
    public static String get(String key) {
    
        return env.getProperty(key);
    }
    
}
