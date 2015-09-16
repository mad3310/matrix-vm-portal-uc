package com.letvcloud.uc.vo;

import java.io.Serializable;

/**
 * 月账单明细
 * Created by zhaoliang5 on 2015/7/3.
 */
public class BillMonthDetailBillingVo implements Serializable {
    private static final long serialVersionUID = -6197453700114066357L;
    //功能点编号
    private String featherCode;


//   功能点编号描述

    private String featherCodeDesc;

    //使用总量
    private String totalAmount;
    //单价
    private String price;
    //折扣
    private String discount;
    // 折扣后的单价 单价x折扣
    private String discountPrice;
    //总计
    private String totalFee;


    public String getFeatherCodeDesc() {
        return featherCodeDesc;
    }

    public void setFeatherCodeDesc(String featherCodeDesc) {
        this.featherCodeDesc = featherCodeDesc;
    }

    public String getFeatherCode() {
        return featherCode;
    }

    public void setFeatherCode(String featherCode) {
        this.featherCode = featherCode;
    }

    public String getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(String totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getDiscount() {
        return discount;
    }

    public void setDiscount(String discount) {
        this.discount = discount;
    }

    public String getTotalFee() {
        return totalFee;
    }

    public void setTotalFee(String totalFee) {
        this.totalFee = totalFee;
    }

    public String getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(String discountPrice) {
        this.discountPrice = discountPrice;
    }
}
