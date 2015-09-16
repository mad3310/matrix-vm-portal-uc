package com.letvcloud.uc.controller;

import com.letvcloud.bill.BillServiceType;
import com.letvcloud.bill.service.BillServiceOpenService;
import com.letvcloud.bill.vo.BillServiceOpen;
import com.letvcloud.uc.po.Country;
import com.letvcloud.uc.service.AreaService;
import com.letvcloud.uc.service.CountryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhaoliang5 on 2015/6/28.
 */
@Controller
@RequestMapping("/userView")
public class UserViewController extends BaseController{

    @Autowired
    private CountryService countryService;

    @Autowired
    private AreaService areaService;

    @Autowired
    BillServiceOpenService billServiceOpenServiceImpl;


    @RequestMapping(value = "/accountManagerView")
    public String accountManagerView(HttpServletRequest request) {
        List<Country> countryList = countryService.getCountryList();
        request.setAttribute("userAvatar", this.getCurrentUser(request).getUserAvatar()); 
        request.setAttribute("countryList", countryList);
        return "ucAccountManager";
    }



    @RequestMapping("/userKeyView")
    public String userKeyView() {
        return "ucUserKey";
    }


    @RequestMapping("/ucOverview")
    public String ucOverview(HttpServletRequest request) {
        Long userId = getCurrentUser(request).getId();
    	List<Country> countryList = countryService.getCountryList();
    	request.setAttribute("userAvatar", this.getCurrentUser(request).getUserAvatar()); 
    	request.setAttribute("countryList", countryList);

        //服务是否存在
        boolean isExist=false,isLive=false,isVod=false,isCdn=false;
        //获取所有开通的服务
        List<BillServiceOpen> services = billServiceOpenServiceImpl.getServiceByUserId(userId);
        List<BillServiceOpen> cdns =new ArrayList<BillServiceOpen>();
        if(services!=null && services.size()>0) {
            isExist=true;
            for (BillServiceOpen service : services) {
                if ("100".equals(service.getServiceCode())) {
                    isLive=true;
                    request.setAttribute("liveFeeCodeNow", service.getFeeCodeNow());
                    request.setAttribute("liveFeeCodeNext", service.getFeeCodeNext());
                    request.setAttribute("liveState", service.getAmountState());
                    continue;
                } else if ("101".equals(service.getServiceCode())) {
                    isVod=true;
                    request.setAttribute("vodFeeCodeNow", service.getFeeCodeNow());
                    request.setAttribute("vodFeeCodeNext", service.getFeeCodeNext());
                    request.setAttribute("vodState", service.getAmountState());
                    continue;
                } else {
                    isCdn=true;
                    cdns.add(service);
                }
            }
        }
        //是否存在服务
        request.setAttribute("isExist",isExist);
        //云直播是否存在
        request.setAttribute("isLive",isLive);
        //云点播是否存在
        request.setAttribute("isVod",isVod);
        //cdn是否存在
        request.setAttribute("isCdn",isCdn);
        //设置开通的CDN服务
        request.setAttribute("cdns", cdns);


        Boolean login = (Boolean)request.getAttribute("login");
        if(login != null){
            request.setAttribute("login",login);
        }

        return "ucOverview";
    }










}