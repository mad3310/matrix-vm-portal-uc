package com.letv.uc.ms.bd;


import com.letvcloud.uc.exception.UcUserInfoException;

import java.util.Map;

public interface IUcUserInfoServiceBD{
    
    String getUcUserInfoList(Map<String, String> params) throws UcUserInfoException;
    
    String getUcUserInfoPQDTOById(String id) throws UcUserInfoException;
    
    String putUcUserInfoById(String id, Map<String, String> params) throws UcUserInfoException;
    
    String getUcUserInfoCertificateList(Map<String, String> params) throws UcUserInfoException;
    
    String getUcUserInfoCQDTOById(String id) throws UcUserInfoException;
    
    String getUcUserInfoById(String id) throws UcUserInfoException;
    
    String getUcUserInfoServiceStateById(String id) throws UcUserInfoException;
    
    String putUcUserInfoCertificateById(String id, Map<String, String> params) throws UcUserInfoException;
    
    String putUcUserInfoStateById(String id, Map<String, String> params) throws UcUserInfoException;
}
