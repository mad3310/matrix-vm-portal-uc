package com.letvcloud.uc.po;

import java.io.Serializable;

/**
 * Created by linzhengyu
 * Date: 2015/4/14
 * Time: 17:43
 * Created with IntelliJ IDEA.
 * To change this template use File | Settings | File and Code Templates |Includes.
 */
public class TranscodeServer implements Serializable {

    public static final int UNUSED_STATUS = 0;
    public static final int USED_STATUS = 1;
    private static final long serialVersionUID = -1752969160968856821L;
    /**
     * 转码机IP
     */
    private String serverIp;
    /**
     * 已使用能力
     */
    private Integer usedCapacity;
    /**
     * 总转码能力
     */
    private Integer totalCapacity;
    /**
     * 版本
     */
    private Integer version;
    /**
     * 状态 0:禁用，1:启用
     */
    private Integer status;


    public String getServerIp() {
        return serverIp;
    }

    public void setServerIp(String serverIp) {
        this.serverIp = serverIp;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getUsedCapacity() {
        return usedCapacity;
    }

    public void setUsedCapacity(Integer usedCapacity) {
        this.usedCapacity = usedCapacity;
    }

    public Integer getTotalCapacity() {
        return totalCapacity;
    }

    public void setTotalCapacity(Integer totalCapacity) {
        this.totalCapacity = totalCapacity;
    }
}
