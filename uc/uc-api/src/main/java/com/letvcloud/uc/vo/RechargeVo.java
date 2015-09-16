package com.letvcloud.uc.vo;

import java.io.Serializable;

/**
 * Created by chenliusong on 2015/7/11.
 */
public class RechargeVo implements Serializable{
    private static final long serialVersionUID = 1563279230616299900L;

    private String chargeMoney;
    private Integer rechargeWay;

    public String getChargeMoney() {
        return chargeMoney;
    }

    public void setChargeMoney(String chargeMoney) {
        this.chargeMoney = chargeMoney;
    }

    public Integer getRechargeWay() {
        return rechargeWay;
    }

    public void setRechargeWay(Integer rechargeWay) {
        this.rechargeWay = rechargeWay;
    }
}
