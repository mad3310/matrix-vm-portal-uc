package com.letvcloud.uc.vo;

import java.io.Serializable;

/**
 * Created by chenliusong on 2015/7/11.
 */
public class RechargeBossReturnVo implements Serializable {

    private static final long serialVersionUID = 2021658461038042988L;
    private String corderid;
    private String money;
    private String companyid;
    private String paytime;
    private String userid;
    private String channel;
    private String ordernumber;
    private String svip;
    private String productid;
    private String terminal;
    private String stat;
    private String sign;

    private String status;
    private String errormsg;
    private String wxurl;
    private String productname;
    private String price;

    public String getCorderid() {
        return corderid;
    }

    public void setCorderid(String corderid) {
        this.corderid = corderid;
    }

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money;
    }

    public String getCompanyid() {
        return companyid;
    }

    public void setCompanyid(String companyid) {
        this.companyid = companyid;
    }

    public String getPaytime() {
        return paytime;
    }

    public void setPaytime(String paytime) {
        this.paytime = paytime;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getChannel() {
        return channel;
    }

    public void setChannel(String channel) {
        this.channel = channel;
    }

    public String getOrdernumber() {
        return ordernumber;
    }

    public void setOrdernumber(String ordernumber) {
        this.ordernumber = ordernumber;
    }

    public String getSvip() {
        return svip;
    }

    public void setSvip(String svip) {
        this.svip = svip;
    }

    public String getProductid() {
        return productid;
    }

    public void setProductid(String productid) {
        this.productid = productid;
    }

    public String getTerminal() {
        return terminal;
    }

    public void setTerminal(String terminal) {
        this.terminal = terminal;
    }

    public String getStat() {
        return stat;
    }

    public void setStat(String stat) {
        this.stat = stat;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getErrormsg() {
        return errormsg;
    }

    public void setErrormsg(String errormsg) {
        this.errormsg = errormsg;
    }

    public String getWxurl() {
        return wxurl;
    }

    public void setWxurl(String wxurl) {
        this.wxurl = wxurl;
    }

    public String getProductname() {
        return productname;
    }

    public void setProductname(String productname) {
        this.productname = productname;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }
}
