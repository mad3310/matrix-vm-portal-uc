package com.letvcloud.uc.utils;

/**
 * @author hanfeng
 * @date 15/7/10
 */

public class Const {

    public static final int mobileStatusCheckSuccess = 1;

    /**
     * 注册短信文案-s
     */
    public static final String regMobileMsg = "您正在注册乐视云计算，验证码:{0}，请您在15分钟内完成验证，勿将验证码泄露给他人。";

    /**
     * 找回密码文案
     */
    public static final String sendMsgVerification = "您正在找回密码，验证码:{0}，请您在15分钟内完成验证，勿将验证码泄露给他人。";

    /**
     * 更换手机文案
     */
    public static final String sendReplaceMobileMsg = "您正在绑定手机，验证码:{0}，请您在15分钟内完成验证，勿将验证码泄露给他人。";

    /**
     * 资质认证通过
     */
    public static final String sendQualificationMsgT = "您的资质认证信息已通过审核，请登录官网www.letvcloud.com查看，感谢您的信任！";
    /**
     * 资质认证未通过
     */
    public static final String sendQualificationMsgF =
            "【乐视云计算】很遗憾的通知您，您的资质认证信息未通过审核，请登录官网www.letvcloud.com重新提交审核信息，详询400-055-6060，感谢您的信任！";

    /**
     * 欠费文案-短信
     */
    public static final String sendArrearsMsg = "温馨提示：截止:{0}，您的账户余额已小于0.00元，已处于欠费状态。请您及时充值，以免影响到您的服务。";
    /**
     * 欠费文案-站内信
     */
    public static final String sendArrearsMsgContent = "尊敬的{1}，您好！乐视云计算温馨提示您：截止:{0}，您的账户余额已小于0.00元，已处于欠费状态。请您及时充值，以免影响到您的服务。";

    /**
     * 充值
     */
    public static final String sendRechargeMsg = "您的账户于:{0}，成功存入人民币{1}元，当前余额为人民币{2}元。";

    /**
     * 费用预警
     */
    public static final String sendCostWarningMsg = "温馨提示：截止{0}，您的账户余额为人民币{1}元，您的账户余额即将不足。为避免因欠费停服给您带来不便，请及时充值。";

    /**
     * 冻结
     */
    public static final String sendFrozenMsg = "温馨提示:尊敬的乐视云计算用户，由于您的账户余额欠费，系统已于{0}停止您的服务，请您及时充值。";

    /**
     * 扣费-
     */
    public static final String sendFeeDeductionMsg = "您的账户于:{0}，支出人民币{1}元，当前余额为人民币{2}元。具体账单请登录www.letvcloud.com后台查看。";

    /**
     * 发票-e
     */
    public static final String sendInvoiceMsg = "您申请的发票已为您邮寄，【顺丰】快递号{0}，请您注意查收，相关账单{1}";

    /**
     * 直播
     */
    public static final String sendLiveMaxMsg = "温馨提示：截止{0}，您创建的直播观看人数已达上限，为避免新增用户无法观看您的直播，请您及时进行充值。";
    /**
     * 资质认证通过消息内容
     */
    public static final String qualificationMsgContent =
            "尊敬的{0}，您好！很高兴的通知您，您的资质认证信息已通过审核，您可以进入用户中心—账号管理进行查看，感谢您对我们的信任！";
/**
     * 资质认证未通过消息内容
     */
    public static final String notQualificationMsgContent =
            "尊敬的{0}，您好！很遗憾的通知您，您的资质认证信息未通过审核，请登录官网www.letvcloud.com重新提交审核信息，详询400-055-6060，感谢您的信任！";
    /**
     * 资质认证消息标题
     */
    public static final String qualificationMsgTitle = "资质认证通过";
/**
     * 资质认证消息标题
     */
    public static final String notQualificationMsgTitle = "资质未认证通过";
    /**
     * 资质认证消息标题
     */
    public static final String invoiceMsgTitle = "发票已邮寄";
    /**
     * 资质认证消息标题
     */
    public static final String arrearsMsgTitle = "欠费提醒";
    /**
     * 个人信息状态
     */
    public static final String messageType = "1";
    /**
     * 开通云直播短信
     */
    public static final String liveBroadcastMessage = "亲爱的乐视云用户，您的云直播业务已开通，感谢您对乐视云计算的支持！";

}
