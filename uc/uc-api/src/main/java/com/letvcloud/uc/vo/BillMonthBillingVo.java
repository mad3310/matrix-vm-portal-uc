package com.letvcloud.uc.vo;

import java.io.Serializable;
import java.util.List;

/**
 * 月账单 vo
 * Created by zhaoliang5 on 2015/7/3.
 */
public class BillMonthBillingVo implements Serializable {
    private static final long serialVersionUID = 8658076097049049922L;

    /**
     * 月的 总费用
     */
    private double totalMoney;
    /**
     * 月的  已结算费用
     */
    private double clearMoney;
    /**
     *月的  累计欠费
     */
    private double oweMoney;
    /**
     * 月份
     */
    private String billingMonth;

    /**
     * 服务详细
     */
    private List<BillUserBillingVo> billUserBillingVoList;


    public double getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(double totalMoney) {
        this.totalMoney = totalMoney;
    }

    public double getClearMoney() {
        return clearMoney;
    }

    public void setClearMoney(double clearMoney) {
        this.clearMoney = clearMoney;
    }

    public double getOweMoney() {
        return oweMoney;
    }

    public void setOweMoney(double oweMoney) {
        this.oweMoney = oweMoney;
    }

    public String getBillingMonth() {
        return billingMonth;
    }

    public void setBillingMonth(String billingMonth) {
        this.billingMonth = billingMonth;
    }

    public List<BillUserBillingVo> getBillUserBillingVoList() {
        return billUserBillingVoList;
    }

    public void setBillUserBillingVoList(List<BillUserBillingVo> billUserBillingVoList) {
        this.billUserBillingVoList = billUserBillingVoList;
    }
}
