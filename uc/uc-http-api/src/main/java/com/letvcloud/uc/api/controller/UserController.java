package com.letvcloud.uc.api.controller;

import com.letvcloud.bill.po.BillUserAmount;
import com.letvcloud.bill.service.BillServiceOpenService;
import com.letvcloud.bill.service.BillUserAmountService;
import com.letvcloud.bill.vo.BillServiceOpen;
import com.letvcloud.saas.controller.FastJsonViewSupport;
import com.letvcloud.uc.api.po.UserVo;
import com.letvcloud.uc.po.User;
import com.letvcloud.uc.service.UserService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author hanfeng
 * @date 15/7/14
 */

@Controller
public class UserController {

    @Autowired
    UserService userService;

    @Autowired
    BillUserAmountService billUserAmountService;

    @Autowired
    BillServiceOpenService billServiceOpenService;

    @RequestMapping("/userInfoById")
    public ModelAndView getUserInfo(long userId) {
        User user = userService.getUserById(userId);
        UserVo userVo = new UserVo();
        if (user == null)
            return FastJsonViewSupport.getSimpleJsonView(userVo, true, "5m");
        ;
        user.setPassword(null);

        BeanUtils.copyProperties(user, userVo);

        mergeFeeAndService(userId, user, userVo);
        return FastJsonViewSupport.getSimpleJsonView(userVo, true, "5m");
    }

    private void mergeFeeAndService(long userId, User user, UserVo userVo) {
        mergeFee(user, userVo);
        mergeServices(userId, userVo);
    }

    private void mergeServices(long userId, UserVo userVo) {
        List<BillServiceOpen> serviceCodes = billServiceOpenService.getServiceByUserId(userId);

        userVo.setBillServiceOpenList(serviceCodes);
    }

    private void mergeFee(User user, UserVo userVo) {
        userVo.setArrearage(true);
        BillUserAmount billUserAmount = billUserAmountService.getUserAmount(user.getId());
        if (billUserAmount != null) {
            userVo.setAvailableAmount(billUserAmount.getAvailableAmount());
            userVo.setArrearageTime(billUserAmount.getArrearageTime());
            if (billUserAmount.getAvailableAmount().compareTo(new BigDecimal(0))  != -1) {
                userVo.setArrearage(false);
            }
        }
    }

    @RequestMapping("/userInfoByUU")
    public ModelAndView getUserInfo(String userUnique) {

        User user = userService.getUserByUnique(userUnique);
        UserVo userVo = new UserVo();
        if (user == null)
            return FastJsonViewSupport.getSimpleJsonView(userVo, true, "5m");
        user.setPassword(null);

        BeanUtils.copyProperties(user, userVo);

        mergeFeeAndService(user.getId(), user, userVo);
        return FastJsonViewSupport.getSimpleJsonView(userVo, true, "5m");
    }


    @RequestMapping("/getUserId")
    @ResponseBody
    public Map<String,Long> getUserId(){
       Map<String,Long> userIdMap = new HashMap<String, Long>();
       long newUserId =  userService.getUserId();
       userIdMap.put("userId",newUserId);
        return userIdMap;
    }

    @RequestMapping("/setUserId")
    @ResponseBody
    public String getUserId(long fristUserId,String key){
        boolean seted =  userService.setUserId(fristUserId,"tlldll".equals(key));
        return Boolean.toString(seted);
    }

}
