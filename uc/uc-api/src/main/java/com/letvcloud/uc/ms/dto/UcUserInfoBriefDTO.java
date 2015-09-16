package com.letvcloud.uc.ms.dto;


import com.letvcloud.uc.ms.model.UcUserInfo;
import com.letvcloud.uc.utils.DateUtil;

import java.io.Serializable;

public class UcUserInfoBriefDTO implements Serializable {
    
    private Long id;// ID
    private String email;// 邮箱
    private String createdtime;// 注册日期
    private Integer usertype;// 用户类型
    private String enterprisename;// 公司名称
    private String contacts;// 联系人
    private String mobile;// 手机号
    private Byte userstatus;// 用户状态
    private Byte examinestatus;// 资质认证


    public void setUcUserInfo(UcUserInfo ucUserInfo){
        this.id = ucUserInfo.getId();
        this.email = ucUserInfo.getEmail();
        this.createdtime = DateUtil.dateFormat(ucUserInfo.getCreatedtime(), "yyyy-MM-dd HH:mm:ss");
        this.usertype = ucUserInfo.getUsertype();
        this.enterprisename = ucUserInfo.getEnterprisename();
        this.contacts = ucUserInfo.getContacts();
        this.mobile = ucUserInfo.getMobile();
        this.userstatus = ucUserInfo.getUserstatus();
        this.examinestatus = ucUserInfo.getExaminestatus();

    }
    
    public Long getId() {
    
        return id;
    }
    
    public void setId(Long id) {
    
        this.id = id;
    }
    
    public String getEmail() {
    
        return email;
    }
    
    public void setEmail(String email) {
    
        this.email = email;
    }
    
    public String getCreatedtime() {
    
        return createdtime;
    }
    
    public void setCreatedtime(String createdtime) {
    
        this.createdtime = createdtime;
    }
    
    public int getUsertype() {
    
        return usertype;
    }
    
    public void setUsertype(int usertype) {
    
        this.usertype = usertype;
    }
    
    public String getEnterprisename() {
    
        return enterprisename;
    }
    
    public void setEnterprisename(String enterprisename) {
    
        this.enterprisename = enterprisename;
    }
    
    public int getUserstatus() {
    
        return userstatus;
    }
    
    public Byte getExaminestatus() {
    
        return examinestatus;
    }
    
    public void setExaminestatus(Byte examinestatus) {
    
        this.examinestatus = examinestatus;
    }
    
    public void setUsertype(Integer usertype) {
    
        this.usertype = usertype;
    }
    
    public void setUserstatus(Byte userstatus) {
    
        this.userstatus = userstatus;
    }
    
    public String getContacts() {
    
        return contacts;
    }
    
    public void setContacts(String contacts) {
    
        this.contacts = contacts;
    }
    
    public String getMobile() {
    
        return mobile;
    }
    
    public void setMobile(String mobile) {
    
        this.mobile = mobile;
    }
    
}
