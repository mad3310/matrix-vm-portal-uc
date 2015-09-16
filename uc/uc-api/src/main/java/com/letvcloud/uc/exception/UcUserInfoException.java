package com.letvcloud.uc.exception;

public class UcUserInfoException extends Exception{
    public UcUserInfoException(Exception e) {
    
        super(e);
    }
    
    public UcUserInfoException(String msg) {
    
        super(msg);
    }
    
}
