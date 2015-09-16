package com.letvcloud.uc.po;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by zhaoliang5 on 2015/6/28.
 */
public class Invoice implements Serializable {
    private static final long serialVersionUID = -8738222301240665389L;

    private Long id;
    /**
     * 开具类型
     */
    private Integer issueType;
    /**
     * 发票抬头
     */
    private String invoiceTitle;
    /**
     * 发票类型。1：增值税发票
     */
    private Integer invoiceType;
    /**
     * 收件人姓名
     */
    private String receiveName;
    /**
     * 所在地区 一级
     */
    private String areaLevel1;
    /**
     * 所在地区 二级
     */
    private String areaLevel2;
    /**
     * 所在地区 三级
     */
    private String areaLevel3;
    /**
     * 街道地址
     */
    private String address;
    /**
     * 邮政编码
     */
    private String zipCode;
    /**
     * 手机号码
     */
    private String mobile;
    private Date createdTime;
    private Date lastUpdateTime;
    private Long userId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getIssueType() {
        return issueType;
    }

    public void setIssueType(Integer issueType) {
        this.issueType = issueType;
    }

    public Integer getInvoiceType() {
        return invoiceType;
    }

    public void setInvoiceType(Integer invoiceType) {
        this.invoiceType = invoiceType;
    }

    public String getReceiveName() {
        return receiveName;
    }

    public void setReceiveName(String receiveName) {
        this.receiveName = receiveName;
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

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
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

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getInvoiceTitle() {
        return invoiceTitle;
    }

    public void setInvoiceTitle(String invoiceTitle) {
        this.invoiceTitle = invoiceTitle;
    }
}