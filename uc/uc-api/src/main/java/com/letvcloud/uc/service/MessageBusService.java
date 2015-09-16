package com.letvcloud.uc.service;

import com.letvcloud.uc.po.User;
import java.io.IOException;

/**
 * @author hanfeng
 * @date 15/8/6
 */

public interface MessageBusService {
    /**
     * 发送手机验证码
     */
    String sendRegMobileMsg(String mobileAll,String mobile, String userIp);

    /**
     * 找回密码--发送手机验证码
     */
    public String sendMsgVerification(String mobile, String userIp);
    /**
     * 更换手机--发送手机验证码
     */
    String sendReplaceMobileMsg(String mobileAll, String mobile, String userIp);
    /**
     * 资质认证--发送手机验证码
     * @param isBy true通过
     */
    void sendQualificationMsgBus(boolean isBy,Long userId) throws IOException;
    /**
     * 欠费--发送手机验证码
     */
    void sendArrearsMsgBus(Long userId, String date);
    /**
     * 充值--发送手机验证码
     *
     * @param date
     * @param recharge 存入金额
     * @param surplusRecharge 剩余金额
     */
    void sendRechargeMsgBus(Long userId, String date, String recharge, String surplusRecharge);
    /**
     * 费用预警--发送手机验证码
     *
     * @param date
     * @param surplusRecharge 剩余金额
     */
    void sendCostWarningMsgBus(Long userId, String date, String surplusRecharge);
    /**
     * 冻结（停服）--发送手机验证码
     *
     * @param date
     */
    void sendFrozenMsgBus(Long userId, String date);
    /**
     * 扣费--发送手机验证码
     *
     * @param date
     */
    void sendFeeDeductionMsgBus(Long userId, String date, String recharge, String surplusRecharge);
    /**
     * 发票--发送手机验证码
     *
     * @param EMSNum
     * @param title
     */
    void sendInvoiceMsgBus(Long userId, String EMSNum, String title) throws IOException;
    /**
     * 冻结（停服）--发送手机验证码
     *
     * @param date
     */
    void sendLiveMaxMsg(Long userId, String date);

    /**
     * 注册发送邮件
     * @throws IOException
     */
    @Deprecated
    void sendRegMobileEmail(Long userId) throws IOException;

    /**
     * 注册发送邮件
     * @throws IOException
     */
    void sendActivateEmail(Long userId) throws IOException;
    /**
     * 找回密码
     * @param userIp
     * @throws IOException
     */
    void sendVerificationEmail(String userIp,Long userId) throws IOException;

    /**
     * 开通云点播通知
     * @param userId
     */
    void openLiveServiceMsgBus(Long userId) throws IOException;
}
