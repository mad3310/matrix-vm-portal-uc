package com.letvcloud.uc.controller;

//import com.lecloud.statistics.bill.service.business.BillingDataService;

import java.util.List;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.letvcloud.bill.service.BillServiceOpenService;
import com.letvcloud.bill.vo.BillServiceOpen;
import com.letvcloud.uc.po.User;
import com.letvcloud.uc.utils.constant.FlagContant;
import com.letvcloud.uc.utils.constant.ServiceCodeContant;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by zhaoliang5 on 2015/7/3.
 */

@RequestMapping("/businessView")
@Controller
public class BusinessViewController extends BaseController {

    @Autowired
    private BillServiceOpenService billServiceOpenService;


//    private BillingDataService billingDataService;

    @RequestMapping("/isOpenService")
    @ResponseBody
    public String isOpenService(String serviceCode, HttpServletRequest request) {

        User currentUser = getCurrentUser(request);

        boolean b = billServiceOpenService.isServiceOpened(currentUser.getId(), serviceCode);

        return b ? FlagContant.SUCCESS_FLAG : FlagContant.FAILURE_FLAG;
    }
    @RequestMapping("/switchServer")
    public String switchServer(HttpServletRequest request,String serverCode){
    	String view ="";
    	if(serverCode.equals(ServiceCodeContant.CLOUD_LIVE)){
    		view = liveView(request);
    	}else if(serverCode.equals(ServiceCodeContant.CLOUD_VOD)){
    		view =onDemandView(request);
    	}else{
    		view = cdnView(request);
    	}
    	return view;
    }

    @RequestMapping("/liveView")
    public String liveView(HttpServletRequest request) {

        User currentUser = getCurrentUser(request);


//        billServiceOpenService.getUserFeather(currentUser.getId(),servivceCode);
//        billingDataService.

        BillServiceOpen billServiceOpen = billServiceOpenService.getServiceByCode(currentUser.getId(), ServiceCodeContant.CLOUD_LIVE);


        request.setAttribute("billServiceOpen", billServiceOpen);
        return "ucServiceLive";
    }

    @RequestMapping("/cdnView")
    public String cdnView(HttpServletRequest request) {

        User currentUser = getCurrentUser(request);

        BillServiceOpen billServiceOpenLive = billServiceOpenService.getServiceByCode(currentUser.getId(), ServiceCodeContant.CDN_LIVE);
        BillServiceOpen billServiceOpenOnDemand = billServiceOpenService.getServiceByCode(currentUser.getId(), ServiceCodeContant.CDN_VOD);

        request.setAttribute("billServiceOpenLive", billServiceOpenLive);
        request.setAttribute("billServiceOpenOnDemand", billServiceOpenOnDemand);
        return "ucServiceCdn";
    }

    @RequestMapping("/onDemandView")
    public String onDemandView(HttpServletRequest request) {


        User currentUser = getCurrentUser(request);

        BillServiceOpen billServiceOpen = billServiceOpenService.getServiceByCode(currentUser.getId(), ServiceCodeContant.CLOUD_VOD);

        request.setAttribute("billServiceOpen", billServiceOpen);
        return "ucServiceOnDemand";
    }


    @RequestMapping("/modifyBillWayView")
    public String modifyBillWayView(HttpServletRequest request, String featherCode, String serviceCode) {


        request.setAttribute("featherCode", featherCode);

        request.setAttribute("serviceCode", serviceCode);
        return "modifyBillWay";
    }

    @RequestMapping("/getUserServer")
    @ResponseBody
    public String getUserServer(HttpServletRequest request) {
    	//List<String> servers = billServiceOpenService.getUserService(this.getCurrentUser(request).getId());
    	User user = this.getCurrentUser(request);
    	List<String> servers = billServiceOpenService.getUserService(user.getId());
    	JSONObject jsonObject = new JSONObject();
    	for(String server:servers){
    	
    		if(server.equals(ServiceCodeContant.CLOUD_LIVE)){
    			jsonObject.put("云直播",server);
    		}else if(server.equals(ServiceCodeContant.CLOUD_VOD)){
    			jsonObject.put("云点播", server);
//    		}else if(server.equals(ServiceCodeContant.CDN_LIVE)){
//    			jsonObject.put("CDN直播", server);
//    		}else if(server.equals(ServiceCodeContant.CDN_VOD)){
//    			jsonObject.put("CDN点播", server);
//    		}else if(server.equals(ServiceCodeContant.CDN_SMAILLFILE)){
//    			jsonObject.put("CDN小文件", server);
//    		}
    		}else{
    			jsonObject.put("CDN", server);
    		}
    	}
        return jsonObject.toJSONString();
    }

//    @RequestMapping("/")


    @RequestMapping("/noServerView")
    public String noServerView(HttpServletRequest request) {
        return "showNoServer";
    }
}