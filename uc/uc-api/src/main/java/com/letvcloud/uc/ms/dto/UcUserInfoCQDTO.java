package com.letvcloud.uc.ms.dto;


import com.letvcloud.uc.ms.model.UcUserInfo;

import java.io.Serializable;

public class UcUserInfoCQDTO implements Serializable {
    
    private Long id;// ID
    private String enterprisename;// 企业名称
    private String organizationcode;// 组织机构代码
    private String businesslicenseregisternum;// 营业执照注册号
    private String businesslicense;// 营业执照url
    private String address;// 联系地址
    private Byte examinestatus;// 审核状态
    private String email; // 电子邮箱
    private String reason;// 原因
    
    public UcUserInfoCQDTO(UcUserInfo ucUserInfo) {
    
        this.id = ucUserInfo.getId();
        this.email = ucUserInfo.getEmail();
        this.enterprisename = ucUserInfo.getEnterprisename();
        this.organizationcode = ucUserInfo.getOrganizationcode();
        this.businesslicenseregisternum = ucUserInfo.getBusinesslicenseregisternum();
        this.businesslicense = ucUserInfo.getBusinesslicense();
        this.address = ucUserInfo.getAddress();
        this.examinestatus = ucUserInfo.getExaminestatus();
        this.reason = ucUserInfo.getReason();
    }
    
    public Long getId() {
    
        return id;
    }
    
    public void setId(Long id) {
    
        this.id = id;
    }
    
    public Byte getExaminestatus() {
    
        return examinestatus;
    }
    
    public void setExaminestatus(Byte examinestatus) {
    
        this.examinestatus = examinestatus;
    }
    
    public String getReason() {
    
        return reason;
    }
    
    public void setReason(String reason) {
    
        this.reason = reason;
    }
    
    public String getEnterprisename() {
    
        return enterprisename;
    }
    
    public void setEnterprisename(String enterprisename) {
    
        this.enterprisename = enterprisename;
    }
    
    public String getOrganizationcode() {
    
        return organizationcode;
    }
    
    public void setOrganizationcode(String organizationcode) {
    
        this.organizationcode = organizationcode;
    }
    
    public String getBusinesslicenseregisternum() {
    
        return businesslicenseregisternum;
    }
    
    public void setBusinesslicenseregisternum(String businesslicenseregisternum) {
    
        this.businesslicenseregisternum = businesslicenseregisternum;
    }
    
    public String getBusinesslicense() {
    
        return businesslicense;
    }
    
    public void setBusinesslicense(String businesslicense) {
    
        this.businesslicense = businesslicense;
    }
    
    public String getAddress() {
    
        return address;
    }
    
    public void setAddress(String address) {
    
        this.address = address;
    }
    
    public String getEmail() {
    
        return email;
    }
    
    public void setEmail(String email) {
    
        this.email = email;
    }
    
}
