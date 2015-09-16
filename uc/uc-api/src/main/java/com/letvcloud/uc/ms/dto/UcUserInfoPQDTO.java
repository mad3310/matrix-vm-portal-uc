package com.letvcloud.uc.ms.dto;


import com.letvcloud.uc.ms.model.UcUserInfo;

import java.io.Serializable;

public class UcUserInfoPQDTO implements Serializable {
    
    private Long id;// ID
    private String idcard;// 身份证号
    private String idcardphoto;// 身份证照片url
    private String address;// 联系地址
    private Byte examinestatus;// 审核状态
    private String reason;// 原因
    
    public UcUserInfoPQDTO(UcUserInfo ucUserInfo) {
    
        this.id = ucUserInfo.getId();
        this.idcard = ucUserInfo.getIdcard();
        this.idcardphoto = ucUserInfo.getIdcardphoto();
        this.address = ucUserInfo.getAddress();
        this.examinestatus = ucUserInfo.getExaminestatus();
        this.reason = ucUserInfo.getReason();
    }
    
    public Long getId() {
    
        return id;
    }
    
    public void setId(Long id) {
    
        this.id = id;
    }
    
    public String getIdcard() {
    
        return idcard;
    }
    
    public void setIdcard(String idcard) {
    
        this.idcard = idcard;
    }
    
    public Byte getExaminestatus() {
    
        return examinestatus;
    }
    
    public void setExaminestatus(Byte examinestatus) {
    
        this.examinestatus = examinestatus;
    }
    
    public String getReason() {
    
        return reason;
    }
    
    public void setReason(String reason) {
    
        this.reason = reason;
    }
    
    public String getIdcardphoto() {
    
        return idcardphoto;
    }
    
    public void setIdcardphoto(String idcardphoto) {
    
        this.idcardphoto = idcardphoto;
    }
    
    public String getAddress() {
    
        return address;
    }
    
    public void setAddress(String address) {
    
        this.address = address;
    }
    
}
