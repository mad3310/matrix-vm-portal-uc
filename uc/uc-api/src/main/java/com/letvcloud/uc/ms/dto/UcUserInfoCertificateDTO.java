package com.letvcloud.uc.ms.dto;


import com.letvcloud.uc.ms.model.UcUserInfo;
import com.letvcloud.uc.utils.DateUtil;

import java.io.Serializable;

public class UcUserInfoCertificateDTO implements Serializable {

    private Long id;// ID
    private String contacts;// 联系人
    private Integer usertype;// 用户类型
    private String mobile;// 手机号
    private String email;// 邮箱
    private Byte examinestatus;// 资质认证
    private String createdtime;// 注册日期

    // 临时加字段
    private Integer state;// 云直播开通状态

    public UcUserInfoCertificateDTO(UcUserInfo ucUserInfo) {

        this.id = ucUserInfo.getId();
        this.contacts = ucUserInfo.getContacts();
        this.usertype = ucUserInfo.getUsertype();
        this.mobile = ucUserInfo.getMobile();
        this.email = ucUserInfo.getEmail();
        this.examinestatus = ucUserInfo.getExaminestatus();
        this.createdtime = DateUtil.dateFormat(ucUserInfo.getCreatedtime(), "yyyy-MM-dd HH:mm:ss");
    }

    public Long getId() {

        return id;
    }

    public void setId(Long id) {

        this.id = id;
    }

    public String getContacts() {

        return contacts;
    }

    public Integer getState() {

        return state;
    }

    public void setState(Integer state) {

        this.state = state;
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

    public String getEmail() {

        return email;
    }

    public void setEmail(String email) {

        this.email = email;
    }

    public Integer getUsertype() {

        return usertype;
    }

    public void setUsertype(Integer usertype) {

        this.usertype = usertype;
    }

    public Byte getExaminestatus() {

        return examinestatus;
    }

    public void setExaminestatus(Byte examinestatus) {

        this.examinestatus = examinestatus;
    }

    public String getCreatedtime() {

        return createdtime;
    }

    public void setCreatedtime(String createdtime) {

        this.createdtime = createdtime;
    }

}
