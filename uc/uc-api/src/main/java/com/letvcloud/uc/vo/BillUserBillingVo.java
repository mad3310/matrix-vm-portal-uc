package com.letvcloud.uc.vo;

import java.io.Serializable;

/**
 * Created by zhaoliang5 on 2015/7/3.
 */
public class BillUserBillingVo implements Serializable {
    private static final long serialVersionUID = -4098145280803756667L;
    /**
     * 账单编号
     */
    private String billingId;
    //订单ID
    private Long orderId;
    //业务编码
    private String serviceCode;

    //    业务编码描述
    private String serviceCodeDesc;

    //账单日期
    private String billingMonth;
    //账单金额
    private String billingMoney;
    //用户ID
    private Long userId;

    /**
     * 发票状态 0:未索要发票，1：已索要发票
     */
    private String invoiceState;

    /**
     * 每个详细账单都有自己的一个已经结算费用
     */
    private String clearMoney;

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public String getServiceCode() {
        return serviceCode;
    }

    public void setServiceCode(String serviceCode) {
        this.serviceCode = serviceCode;
    }

    public String getServiceCodeDesc() {
        return serviceCodeDesc;
    }

    public void setServiceCodeDesc(String serviceCodeDesc) {
        this.serviceCodeDesc = serviceCodeDesc;
    }

    public String getBillingMonth() {
        return billingMonth;
    }

    public void setBillingMonth(String billingMonth) {
        this.billingMonth = billingMonth;
    }

    public String getBillingMoney() {
        return billingMoney;
    }

    public void setBillingMoney(String billingMoney) {
        this.billingMoney = billingMoney;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getBillingId() {
        return billingId;
    }

    public void setBillingId(String billingId) {
        this.billingId = billingId;
    }

    public String getInvoiceState() {
        return invoiceState;
    }

    public void setInvoiceState(String invoiceState) {
        this.invoiceState = invoiceState;
    }

    public String getClearMoney() {
        return clearMoney;
    }

    public void setClearMoney(String clearMoney) {
        this.clearMoney = clearMoney;
    }
}
