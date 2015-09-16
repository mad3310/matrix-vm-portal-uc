package com.letvcloud.uc.api.po;

import com.alibaba.fastjson.annotation.JSONField;
import com.letvcloud.bill.vo.BillServiceOpen;
import com.letvcloud.uc.po.User;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @author hanfeng
 * @date 15/7/14
 */

public class UserVo extends User{

    private  Boolean  arrearage ;

    private BigDecimal availableAmount;

    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date arrearageTime;


    private List<BillServiceOpen> billServiceOpenList;


    public Date getArrearageTime() {
        return arrearageTime;
    }

    public void setArrearageTime(Date arrearageTime) {
        this.arrearageTime = arrearageTime;
    }

    public Boolean isArrearage() {
        return arrearage;
    }

    public void setArrearage(Boolean arrearage) {
        this.arrearage = arrearage;
    }

    public List<BillServiceOpen> getBillServiceOpenList() {
        return billServiceOpenList;
    }

    public void setBillServiceOpenList(List<BillServiceOpen> billServiceOpenList) {
        this.billServiceOpenList = billServiceOpenList;
    }

    public BigDecimal getAvailableAmount() {
        return availableAmount;
    }

    public void setAvailableAmount(BigDecimal availableAmount) {
        this.availableAmount = availableAmount;
    }
}
