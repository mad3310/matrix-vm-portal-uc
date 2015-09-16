package com.letvcloud.uc.dao.dto;

import java.io.Serializable;

public class PersonDto implements Serializable{
	private static final long serialVersionUID = 5609014480750136836L;
	private String address;
	private String examineStatus;//审核状态
	private String contacts;
	private String idCard;
	private String idCardPhoto;
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getExamineStatus() {
		return examineStatus;
	}
	public void setExamineStatus(String examineStatus) {
		this.examineStatus = examineStatus;
	}
	public String getContacts() {
		return contacts;
	}
	public void setContacts(String contacts) {
		this.contacts = contacts;
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
	
}
