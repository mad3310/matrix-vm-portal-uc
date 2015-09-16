package com.letvcloud.uc.exception;

public class UcUserInfoServiceTOAException extends Exception{
    public UcUserInfoServiceTOAException(Exception e) {
    
        super(e);
    }
    
    public UcUserInfoServiceTOAException(String msg) {
    
        super(msg);
    }
    
}