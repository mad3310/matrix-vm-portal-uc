package com.letvcloud.uc.service;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import com.letvcloud.uc.po.Message;
import com.letvcloud.uc.utils.constant.EmailStatusContant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.letvcloud.saas.util.cache.CacheClient;
import com.letvcloud.uc.po.User;
import com.letvcloud.uc.utils.*;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * Created by zhaoliang5 on 2015/6/14.
 */
@Service("messageBusService")
public class MessageBusServiceImpl implements MessageBusService {

    private static final Logger logger = LoggerFactory.getLogger(MessageBusServiceImpl.class);

    @Autowired
    private CacheClient cacheClient;
    @Autowired
    private SendMsgUtils sendMsgUtils;
    @Autowired
    private UserService userService;
    @Autowired
    private SendMailUtils sendMailUtils;
    @Autowired
    private MessageService messageService;
    @Value("#{configProperties['path']}")
    private String path;
    @Value("#{configProperties['pathPwdByEmail']}")
    private String pathPwdByEmail;

    private Boolean checkUserPhone(User user) {
        if (user != null &&user.getMobileStatus()!=null && user.getMobileStatus().intValue() == Const.mobileStatusCheckSuccess) {
            return true;
        }
        return false;
    }

    /**
     * 注册--发送手机验证码
     * @param userIp
     * @return
     */
    @Override
    public String sendRegMobileMsg(String mobileAll, String mobile, String userIp) {
        if(!checkSendAllow(mobileAll,userIp)) {
            logger.info("sendRegMobileMsg too many fail, mobile:{},userIp:{} ",mobileAll,userIp);
            return "2";
        }
        String checkNum = NumberUtils.getSixRandomNum();
        logger.info("sendRegMobileMsg,mobile:{},checknum:{}", mobileAll, checkNum);
        String msg = MessageFormat.format(Const.regMobileMsg, checkNum);
        cacheClient.set(mobileAll, 900, checkNum);
        sendMsgUtils.sendMessage(mobileAll, msg);
        return "ok";
    }

    @Override
    public void sendActivateEmail(Long userId) throws IOException {
        User user = userService.getUserById(userId);
        Map<String, String> model = new HashMap<String, String>();
        model.put("href", getActivateEmailHref(user));
        model.put("currentUserEmail", user.getEmail());
        sendQualificationEmail(user, model, "emailRegister.ftl", "乐视云计算注册激活",false);

    }

    @Override
    public void sendRegMobileEmail(Long userId) throws IOException {
        sendActivateEmail(userId);
    }

    private String getActivateEmailHref(User user) {
        String id = Long.toString(user.getId());
        String time = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date());
        String key = MD5Utils.getKey();
        String sign = MD5Utils.str2MD5(id + time + key);
        return path + "?id=" + id + "&sign=" + sign + "&time=" + time;
    }

    /**
     * 找回密码--发送手机验证码
     *
     * @param userIp
     */
    @Override
    public String sendMsgVerification(String allMobile, String userIp) {
        if(!checkSendAllow(allMobile,userIp)) return "2";
        String checkNum = getcheckNum(allMobile);
        logger.info("sendMsgVerification,mobile:{},checknum:{}", allMobile, checkNum);
        String msg = MessageFormat.format(Const.sendMsgVerification, checkNum);
        sendMsgUtils.sendMessage(allMobile, msg);
        return "ok";
    }

    @Override
    public void sendVerificationEmail(String userIp, Long userId) throws IOException {
        User user = userService.getUserById(userId);
            Map<String, String> model = new HashMap<String, String>();
            model.put("href", getVerificationHref(user));
            model.put("currentUserEmail", user.getEmail());
            sendQualificationEmail(user, model, "emailPassword.ftl", "乐视云计算通过邮箱找回密码",true);
    }

    @Override
    public void openLiveServiceMsgBus(Long userId) throws IOException  {
        User user = userService.getUserById(userId);
        sendQualificationEmail(user, null, "openLiveService.ftl", "云直播业务开通成功", true);
        sendMsgUtils.sendMessage(user.getCountryCode() + user.getMobile(), Const.liveBroadcastMessage);
    }

    private String getVerificationHref(User user) {
        Long time = System.currentTimeMillis();
        String key = MD5Utils.getKey();
        String sign = MD5Utils.str2MD5(user.getId().toString() + time.toString() + key);
        return pathPwdByEmail + "?id=" + user.getId() + "&sign=" + sign + "&time=" + time;
    }
    /**
     * 更换手机,给原手机号发短信--发送手机验证码
     *
     * @param userIp
     */
    @Override
    public String sendReplaceMobileMsg(String mobileAll, String mobile, String userIp) {
        if(!checkSendAllow(mobileAll, userIp)) return "2";
        String checkNum = getcheckNum(mobileAll);
        logger.info("sendReplaceMobileMsg,mobile:{},checknum:{}", mobileAll, checkNum);
        String msg = MessageFormat.format(Const.sendReplaceMobileMsg, checkNum);
        sendMsgUtils.sendMessage(mobileAll, msg);
        return "ok";
    }

    /**
     * 资质认证--发送手机验证码
     *
     * @param isBy true通过
     */
    @Override
    public void sendQualificationMsgBus(boolean isBy, Long userId) throws IOException {
        User user = userService.getUserById(userId);
        if (checkUserPhone(user)) {
            sendQualificationMsg(user.getCountryCode()+user.getMobile(), isBy);
        }
        Map<String, String> model = new HashMap<String, String>();
        model.put("href", "http://uc.letvcloud.com/qualificationsAuthenView/authenSuccess.do");
        model.put("currentUserEmail", user.getEmail());
        if (isBy) {
            sendQualificationEmail(user, model, "emailQualification.ftl", "资质认证信息已通过审核",true);
        }else{
            sendQualificationEmail(user, model, "emailNotQualification.ftl", "资质认证信息未通过审核",true);
        }

        List<Long> ids = new ArrayList<Long>();
        Message message = new Message();
        message.setMsgType(Const.messageType);
        if(isBy){
            message.setMsgTitle(Const.qualificationMsgTitle);
            message.setMsgContent(MessageFormat.format(Const.qualificationMsgContent, user.getEmail()));
            ids.add(user.getId());
            messageService.pubMessage(message, ids);
        }else{
            message.setMsgTitle(Const.notQualificationMsgTitle);
            message.setMsgContent(MessageFormat.format(Const.notQualificationMsgContent, user.getEmail()));
            ids.add(user.getId());
            messageService.pubMessage(message, ids);
        }
    }

    private void sendQualificationEmail(User user, Map<String, String> model, String templateName, String emailSubject,boolean emailActive)
            throws IOException {
        try {
            if(emailActive==true){
                if(user.getEmailStatus()!=null&&user.getEmailStatus().intValue()== EmailStatusContant.NO_ACTIVATE.intValue()) {
                    logger.info("in messageBusService sendEmail ###email:{}###emailTitle:{}###error:{}",user.getEmail(),emailSubject,"邮箱未激活");
                    return;
                }
            }
            String filePath = Thread.currentThread().getContextClassLoader().getResource("").toURI().getPath() + "templates";
            // 代码模板配置
            Configuration cfg = new Configuration();
            cfg.setDefaultEncoding("UTF-8");
            cfg.setDirectoryForTemplateLoading(new File(filePath));
            Template template = cfg.getTemplate(templateName);
            String content = renderTemplate(template, model);
            sendMailUtils.sendHtmlMail(user.getEmail(), emailSubject, content);
            logger.info("in messageBusService sendEmail ###email:{}###emailTitle:{}###",user.getEmail(),emailSubject);
        } catch (Exception e) {
            logger.info("in messageBusService sendEmail ###email:{}###emailTitle:{}###error:{}",user.getEmail(),emailSubject,e.getMessage());
        }
    }


    /**
     * 向ftl模板渲染数据
     *
     * @param template
     * @param model
     * @return
     */
    private static String renderTemplate(Template template, Object model) {
        StringWriter result = new StringWriter();
        try {
            template.process(model, result);
        } catch (TemplateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result.toString();
    }

    private void sendQualificationMsg(String mobile, boolean isBy) {
        String msg;
        if (isBy) {
            msg = Const.sendQualificationMsgT;
        } else {
            msg = Const.sendQualificationMsgF;
        }
        sendMsgUtils.sendMessage(mobile, msg);
    }

    /**
     * 欠费--发送手机验证码
     *
     * @param date
     */
    @Override
    public void sendArrearsMsgBus(Long userId, String date) {
        User user = userService.getUserById(userId);
        if (checkUserPhone(user)) {
            String mobile = user.getCountryCode()+user.getMobile();
            String msg = MessageFormat.format(Const.sendArrearsMsg, date);
            sendMsgUtils.sendMessage(mobile, msg);

        }

        //站内信
        Message message = new Message();
        message.setMsgType(Const.messageType);
        message.setMsgTitle(Const.arrearsMsgTitle);
        message.setMsgContent(MessageFormat.format(Const.sendArrearsMsgContent, date,user.getContacts()));
        List<Long> ids = new ArrayList<Long>();
        ids.add(user.getId());
        messageService.pubMessage(message, ids);
    }

    /**
     * 充值--发送手机验证码
     *
     * @param date
     * @param recharge 存入金额
     * @param surplusRecharge 剩余金额
     */
    @Override
    public void sendRechargeMsgBus(Long userId, String date, String recharge, String surplusRecharge) {
        User user = userService.getUserById(userId);
        if (checkUserPhone(user)) {
            String mobile = user.getCountryCode()+user.getMobile();
            String msg = MessageFormat.format(Const.sendRechargeMsg, date, recharge, surplusRecharge);
            sendMsgUtils.sendMessage(mobile, msg);
        }
    }

    /**
     * 费用预警--发送手机验证码
     *
     * @param date
     * @param surplusRecharge 剩余金额
     */
    @Override
    public void sendCostWarningMsgBus(Long userId, String date, String surplusRecharge) {
        User user = userService.getUserById(userId);
        if (checkUserPhone(user)) {
            String mobile = user.getCountryCode()+user.getMobile();

            String msg = MessageFormat.format(Const.sendCostWarningMsg, date, surplusRecharge);
            sendMsgUtils.sendMessage(mobile, msg);
        }
    }

    /**
     * 冻结（停服）--发送手机验证码
     *
     * @param date
     */
    @Override
    public void sendFrozenMsgBus(Long userId, String date) {
        User user = userService.getUserById(userId);
        if (checkUserPhone(user)) {
            String mobile = user.getCountryCode()+user.getMobile();
            String msg = MessageFormat.format(Const.sendFrozenMsg, date);
            sendMsgUtils.sendMessage(mobile, msg);
        }
    }

    /**
     * 扣费--发送手机验证码
     *
     * @param date
     * @param recharge 支出金额
     * @param surplusRecharge 剩余金额
     */
    @Override
    public void sendFeeDeductionMsgBus(Long userId, String date, String recharge, String surplusRecharge) {
        User user = userService.getUserById(userId);
        if (checkUserPhone(user)) {
            String mobile = user.getCountryCode()+user.getMobile();
            String msg = MessageFormat.format(Const.sendFeeDeductionMsg, date, recharge, surplusRecharge);
            sendMsgUtils.sendMessage(mobile, msg);
        }
    }

    /**
     * 邮寄发票时--发送手机验证码
     *
     * @param EMSNum
     * @param title
     */
    @Override
    public void sendInvoiceMsgBus(Long userId, String EMSNum, String title) throws IOException {
        User user = userService.getUserById(userId);
        String msg = MessageFormat.format(Const.sendInvoiceMsg, EMSNum, title);
        if (checkUserPhone(user)) {
            String mobile = user.getCountryCode()+user.getMobile();
            sendMsgUtils.sendMessage(mobile, msg);
        }

        Map<String, String> model = new HashMap<String, String>();
        model.put("currentUserEmail", user.getEmail());
        model.put("msg", msg);
        sendQualificationEmail(user, model, "emailInvoice.ftl", "发票已邮寄",true);

        Message message = new Message();
        message.setMsgType(Const.messageType);
        message.setMsgTitle(Const.invoiceMsgTitle);
        message.setMsgContent(msg);
        List<Long> ids = new ArrayList<Long>();
        ids.add(user.getId());
        messageService.pubMessage(message, ids);
    }

    /**
     * 冻结（停服）--发送手机验证码
     *
     * @param date
     */
    @Override
    public void sendLiveMaxMsg(Long userId, String date) {
        User user = userService.getUserById(userId);
        if (checkUserPhone(user)) {
            String mobile = user.getCountryCode()+user.getMobile();
            String msg = MessageFormat.format(Const.sendLiveMaxMsg, date);
            sendMsgUtils.sendMessage(mobile, msg);
        }
    }

    private String getcheckNum(String mobile) {
        String checkNum = NumberUtils.getSixRandomNum();
        cacheClient.set(mobile, 900, checkNum);
        return checkNum;
    }

    /**
     *
     * @param mobileAll 手机号
     * @param mobile 手机号
     * @param userIp
     * @param isReg 是否验证注册过
     * @return
     */
//    private String valMobile(String mobileAll,  String userIp) {
//
//            // 检查是否超过发送次数
//            if (!checkSendAllow(mobileAll, userIp)) {
//                return "2";
//            }
//
//        return null;
//    }

    /**
     * 1：单ip一天能发20条。 2：对单手机号一天最多发10条
     *
     * @param mobile
     * @param ip
     * @return true：没有超出限制，可以发 false：超出限制，不能发
     */
    private boolean checkSendAllow(String mobile, String ip) {
        if("123.126.33.253".equals(ip)|| ip.startsWith("10.58")) {
            return true;
        }
        int mobileAllow = 10;
        int ipAllow = 20;
        String maxSend = "maxSend-";

        int timeOut = 60 * 60 * 24;// 设置超时时间：一天

        long dayKey = System.currentTimeMillis() / (1000 * 60 * 60 * 24);

        // 检查电话号码
        String mobileKey = maxSend+mobile + "-" + dayKey;
        Integer mobilenum = null;
        synchronized (mobileKey.intern()) {
            mobilenum = (Integer) cacheClient.get(mobileKey);
            if (mobilenum == null) {
                mobilenum = new Integer(0);
            }
            if(mobileAllow > mobilenum){
                mobilenum++;

            }else{
                return false;
            }
        }
        Integer ipNum;

        // 检查ip
        String ipKey = maxSend + ip + "-" + dayKey;
        synchronized (ipKey.intern()) {
            ipNum = (Integer) cacheClient.get(ipKey);
            if (ipNum == null) {
                ipNum = new Integer(0);
            }
            if (ipAllow > ipNum) {
                ipNum++;
            } else {
                return false;
            }
        }

        cacheClient.set(ipKey, timeOut, ipNum);
        cacheClient.set(mobileKey, timeOut, mobilenum);
        return true;
    }



}