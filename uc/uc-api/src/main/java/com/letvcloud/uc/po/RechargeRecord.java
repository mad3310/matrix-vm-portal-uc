package com.letvcloud.uc.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class RechargeRecord implements Serializable{
	private static final long serialVersionUID = -2604618538609624691L;
	private Long id;
	private BigDecimal rechargeAmount;
	private String tradingNumber;
	private Integer rechargeWay;
	private Date createdTime;
	private Date lastUpdateTime;
	private String orderNum;
	private String successFlag;
	private Long userId;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public BigDecimal getRechargeAmount() {
		return rechargeAmount;
	}
	public void setRechargeAmount(BigDecimal rechargeAmount) {
		this.rechargeAmount = rechargeAmount;
	}
	public String getTradingNumber() {
		return tradingNumber;
	}
	public void setTradingNumber(String tradingNumber) {
		this.tradingNumber = tradingNumber;
	}
	public Integer getRechargeWay() {
		return rechargeWay;
	}
	public void setRechargeWay(Integer rechargeWay) {
		this.rechargeWay = rechargeWay;
	}
	public Date getCreatedTime() {
		return createdTime;
	}
	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}
	public Date getLastUpdateTime() {
		return lastUpdateTime;
	}
	public void setLastUpdateTime(Date lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}
	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	public String getSuccessFlag() {
		return successFlag;
	}
	public void setSuccessFlag(String successFlag) {
		this.successFlag = successFlag;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
}
