package com.letvcloud.uc.ms.dto;


import com.letvcloud.bill.vo.BillServiceOpen;
import com.letvcloud.uc.ms.model.UcUserInfo;

import java.io.Serializable;
import java.util.List;

public class UcUserInfoServiceStateDTO implements Serializable {
    private UcUserInfo ucUserInfo; // 用户信息
    private List<BillServiceOpen> billServiceOpenList; // 开通业务列表
    
    public UcUserInfoServiceStateDTO(UcUserInfo ucUserInfo, List<BillServiceOpen> billServiceOpenList) {
        this.ucUserInfo = ucUserInfo;
        this.billServiceOpenList = billServiceOpenList;
    }
    
    public UcUserInfo getUcUserInfo() {
        
        return ucUserInfo;
    }
    
    public void setUcUserInfo(UcUserInfo ucUserInfo) {
        
        this.ucUserInfo = ucUserInfo;
    }
    
    public List<BillServiceOpen> getBillServiceOpenList() {
        
        return billServiceOpenList;
    }
    
    public void setBillServiceOpenList(List<BillServiceOpen> billServiceOpenList) {
        
        this.billServiceOpenList = billServiceOpenList;
    }
    
}
