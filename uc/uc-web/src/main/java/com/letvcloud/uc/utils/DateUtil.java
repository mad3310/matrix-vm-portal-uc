/*
 */
package com.letvcloud.uc.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public abstract class DateUtil {
	
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");

	/**
	 * 实现日期加一个月
	 * @param str 
	 * @return
	 */
	 public static Date addMonth(String str) {   
         try {   
              Calendar cd = Calendar.getInstance();   
              cd.setTime(sdf.parse(str));   
              cd.add(Calendar.MONTH, 1);//增加一个月   
              return cd.getTime();   
              } catch (Exception e) {   
                  return null;   
              }
	 }
	 
	 /**
	  * @param 格式化日期
	  * @return
	  */
	 public static Date formatDate(String str) {
         try {   
             	return sdf.parse(str);   
             } catch (Exception e) {   
                 return null;   
             }
	 }


}
