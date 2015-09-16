package com.letvcloud.uc.vo;

import java.io.Serializable;

/**
 * Created by chenliusong on 2015/7/12.
 */
public class RechargeDetailVo implements Serializable{
    private static final long serialVersionUID = -7757602206886657595L;
    private String rechargeTime;
    private String rechargeWay;
    private String rechargeMoney;
    private String rechargeState;

    public String getRechargeTime() {
        return rechargeTime;
    }

    public void setRechargeTime(String rechargeTime) {
        this.rechargeTime = rechargeTime;
    }

    public String getRechargeWay() {
        return rechargeWay;
    }

    public void setRechargeWay(String rechargeWay) {
        this.rechargeWay = rechargeWay;
    }

    public String getRechargeMoney() {
        return rechargeMoney;
    }

    public void setRechargeMoney(String rechargeMoney) {
        this.rechargeMoney = rechargeMoney;
    }

    public String getRechargeState() {
        return rechargeState;
    }

    public void setRechargeState(String rechargeState) {
        this.rechargeState = rechargeState;
    }
}
