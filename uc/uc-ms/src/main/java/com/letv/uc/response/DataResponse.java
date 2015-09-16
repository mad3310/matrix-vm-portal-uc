package com.letv.uc.response;

import java.io.Serializable;

public class DataResponse implements Serializable{
    
    private String result;
    private String message;
    private Object data;
    private String responseCode;
    
    public DataResponse() {
    
    }
    
    public String getResult() {
    
        return result;
    }
    
    public void setResult(String result) {
    
        this.result = result;
    }
    
    public String getMessage() {
    
        return message;
    }
    
    public void setMessage(String message) {
    
        this.message = message;
    }
    
    public Object getData() {
    
        return data;
    }
    
    public void setData(Object data) {
    
        this.data = data;
    }
    
    public String getResponseCode() {
    
        return responseCode;
    }
    
    public void setResponseCode(String responseCode) {
    
        this.responseCode = responseCode;
    }
}
