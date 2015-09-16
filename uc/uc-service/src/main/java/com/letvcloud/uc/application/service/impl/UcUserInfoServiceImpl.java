package com.letvcloud.uc.application.service.impl;

import com.letvcloud.uc.ms.dto.UcUserInfoCQDTO;
import com.letvcloud.uc.ms.dto.UcUserInfoPQDTO;
import com.letvcloud.uc.ms.model.UcUserInfo;
import com.letvcloud.uc.ms.repository.UcUserInfoRepository;
import com.letvcloud.uc.ms.service.UcUserInfoService;
import com.letvcloud.uc.exception.UcUserInfoException;
import com.letvcloud.uc.pojo.PaginationSupport;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("ucUserInfoService")
public class UcUserInfoServiceImpl implements UcUserInfoService {

    @Resource
    UcUserInfoRepository ucUserInfoRepository;

    /**
     * 按条件分页查询
     */
    @Override
    public PaginationSupport findUcUserInfoPage(Map<String, String> findMap) throws UcUserInfoException {
        return ucUserInfoRepository.findUcUserInfoPage(findMap);
    }

    /**
     * 按条件查询列表
     */
    @Override
    public List<UcUserInfo> findUcUserInfo(Map<String, String> findMap) throws UcUserInfoException {

        return ucUserInfoRepository.findUcUserInfo(findMap);
    }

    /**
     * 查询个人资质信息
     */
    @Override
    public UcUserInfoPQDTO getUcUserInfoPQDTO(Long id) throws UcUserInfoException {

        UcUserInfo user = this.getUcUserInfo(id);
        return new UcUserInfoPQDTO(user);
    }

    /**
     * 查询企业资质信息
     */
    @Override
    public UcUserInfoCQDTO getUcUserInfoCQDTO(Long id) throws UcUserInfoException {
        UcUserInfo user = this.getUcUserInfo(id);
        return new UcUserInfoCQDTO(user);
    }

    /**
     * 按主键查询实体
     */
    @Override
    public UcUserInfo getUcUserInfo(Long id) throws UcUserInfoException {
        return ucUserInfoRepository.getUcUserInfo(id);
    }

    /**
     * 更新实体
     */
    @Override
    public boolean updateUcUserInfo(UcUserInfo ucUserInfo) throws UcUserInfoException {
        return ucUserInfoRepository.updateUcUserInfo(ucUserInfo);
    }

    @Override
    public PaginationSupport findUcUserInfoCertificatePage(Map<String, String> params) throws UcUserInfoException {
        return ucUserInfoRepository.findUcUserInfoCertificatePage(params);
    }

}
