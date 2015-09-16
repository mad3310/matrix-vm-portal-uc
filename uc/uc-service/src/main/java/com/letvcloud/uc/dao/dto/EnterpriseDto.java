package com.letvcloud.uc.dao.dto;

import java.io.Serializable;

public class EnterpriseDto implements Serializable{
	private static final long serialVersionUID = 7607332506241293423L;
	private String enterpriseName;//企业名称
	private String organizationCode;//组织机构代码
	private String businessLicenseRegisterNum;//企业营业执照注册号码
	private String businessLicense;//企业营业执照照片，存储照片路径
	private String areaLevel1;
	private String areaLevel2;
	private String areaLevel3;
	private String address;//企业地址
	private String examineStatus;//审核状态
	private String contacts;
	private String idCard;
	private String idCardPhoto;
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
	public String getEnterpriseName() {
		return enterpriseName;
	}
	public String getExamineStatus() {
		return examineStatus;
	}
	public void setExamineStatus(String examineStatus) {
		this.examineStatus = examineStatus;
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
	public String getBusinessLicenseRegisterNum() {
		return businessLicenseRegisterNum;
	}
	public void setBusinessLicenseRegisterNum(String businessLicenseRegisterNum) {
		this.businessLicenseRegisterNum = businessLicenseRegisterNum;
	}
	public String getBusinessLicense() {
		return businessLicense;
	}
	public void setBusinessLicense(String businessLicense) {
		this.businessLicense = businessLicense;
	}
	public String getAreaLevel1() {
		return areaLevel1;
	}
	public void setAreaLevel1(String areaLevel1) {
		this.areaLevel1 = areaLevel1;
	}
	public String getAreaLevel2() {
		return areaLevel2;
	}
	public void setAreaLevel2(String areaLevel2) {
		this.areaLevel2 = areaLevel2;
	}
	public String getAreaLevel3() {
		return areaLevel3;
	}
	public void setAreaLevel3(String areaLevel3) {
		this.areaLevel3 = areaLevel3;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getContacts() {
		return contacts;
	}
	public void setContacts(String contacts) {
		this.contacts = contacts;
	}
	
}
