package com.letvcloud.uc.controller;

import javax.servlet.http.HttpServletRequest;

import com.letvcloud.uc.utils.constant.ServiceCodeContant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.letvcloud.bill.service.BillServiceOpenService;
import com.letvcloud.bill.vo.BillServiceOpen;

import com.letvcloud.uc.po.User;
@Controller
@RequestMapping("/cloudserver")
public class OpenCloudServerController extends BaseController {
	 @Autowired
	    private BillServiceOpenService billServiceOpenService;
	/**
	 * 开通云直播服务
	 * @param request
	 * @return
	 */
    @RequestMapping("/openCloudLiveServer")
	public String openCloudLiveServer(HttpServletRequest request){
    		
    	BillServiceOpen billServiceOpen = billServiceOpenService.getServiceByCode(this.getCurrentUser(request).getId(), ServiceCodeContant.CLOUD_LIVE);
		billServiceOpenService.openService(billServiceOpen);
		return "";
	}
    
    /**
	 * 开通云直播服务
	 * @param request
	 * @return
	 */
    @RequestMapping("/openCloudLiveServerFill")
	public String openCloudLiveServerFill(HttpServletRequest request){
    		
//    	BillServiceOpen billServiceOpen = billServiceOpenService.getServiceByCode(this.getCurrentUser(request).getId(), ServiceCodeContant.CLOUD_LIVE);
//		billServiceOpenService.openService(billServiceOpen);
		return "";
	}
	/**
	 * 验证是否开通云点播服务
	 * @param request
	 * @return
	 */
    @RequestMapping("/openCloudVodServerView")
	public String isOpenCloudVodServer(HttpServletRequest request){
    	boolean openFlag = billServiceOpenService.isServiceOpened(this.getCurrentUser(request).getId(), ServiceCodeContant.CLOUD_VOD);
    	if(!openFlag){
    		return "cloudVodOpenServerFill";
    	}else{
    		return "cloudVodOpenServerSuccess";
    	}
		
	}
    
    /**
	 * 开通云点播服务
	 * @param request
	 * @return
	 */
    @RequestMapping("/openCloudVodServerExcute")
	public String openCloudVodServer(HttpServletRequest request){
    	User user = this.getCurrentUser(request);
    	BillServiceOpen billServiceOpen = billServiceOpenService.getServiceByCode(user.getId(), ServiceCodeContant.CLOUD_VOD);
    	billServiceOpen.setUserId(user.getId());
    	billServiceOpenService.openService(billServiceOpen);
    	return "";
		
	}

}
