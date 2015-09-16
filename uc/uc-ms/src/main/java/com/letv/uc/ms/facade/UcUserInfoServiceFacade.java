package com.letv.uc.ms.facade;

import com.letvcloud.uc.ms.dto.UcUserInfoServiceStateDTO;
import com.letvcloud.uc.ms.model.UcUserInfo;
import com.letvcloud.uc.exception.UcUserInfoException;
import com.letvcloud.uc.exception.UcUserInfoServiceSFException;
import com.letvcloud.uc.exception.UcUserInfoServiceTOAException;
import com.letvcloud.uc.pojo.PaginationSupport;

import java.util.Map;

/**
 * Created by ggmaster on 15/9/1.
 */
public interface UcUserInfoServiceFacade {


    boolean updateUcUserInfoState(Map<String, String> map) throws UcUserInfoException;

    UcUserInfoServiceStateDTO getUcUserInfoServiceStateDTO(Long id) throws UcUserInfoServiceTOAException,
            UcUserInfoException;

    /* 更新资质 */
    boolean updateUcUserInfoCertificate(UcUserInfo ucUserInfo) throws UcUserInfoException,
            UcUserInfoServiceSFException;

    PaginationSupport findUcUserInfoCertificatePage(Map<String, String> findMap) throws UcUserInfoException;
}
