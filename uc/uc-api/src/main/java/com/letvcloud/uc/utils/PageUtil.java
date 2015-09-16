package com.letvcloud.uc.utils;

public class PageUtil{
    
    public static int getSize(int per) {
    
        return per <= 0 ? 10 : per;
    }
    
    public static int getStart(int page, int size) {
    
        return page <= 0 ? 0 : (page - 1) * size;
    }
    
    public static int getPage(int start, int size) {
    
        return (start / size) + 1;
    }
}
