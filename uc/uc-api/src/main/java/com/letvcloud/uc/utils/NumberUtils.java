package com.letvcloud.uc.utils;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * Created by zhaoliang5 on 2015/6/16 17:12.
 */
public class NumberUtils {




    /**
     * 交易号码生成规则:年月日时分秒毫秒+5位随机数
     *
     * @return
     */
    public static String getTradingNum() {
        String date = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date());
//
        return date + getFiveRandomNum();
    }

    /**
     * 生成0-9999之间的随机数小于1000补0显示
     * @return
     */
    public static String getFiveRandomNum() {
        return new DecimalFormat("00000").format(new Random().nextInt(100000));
    }
    
    
    /**
     * 生成0-999999之间的随机数小于1000000补0显示
     * @return
     */
    public static String getSixRandomNum() {
        return new DecimalFormat("000000").format(new Random().nextInt(1000000));
    }

}
