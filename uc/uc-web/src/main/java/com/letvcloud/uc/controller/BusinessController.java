package com.letvcloud.uc.controller;

import com.letvcloud.bill.service.BillServiceOpenService;
import com.letvcloud.bill.vo.FeatherCondition;
import com.letvcloud.uc.po.User;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Steven on 2015/7/6.
 */

@Controller
@RequestMapping("/business")
public class BusinessController extends BaseController {

    @Autowired
    private BillServiceOpenService billServiceOpenService;


    @RequestMapping("/modifyBillWay")
    public String modifyBillWay(String featherCode, String serviceCode, String feeCodeNext, HttpServletRequest request) {

        if (StringUtils.isNotBlank(featherCode) && StringUtils.isNotBlank(serviceCode) && StringUtils.isNotBlank(feeCodeNext)) {

            User user = getCurrentUser(request);
            FeatherCondition featherCondition = new FeatherCondition();
            featherCondition.setUserId(user.getId());
            featherCondition.setFeatherCode(featherCode);
            featherCondition.setServiceCode(serviceCode);
            featherCondition.setFeeCodeNext(feeCodeNext);
            billServiceOpenService.changeFeather(featherCondition);

            return null;
        }
        return null;
    }


}
