package com.letvcloud.uc.po;

import java.io.Serializable;

/**
 * Created by zhaoliang5 on 2015/6/27.
 */
public class Area implements Serializable{
    private static final long serialVersionUID = -8980648566246882642L;
    private String id;
    private String areaCode;
    private String areaName;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAreaCode() {
        return areaCode;
    }

    public void setAreaCode(String areaCode) {
        this.areaCode = areaCode;
    }

    public String getAreaName() {
        return areaName;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName;
    }
}
