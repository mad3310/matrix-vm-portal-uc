package com.letvcloud.uc.po;

import com.alibaba.fastjson.annotation.JSONField;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by Steven on 2015/6/14.
 */
public class User implements Serializable {

    private static final long serialVersionUID = -4194422438818170545L;

    private Long id;
    private Long parentId;
    private Integer examineStatus;
    private Integer userStatus;
    private Integer mobileStatus;//手机号状态
    private String userUnique;
    private String userAvatar;
    private String idCard;
    private String idCardPhoto;
    private String email;
    private String password;
    private String mobile;
    private String userKey;
    private Integer userType;
    private Integer areaLevel1;
    private Integer areaLevel2;
    private Integer areaLevel3;
    private String address;
    private String enterpriseName;
    private String organizationCode;
    private String contacts;
    private String siteName;
    private Integer siteType;
    private String siteDomain;
    private String businessLicense;
    private String businessLicenseRegisterNum;
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date createdTime;
    private String createdUser;
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date lastUpdateTime;
    private String lastUpdateUser;
    private Integer reasonId;
    private String reason;



    private Integer emailStatus;
    private String countryCode;//国家编码


    public Integer getMobileStatus() {
        return mobileStatus;
    }

    public void setMobileStatus(Integer mobileStatus) {
        this.mobileStatus = mobileStatus;
    }

    private Integer isOld;//是否老用户

    public Integer getIsOld() {
        return isOld;
    }

    public void setIsOld(Integer isOld) {
        this.isOld = isOld;
    }



    public String getUserUnique() {
        return userUnique;
    }

    public void setUserUnique(String userUnique) {
        this.userUnique = userUnique;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public Integer getExamineStatus() {
        return examineStatus;
    }

    public void setExamineStatus(Integer examineStatus) {
        this.examineStatus = examineStatus;
    }

    public Integer getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(Integer userStatus) {
        this.userStatus = userStatus;
    }

    public String getUserAvatar() {
        return userAvatar;
    }

    public void setUserAvatar(String userAvatar) {
        this.userAvatar = userAvatar;
    }

    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    public String getIdCardPhoto() {
        return idCardPhoto;
    }

    public void setIdCardPhoto(String idCardPhoto) {
        this.idCardPhoto = idCardPhoto;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getUserKey() {
        return userKey;
    }

    public void setUserKey(String userKey) {
        this.userKey = userKey;
    }

    public Integer getUserType() {
        return userType;
    }

    public void setUserType(Integer userType) {
        this.userType = userType;
    }

    public Integer getAreaLevel1() {
        return areaLevel1;
    }

    public void setAreaLevel1(Integer areaLevel1) {
        this.areaLevel1 = areaLevel1;
    }

    public Integer getAreaLevel2() {
        return areaLevel2;
    }

    public void setAreaLevel2(Integer areaLevel2) {
        this.areaLevel2 = areaLevel2;
    }

    public Integer getAreaLevel3() {
        return areaLevel3;
    }

    public void setAreaLevel3(Integer areaLevel3) {
        this.areaLevel3 = areaLevel3;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEnterpriseName() {
        return enterpriseName;
    }

    public void setEnterpriseName(String enterpriseName) {
        this.enterpriseName = enterpriseName;
    }

    public String getOrganizationCode() {
        return organizationCode;
    }

    public void setOrganizationCode(String organizationCode) {
        this.organizationCode = organizationCode;
    }

    public String getContacts() {
        return contacts;
    }

    public void setContacts(String contacts) {
        this.contacts = contacts;
    }

    public String getSiteName() {
        return siteName;
    }

    public void setSiteName(String siteName) {
        this.siteName = siteName;
    }

    public Integer getSiteType() {
        return siteType;
    }

    public void setSiteType(Integer siteType) {
        this.siteType = siteType;
    }

    public String getSiteDomain() {
        return siteDomain;
    }

    public void setSiteDomain(String siteDomain) {
        this.siteDomain = siteDomain;
    }

    public String getBusinessLicense() {
        return businessLicense;
    }

    public void setBusinessLicense(String businessLicense) {
        this.businessLicense = businessLicense;
    }

    public String getBusinessLicenseRegisterNum() {
        return businessLicenseRegisterNum;
    }

    public void setBusinessLicenseRegisterNum(String businessLicenseRegisterNum) {
        this.businessLicenseRegisterNum = businessLicenseRegisterNum;
    }

    public Date getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Date createdTime) {
        this.createdTime = createdTime;
    }

    public String getCreatedUser() {
        return createdUser;
    }

    public void setCreatedUser(String createdUser) {
        this.createdUser = createdUser;
    }

    public Date getLastUpdateTime() {
        return lastUpdateTime;
    }

    public void setLastUpdateTime(Date lastUpdateTime) {
        this.lastUpdateTime = lastUpdateTime;
    }

    public String getLastUpdateUser() {
        return lastUpdateUser;
    }

    public void setLastUpdateUser(String lastUpdateUser) {
        this.lastUpdateUser = lastUpdateUser;
    }

    public Integer getReasonId() {
        return reasonId;
    }

    public void setReasonId(Integer reasonId) {
        this.reasonId = reasonId;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

	public Integer getEmailStatus() {
		return emailStatus;
	}

	public void setEmailStatus(Integer emailStatus) {
		this.emailStatus = emailStatus;
	}
    public String getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }

}
