package com.letvcloud.uc.vo;

import com.letvcloud.uc.po.Invoice;
import org.springframework.beans.BeanUtils;

import java.io.Serializable;

/**
 * Created by zhaoliang5 on 2015/6/29.
 */
public class InvoiceVo extends Invoice {
    private static final long serialVersionUID = -5522390170375324576L;

    public InvoiceVo() {}

    /**
     * 发票金额
     */
    private Double invoiceMoney;

    /**
     * 开具类型名称
     */
    private String issueTypeName;

    /**
     * 发票内容
     */
    private String invoiceContent;

    /**
     * 所在地区一级 name
     */
    private String areaLevel1Name;

    /**
     * 所在地区二级 name
     */
    private String areaLevel2Name;

    /**
     * 所在地区三级 name
     */
    private String areaLevel3Name;

    /**
     * 产品名称码，如：云直播
     */
    private String serviceCode;

    /**
     * 产品名称名
     */
    private String serviceCodeName;

    /**
     * 计费类型，如：按流量计费
     */
    private String billTypeName;

    /**
     * 账单周期  开始时间
     */
    private String billStartTime;

    /**
     * 账单周期  结束时间
     */
    private String billEndTime;

    public Double getInvoiceMoney() {
        return invoiceMoney;
    }

    public void setInvoiceMoney(Double invoiceMoney) {
        this.invoiceMoney = invoiceMoney;
    }

    public String getIssueTypeName() {
        return issueTypeName;
    }

    public void setIssueTypeName(String issueTypeName) {
        this.issueTypeName = issueTypeName;
    }

    public String getInvoiceContent() {
        return invoiceContent;
    }

    public void setInvoiceContent(String invoiceContent) {
        this.invoiceContent = invoiceContent;
    }

    public String getAreaLevel1Name() {
        return areaLevel1Name;
    }

    public void setAreaLevel1Name(String areaLevel1Name) {
        this.areaLevel1Name = areaLevel1Name;
    }

    public String getAreaLevel2Name() {
        return areaLevel2Name;
    }

    public void setAreaLevel2Name(String areaLevel2Name) {
        this.areaLevel2Name = areaLevel2Name;
    }

    public String getAreaLevel3Name() {
        return areaLevel3Name;
    }

    public void setAreaLevel3Name(String areaLevel3Name) {
        this.areaLevel3Name = areaLevel3Name;
    }

    public String getBillTypeName() {
        return billTypeName;
    }

    public void setBillTypeName(String billTypeName) {
        this.billTypeName = billTypeName;
    }

    public String getBillStartTime() {
        return billStartTime;
    }

    public void setBillStartTime(String billStartTime) {
        this.billStartTime = billStartTime;
    }

    public String getBillEndTime() {
        return billEndTime;
    }

    public void setBillEndTime(String billEndTime) {
        this.billEndTime = billEndTime;
    }

    public String getServiceCode() {
        return serviceCode;
    }

    public void setServiceCode(String serviceCode) {
        this.serviceCode = serviceCode;
    }

    public String getServiceCodeName() {
        return serviceCodeName;
    }

    public void setServiceCodeName(String serviceCodeName) {
        this.serviceCodeName = serviceCodeName;
    }
}
