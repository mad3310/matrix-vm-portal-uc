package com.letvcloud.uc.ms.service;

import com.letvcloud.uc.ms.dto.UcUserInfoCQDTO;
import com.letvcloud.uc.ms.dto.UcUserInfoPQDTO;
import com.letvcloud.uc.ms.model.UcUserInfo;
import com.letvcloud.uc.exception.UcUserInfoException;
import com.letvcloud.uc.pojo.PaginationSupport;

import java.util.List;
import java.util.Map;

public interface UcUserInfoService {
    
    
    PaginationSupport findUcUserInfoPage(Map<String, String> params) throws UcUserInfoException;
    
    
    List<UcUserInfo> findUcUserInfo(Map<String, String> findMap) throws UcUserInfoException;
    
    
    UcUserInfo getUcUserInfo(Long id) throws UcUserInfoException;
    
    
    UcUserInfoPQDTO getUcUserInfoPQDTO(Long id) throws UcUserInfoException;
    
    
    boolean updateUcUserInfo(UcUserInfo ucUserInfo) throws UcUserInfoException;


    PaginationSupport findUcUserInfoCertificatePage(Map<String, String> params) throws UcUserInfoException;


    UcUserInfoCQDTO getUcUserInfoCQDTO(Long id) throws UcUserInfoException;
    

}
