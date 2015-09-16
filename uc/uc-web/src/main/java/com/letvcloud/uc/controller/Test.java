package com.letvcloud.uc.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.letvcloud.saas.util.HttpAPI;
import com.letvcloud.saas.util.MD5Util;

import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by wanglei14 on 2015/7/14.
 */
public class Test {
    public static void main(String[] args) throws Exception{
//        String s = HttpAPI.executeGet(1000,1000,
//                "http://115.182.51.244:20080/userInfo/getMonthlyIncrement/100001?type=0");
//        JSONObject obj = JSON.parseObject(s);
        //System.out.println(1025L/1024);
//        System.out.println(obj.getJSONObject("data").get("duration"));
//        System.out.println("003".matches("001|002"));
        Calendar cal = Calendar.getInstance();
        System.out.println(cal.get(Calendar.MONTH));
    }
}
