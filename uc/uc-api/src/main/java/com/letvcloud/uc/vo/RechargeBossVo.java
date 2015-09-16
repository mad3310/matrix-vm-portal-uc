package com.letvcloud.uc.vo;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Created by zhaoliang5 on 2015/7/1.
 */




public class RechargeBossVo implements Serializable {
    private static final long serialVersionUID = -4956580741288803929L;

    private String corderid;

    private String userid;

    private String username;
    private String companyid;
    private String deptid;
    private String productid;
    private String backurl;
    private String fronturl;
    private BigDecimal price;
    private String buyType;
    private String pid;
    private String chargetype;
    private String productname;
    private String productdesc;
    private String defaultbank;

    private String reqAddr;


    public RechargeBossVo() {
        this.companyid = "4";
        this.deptid = "112";
        this.productid = "0";
        this.buyType = "0";
        this.pid = "0";
        this.chargetype = "1";
    }

    public String getCorderid() {
        return corderid;
    }

    public void setCorderid(String corderid) {
        this.corderid = corderid;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getCompanyid() {
        return companyid;
    }

    public void setCompanyid(String companyid) {
        this.companyid = companyid;
    }

    public String getDeptid() {
        return deptid;
    }

    public void setDeptid(String deptid) {
        this.deptid = deptid;
    }

    public String getProductid() {
        return productid;
    }

    public void setProductid(String productid) {
        this.productid = productid;
    }

    public String getBackurl() {
        return backurl;
    }

    public void setBackurl(String backurl) {
        this.backurl = backurl;
    }

    public String getFronturl() {
        return fronturl;
    }

    public void setFronturl(String fronturl) {
        this.fronturl = fronturl;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getBuyType() {
        return buyType;
    }

    public void setBuyType(String buyType) {
        this.buyType = buyType;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getChargetype() {
        return chargetype;
    }

    public void setChargetype(String chargetype) {
        this.chargetype = chargetype;
    }

    public String getProductname() {
        return productname;
    }

    public void setProductname(String productname) {
        this.productname = productname;
    }

    public String getProductdesc() {
        return productdesc;
    }

    public void setProductdesc(String productdesc) {
        this.productdesc = productdesc;
    }

    public String getDefaultbank() {
        return defaultbank;
    }

    public void setDefaultbank(String defaultbank) {
        this.defaultbank = defaultbank;
    }

    public String getReqAddr() {
        return reqAddr;
    }

    public void setReqAddr(String reqAddr) {
        this.reqAddr = reqAddr;
    }
}
