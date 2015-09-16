package com.letvcloud.uc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.letvcloud.uc.utils.Const;
import com.letvcloud.uc.utils.constant.CacheHeadContant;
import com.letvcloud.uc.utils.constant.MobileStatusContant;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.mgt.DefaultSecurityManager;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.UnknownSessionException;
import org.apache.shiro.session.mgt.DefaultSessionKey;
import org.apache.shiro.session.mgt.SessionKey;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.letvcloud.bill.po.BillUserAmount;
import com.letvcloud.bill.service.BillUserAmountService;
import com.letvcloud.saas.controller.FastJsonViewSupport;
import com.letvcloud.saas.exception.BusinessException;
import com.letvcloud.saas.util.IPUtil;
import com.letvcloud.saas.util.StringUtil;
import com.letvcloud.saas.util.cache.CacheClient;
import com.letvcloud.uc.po.User;
import com.letvcloud.uc.service.EnterpriseAuthenService;
import com.letvcloud.uc.service.MessageBusService;
import com.letvcloud.uc.service.UserService;
import com.letvcloud.uc.utils.CheckUtils;
import com.letvcloud.uc.utils.constant.EmailStatusContant;
import com.letvcloud.uc.utils.constant.FlagContant;
import com.letvcloud.uc.vo.UserVo;

/**
 * Created by zhaoliang5 on 2015/6/14.
 */

@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

    Logger logger = LoggerFactory.getLogger(UserController.class);
    Logger modifyMobileLogger = LoggerFactory.getLogger("modifyMobile");
    Logger modifyPwdLogger = LoggerFactory.getLogger("modifyPwd");

    @Value("#{configProperties['mobile.SendMessageAllow']}")
    private int mobileAllow;
    @Value("#{configProperties['ip.SendMessageAllow']}")
    private int ipAllow;
    @Autowired
    private UserService userService;
    @Autowired
    private MessageBusService messageBusService;

    @Autowired
    private DefaultSecurityManager securityManager;

    @Autowired
    private BillUserAmountService billUserAmountService;

    @Autowired
    private EnterpriseAuthenService enterpriseAuthenService;

    @Autowired
    private CacheClient cacheClient;


    /**
     * 获取当前用户信息
     *
     * @param request
     * @return
     */
    @RequestMapping("/searchCurrentUser")
    @ResponseBody
    public void searchCurrentUser(HttpServletResponse response, HttpServletRequest request, String jsoncallback)
            throws IOException {
        User user = this.getCurrentUser(request);
        if (user != null){
            user.setPassword(null);
        }
        iShowHeader(response, user, jsoncallback);

    }

    private void iShowHeader(HttpServletResponse response,User user, String jsoncallback) throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=utf-8");
        response.setHeader("Access-Control-Allow-Origin", "www.letvcloud.com");
        response.setHeader("Access-Control-Allow-Credentials", "true");
        PrintWriter out = response.getWriter();
        if (StringUtils.isNotEmpty(jsoncallback)) {
            out.print(jsoncallback + "(");
        }
        out.print(JSONObject.toJSONString(user));
        if (StringUtils.isNotEmpty(jsoncallback)) {
            out.print(")");
        }
        out.flush();
        out.close();
    }

    /**
     * 1：单ip一天能发20条。 2：对单手机号一天最多发5条
     *
     * @param mobile
     * @param ip
     * @return true：没有超出限制，可以发 false：超出限制，不能发
     */
    private boolean checkSendAllow(String mobile, String ip) {


        int timeOut = 60 * 60 * 24;// 设置超时时间：一天

        long dayKey = System.currentTimeMillis() / (1000 * 60 * 60 * 24);

        // 检查电话号码
        String mobileKey = mobile + "-" + dayKey;
        int mobileNum;
        AtomicInteger num = (AtomicInteger) cacheClient.get(mobileKey);
        if (num == null) {
            num = new AtomicInteger(0);
        }
        mobileNum = num.intValue();

        // 检查ip
        String ipKey = ip + "-" + dayKey;
        int ipNum;
        AtomicInteger numIp = (AtomicInteger) cacheClient.get(ipKey);
        if (numIp == null) {
            numIp = new AtomicInteger(0);
        }
        ipNum = numIp.intValue();

        if (mobileAllow > mobileNum && ipAllow > ipNum) {
            num.incrementAndGet();
            numIp.incrementAndGet();
            cacheClient.set(mobileKey, timeOut, num);
            cacheClient.set(ipKey, timeOut, numIp);

            return true;
        }

        return false;
    }

    // public static void main(String[] args){
    // while (true){
    // try {
    // Thread.sleep(1000);
    // } catch (InterruptedException e) {
    // e.printStackTrace();
    // }
    // UserController c = new UserController();
    // System.out.println(c.checkSendAllow("8613012345671","123.123.123.123"));
    // System.out.println(c.checkSendAllow("8613012345672","123.123.123.123"));
    // System.out.println(c.checkSendAllow("8613012345673","123.123.123.123"));
    // System.out.println(c.checkSendAllow("8613012345674","123.123.123.123"));
    // System.out.println(c.checkSendAllow("8613012345675","123.123.123.123"));
    // }
    // }

    /**
     * 发送手机验证码(找回密码)
     *
     * @param mobile
     * @param request
     */
    @RequestMapping(value = "/sendMsgForBack", method = RequestMethod.GET)
    @ResponseBody
    public void sendMsgForBack(String mobile, HttpServletRequest request) {
        messageBusService.sendMsgVerification(mobile, IPUtil.getIpAddr(request));
    }

    /**
     * 发送手机验证码
     *
     * @param mobile
     * @param request
     */
    @RequestMapping(value = "/sendMsg", method = RequestMethod.GET)
    @ResponseBody
    public String sendMsg(String mobileAll, String mobile, HttpServletRequest request) {
        return messageBusService.sendRegMobileMsg(mobileAll, mobile, IPUtil.getIpAddr(request));
    }

    /**
     * 发送修改手机验证码
     *
     * @param request
     */
    @RequestMapping(value = "/sendReplaceMobileMsg", method = RequestMethod.GET)
    @ResponseBody
    public String sendReplaceMobileMsg( String mobileAll, String mobile, HttpServletRequest request) {
        return messageBusService.sendReplaceMobileMsg(mobileAll, mobile, IPUtil.getIpAddr(request));
    }

    /**
     * 发送手机验证码 检查一次验证码
     *
     * @param mobile
     * @param request
     */
    @RequestMapping(value = "/sendMsgCheckYzm", method = RequestMethod.GET)
    @ResponseBody
    public String sendMsgCheckYzm(String yzm ,String countryCode, String mobile, HttpServletRequest request) {
        Subject subject = SecurityUtils.getSubject();
        String oldCaptcha = (String) cacheClient.get(Const.captchaPhoneHead + subject.getSession().getId());
        if(StringUtils.isNotBlank(oldCaptcha)&&oldCaptcha.toUpperCase().equals(yzm.toUpperCase())){
            try {
                return userService.sendRegMobileMsg(countryCode, mobile, IPUtil.getIpAddr(request));
            } catch (BusinessException e) {
                logger.error(e.getMessage(),e);
                return FlagContant.FAILURE_FLAG;
            }
        }else{
            return FlagContant.FAILURE_FLAG;
        }
    }

    /**
     * 校验手机验证码
     *
     * @param checkCode
     * @param request
     * @return
     */
    @RequestMapping(value = "/checkMobileCode", method = RequestMethod.GET)
    @ResponseBody
    public String checkMobileCode(String mobile, String checkCode, HttpServletRequest request) {

        String ip = IPUtil.getIpAddr(request);
        if(!"123.126.33.253".equals(ip) && !ip.startsWith("10.58")) {
            Integer count = (Integer) cacheClient.get(CacheHeadContant.checkMobileCodeKey + ip);
            if (count != null) {
                count = count + 1;
            } else {
                count = 1;
            }
            if(count<=10){
                cacheClient.set((CacheHeadContant.checkMobileCodeKey + ip), 18000, count);
            }else{
                return "P";
            }

        }

        String result = FlagContant.FAILURE_FLAG;

        String checkNum = (String) cacheClient.get(mobile);

        if (StringUtils.isNotBlank(checkNum) && StringUtils.isNotBlank(checkCode)) {
            if (checkNum.equals(checkCode)){
                result = FlagContant.SUCCESS_FLAG;
                cacheClient.delete((CacheHeadContant.checkMobileCodeKey + ip));
            }
        }

        return result;
    }

    /**
     * 校验手机号码是否合法
     *
     * @param mobileNum
     * @return
     */
    @RequestMapping(value = "/isMobileNum", method = RequestMethod.GET)
    @ResponseBody
    public String isMobileNum(String mobileNum, String countryCode) {
        String res;
        if (countryCode.equals("86")) {
            res = CheckUtils.isMobile(mobileNum) ? FlagContant.SUCCESS_FLAG : FlagContant.FAILURE_FLAG;
        } else {
            res = CheckUtils.isNum(mobileNum) ? FlagContant.SUCCESS_FLAG : FlagContant.FAILURE_FLAG;
        }
        return res;
    }

    /**
     * 校验邮箱帐号是否合法
     *
     * @param email
     * @return
     */
    @RequestMapping(value = "/isEmail", method = RequestMethod.GET)
    @ResponseBody
    public String isEmail(String email) {
        return CheckUtils.isEmail(email) ? FlagContant.SUCCESS_FLAG : FlagContant.FAILURE_FLAG;
    }

    /**
     * 校验手机是否存在
     *
     * @param mobile
     * @return
     */
    @RequestMapping(value = "/mobileIsExist")
    @ResponseBody
    public String mobileIsExist(HttpServletRequest request,String countryCode,String mobile) {
        String ip = IPUtil.getIpAddr(request);
        if(!"123.126.33.253".equals(ip)&& !ip.startsWith("10.58")&&!ip.equals("127.0.0.1")){
            Integer count = (Integer) cacheClient.get(CacheHeadContant.mobileExistKey + ip);
            if(count!=null){
                count = count+1;
            }else {
                count=1;
            }
            if(count<=10){
                cacheClient.set((CacheHeadContant.mobileExistKey + ip),18000, count);
            }else{
                return "P";
            }

        }
        try {
            User user = getCurrentUser(request);
            if(user!=null&&countryCode.equals(user.getCountryCode())&&mobile.equals(user.getMobile())){
                return FlagContant.SUCCESS_FLAG;
            }
            return (StringUtil.isEmpty(mobile) || userService.getUserByMobile(mobile,countryCode) != null) ? FlagContant.SUCCESS_FLAG
                    : FlagContant.FAILURE_FLAG;
        } catch (BusinessException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return FlagContant.FAILURE_FLAG;
        }
    }

    /**
     * 校验邮箱是否存在
     *
     * @param email
     * @return
     */
    @RequestMapping(value = "/emailIsExist")
    @ResponseBody
    public String emailIsExist(HttpServletRequest request,String email) {

        String ip = IPUtil.getIpAddr(request);
        if(!"123.126.33.253".equals(ip) && !ip.startsWith("10.58")) {
            Integer count = (Integer) cacheClient.get(CacheHeadContant.emailExistKey + ip);
            if (count != null) {
                count = count + 1;
            } else {
                count = 1;
            }
            if(count<=10){
                cacheClient.set((CacheHeadContant.emailExistKey + ip), 18000, count);
            }else {
                return "P";
            }
        }
        try {
            return userService.getUserByEmail(email) != null ? FlagContant.SUCCESS_FLAG : FlagContant.FAILURE_FLAG;
        } catch (BusinessException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return FlagContant.FAILURE_FLAG;
        }
    }

    /**
     * 修改用户基本信息 修改成功后页面还没提供
     *
     * @param userVo
     * @return
     */
    @RequestMapping(value = "/modifyUserInfo", method = RequestMethod.POST)
    @ResponseBody
    public String modifyUserInfo(UserVo userVo, HttpServletRequest request) {
        userService.modifyUserInfo(this.getCurrentUser(request).getId(), userVo);
        return null;
    }

    /**
     * 修改老用户为新用户
     *
     * @param isOld
     * @return
     */
    @RequestMapping(value = "/modifyOld", method = RequestMethod.POST)
    @ResponseBody
    public String modifyOld(Integer isOld, HttpServletRequest request) {
        userService.modifyOld(this.getCurrentUser(request).getId(), isOld);
        return null;
    }

    /**
     * 修改用户登录密码
     *
     * @param newPassword
     * @param request
     * @return
     */
    @RequestMapping(value = "/modifyPassword", method = RequestMethod.POST)
    @ResponseBody
    public String modifyPassword(String upwdOlder, String newPassword, HttpServletRequest request) {

        Map<String, String> logParams = getLogParam(request);
        String ip = logParams.get("ip");
        String currentDate = logParams.get("currentDate");
        String flag = "";
        String error = "";
        if (StringUtil.isEmpty(newPassword)) {

            flag = "error";
            error = "param password is null";
        } else {
            flag = "success";
        }
        User currentUser = this.getCurrentUser(request);
        String mobile = currentUser.getMobile();
        String email = currentUser.getEmail();
        String user_unique = currentUser.getUserUnique();

        String computePassword = userService.computePassword(upwdOlder, currentUser.getUserUnique());
        if (!currentUser.getPassword().equals(computePassword)) {
            modifyPwdLogger.info("inModifypwd###user_unique:{}###username:{}###mobile:{}###ip:{}###state:{}###failereason:{}###date:{}",
                    user_unique, email, mobile, ip, "error", "旧密码错误", currentDate);
            return FlagContant.FAILURE_FLAG;
        }

        try {
            userService.modifyPassword(currentUser.getId(), newPassword);
        } catch (Exception e) {
            error = e.getMessage();
        }

        modifyPwdLogger.info("inModifypwd###user_unique:{}###username:{}###mobile:{}###ip:{}###state:{}###failereason:{}###date:{}",
                user_unique, email, mobile, ip, flag, error, currentDate);
        if ("success".equals(flag)) {
            return FlagContant.SUCCESS_FLAG;
        } else {
            return FlagContant.FAILURE_FLAG;
        }
    }

    /**
     * 修改用户注册手机号码
     *
     * @param mobile
     * @return
     */
    @RequestMapping("/modifyMobile")
    @ResponseBody
    public String modifyMobile(String areaInput, String mobile, HttpServletRequest request) {
        User user = this.getCurrentUser(request);
        Map<String, String> logParams = getLogParam(request);
        String ip = logParams.get("ip");
        String currentDate = logParams.get("currentDate");
        String oldMobile = user.getMobile();
        String logFlag = "";
        String logError = "";
        if (StringUtil.isEmpty(mobile)) {
            logFlag = "error";
            logError = "mobile is empty";
        } else {
            logFlag = "success";
        }

        cacheClient.delete(areaInput + mobile);

        userService.modifyMobile(user.getId(),areaInput, mobile);
        modifyMobileLogger
                .info("inModifyMobile###user_unique:{}###username:{}###oldmobile:{}###newmobile:{}###ip:{}###state:{}###failereason:{}###date:{}",
                        user.getUserUnique(), user.getEmail(), oldMobile, mobile, ip, logFlag, logError, currentDate);
        return FlagContant.SUCCESS_FLAG;
    }

    /**
     * 是否是当前用户的手机号码
     *
     * @param mobile
     * @return
     */
    @RequestMapping(value = "/isCurrentUserMobile", method = RequestMethod.GET)
    @ResponseBody
    public String isCurrentUserMobile(String mobile, HttpServletRequest request) {
        String result = FlagContant.FAILURE_FLAG;
        User currentUser = this.getCurrentUser(request);
        if (currentUser != null) {
            if (currentUser.getMobile().equals(mobile))
                result = FlagContant.SUCCESS_FLAG;
        }
        return result;
    }

    /**
     * 是否是当前用户的Email
     *
     * @param email
     * @return
     */
    @RequestMapping(value = "/isCurrentUserEmail", method = RequestMethod.GET)
    @ResponseBody
    public String isCurrentUserEmail(String email, HttpServletRequest request) {

        String result = FlagContant.FAILURE_FLAG;

        if (StringUtils.isNotBlank(email)) {
            User currentUser = this.getCurrentUser(request);
            if (currentUser != null) {
                if (email.equals(currentUser.getEmail()))
                    result = FlagContant.SUCCESS_FLAG;
            }
        }
        return result;
    }

    /**
     * 是否是当前用户的登录密码
     *
     * @param password
     * @return
     */
    @RequestMapping(value = "/isCurrentPassword")
    @ResponseBody
    public String isCurrentPassword(String password, HttpServletRequest request) {
        String result = FlagContant.FAILURE_FLAG;
        if (StringUtils.isNotBlank(password)) {
            User currentUser = this.getCurrentUser(request);
            if (currentUser != null) {
                String computePassword = userService.computePassword(password, currentUser.getUserUnique());
                if (currentUser.getPassword().equals(computePassword)) {
                    result = FlagContant.SUCCESS_FLAG;
                }
            }
        }
        return result;
    }

    /**
     * 根据邮箱查询用户
     */

    @RequestMapping("/searchUserByEmail")
    @ResponseBody
    public String searchUserByEmail(String email) {
        if (StringUtils.isEmpty(email)) {
            return FlagContant.FAILURE_FLAG;
        }
        try {
            return userService.getUserByEmail(email) != null ? FlagContant.SUCCESS_FLAG : FlagContant.FAILURE_FLAG;
        } catch (BusinessException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return FlagContant.FAILURE_FLAG;
        }
    }

    @RequestMapping("/searchUserByMobile")
    @ResponseBody
    public String searchUserByMobile(String mobile,String areaInput) {
        if (StringUtils.isEmpty(mobile)) {
            return FlagContant.FAILURE_FLAG;
        }
        try {
            return userService.getUserByMobile(mobile,areaInput) != null ? FlagContant.SUCCESS_FLAG : FlagContant.FAILURE_FLAG;
        } catch (BusinessException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return FlagContant.FAILURE_FLAG;
        }
    }

    @RequestMapping("/searchCurrentUserAmount")
    @ResponseBody
    public BillUserAmount searchCurrentUserAmount(HttpServletRequest request) {

        BillUserAmount billUserAmount = billUserAmountService.getUserAmount(getCurrentUser(request).getId());

        return billUserAmount;
    }

    @RequestMapping("/updateUserAvatar")
    @ResponseBody
    public String updateUserAvatar(HttpServletRequest request, String userAvatar) {
        userService.modifyUserAvatar(this.getCurrentUser(request).getId(), userAvatar);
        return FlagContant.SUCCESS_FLAG;
    }

    @RequestMapping("/userInfo")
    public ModelAndView userInfo(String sessionId) {

        User user = new User();
        try {
            SessionKey sessionKey = new DefaultSessionKey(sessionId);
            Session session = securityManager.getSession(sessionKey);
            if (session != null) {
                session.touch();

                SecurityUtils.setSecurityManager(securityManager);

                Subject requestSubject = new Subject.Builder().sessionId(sessionId).buildSubject();
                User user1 = (User) requestSubject.getPrincipal();
                if (user1 != null) {
                    user1 = userService.getUserById(user1.getId());
                    user1.setPassword(null);
                    user = user1;
                }
            }
        } catch (UnknownSessionException e) {

        }

        ModelAndView mv = FastJsonViewSupport.getSimpleJsonView(user, true, "", null);
        return mv;
    }

    @RequestMapping("/userBalance.do")
    public void userBalance(HttpServletRequest request, HttpServletResponse response) throws IOException {
        BillUserAmount billUserAmount = billUserAmountService.getUserAmount(getCurrentUser(request).getId());
        JSONObject JuserAmount = new JSONObject();
        DecimalFormat formatter = new DecimalFormat("0.00");// billUserAmount.getAvailableAmount().doubleValue()
        String userAmount = formatter.format(billUserAmount.getAvailableAmount().doubleValue());
        JuserAmount.put("userAmount", userAmount);// 制定精度
        iuserBalance(response, JuserAmount);
    }

    private void iuserBalance(HttpServletResponse response, JSONObject JuserAmount) throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=utf-8");
        PrintWriter out = response.getWriter();
        out.print(JuserAmount);
        out.flush();
        out.close();
    }

    /**
     * 获取用户相关认证信息
     *
     * @param request
     * @return
     */
    @RequestMapping("/getUserInfoAuthenStatus.do")
    @ResponseBody
    public String getUserInfoAuthenStatus(HttpServletRequest request) {
        User user = this.getCurrentUser(request);
        JSONObject json = new JSONObject();
        if (user != null) {
            json.put("state", true);

            if (user.getEmailStatus() != null
                    && EmailStatusContant.ACTIVATE.intValue() == user.getEmailStatus().intValue()) {
                json.put("emailState", true);
            } else {
                json.put("emailState", false);
            }
            if (user.getMobileStatus()!=null&&user.getMobileStatus().intValue()== MobileStatusContant.ACTIVE.intValue()) {
                json.put("mobileState", true);
                json.put("countryCode", user.getCountryCode());
                String model = user.getMobile();
                int s = model.length() / 2-2;
                model = model.replaceAll("(\\d{"+s+"})\\d{4}(\\d{"+s+"})", "$1****$2");
                json.put("mobile","+"+user.getCountryCode()+" "+ model+"。");
            } else {
                json.put("mobileState", false);
            }
            json.put("authenState", user.getExamineStatus());

        } else {
            json.put("state", false);
        }

        return json.toJSONString();
    }

    /**
     * 判断是否老用户
     *
     * @param request
     * @return
     */
    @RequestMapping("/checkOldUser.do")
    @ResponseBody
    public String checkOldUser(HttpServletRequest request) {
        User user = this.getCurrentUser(request);
        if (user != null) {
            return user.getIsOld() + "";
        }

        return "-1";
    }

    /**
     * 获取大于id的集合
     *
     * @return
     */
    @RequestMapping(value = "/findGreaterIds", method = RequestMethod.GET)
    @ResponseBody
    public Map findGreaterIds(@RequestParam("id") Long id) {
        Map<String, Object> result = new HashMap<String, Object>();
        List<Long> list = userService.findGreaterIds(id);
        result.put("list", list);
        return result;
    }
}