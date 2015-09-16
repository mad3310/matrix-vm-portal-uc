package com.letvcloud.uc.exception;

public class UcUserInfoServiceSFException extends Exception{
    public UcUserInfoServiceSFException(Exception e) {
    
        super(e);
    }
    
    public UcUserInfoServiceSFException(String msg) {
    
        super(msg);
    }
    
}
