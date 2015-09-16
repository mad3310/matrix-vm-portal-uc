package com.letvcloud.uc.controller;

import com.letvcloud.uc.po.Area;
import com.letvcloud.uc.po.User;
import com.letvcloud.uc.service.*;
import com.letvcloud.uc.utils.constant.FlagContant;
import com.letvcloud.uc.utils.constant.UserExamineContant;
import com.letvcloud.uc.utils.constant.UserTypeContant;
import com.letvcloud.uc.vo.AuthenVo;

import org.apache.commons.lang.StringUtils;
import org.directwebremoting.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

import java.io.IOException;
import java.util.List;


@RequestMapping("/qualificationsAuthenView")
@Controller
public class QualificationsAuthenViewController extends BaseController{
    @Autowired
    private AreaService areaService;

    @Autowired
    private EnterpriseAuthenService  enterpriseAuthenService;
    @Autowired
    private PersonAuthenService personAuthenService;
	@Autowired
 	private UserService userService;
    
    @RequestMapping("/fillMsgView")
    public String fillMsgView(HttpServletRequest request) {
    	User user =this.getCurrentUser(request);
    	String view = "";
		User referUser = userService.getUserById(user.getId());
		request.setAttribute("user", referUser);
		if(referUser!=null && referUser.getExamineStatus()!=null && referUser.getExamineStatus().intValue()==UserExamineContant.WAIT_EXAMINE.intValue()){
			enterpriseAuthenService.toAuthen(user.getId(),UserExamineContant.NOT_UPLOAD);
		}
		if(referUser.getExamineStatus()!=null&&referUser.getExamineStatus().intValue()==
				UserExamineContant.NOT_THROUGH.intValue()){
			request.setAttribute("NOT_THROUGH",true);
	}

			if(user.getUserType().intValue()!=UserTypeContant.PERSONAL.intValue()){
				List<Area> areaLevel1 = areaService.getAreaByLevel("1");
				request.setAttribute("areaLevel1", areaLevel1);
				List<Area> areaLevel2;
				if(referUser.getAreaLevel2()!=null){
					areaLevel2 = areaService.getAreaByUpAreaCode(referUser.getAreaLevel1().toString());
				}else{
					areaLevel2 = areaService.getAreaByUpAreaCode(areaLevel1.get(0).getId());
				}
				request.setAttribute("areaLevel2", areaLevel2);
				List<Area> areaLevel3;
				if(referUser.getAreaLevel3()!=null){
					areaLevel3 = areaService.getAreaByUpAreaCode(referUser.getAreaLevel2().toString());
				}else{
					areaLevel3 = areaService.getAreaByUpAreaCode(areaLevel2.get(0).getId());
				}
				request.setAttribute("areaLevel3", areaLevel3);

				view =  "ucAccountManagerAuthenFillMsg";

			}else{
				view = "ucUserAccountManagerAuthenFillMsg";
			}

        return view;
      
    }
	@RequestMapping("/fillMsgDiretView")
	public String fillMsgDiretView(HttpServletRequest request){
		User user =this.getCurrentUser(request);
		String view = "";

		User referUser = userService.getUserById(user.getId());
		request.setAttribute("user",referUser);

    	if(user.getUserType().intValue()!=UserTypeContant.PERSONAL.intValue()){
	        List<Area> areaLevel1 = areaService.getAreaByLevel("1");
	        request.setAttribute("areaLevel1", areaLevel1);
			List<Area> areaLevel2;
			if(referUser.getAreaLevel2()!=null){
				areaLevel2 = areaService.getAreaByUpAreaCode(referUser.getAreaLevel1().toString());
			}else{
				areaLevel2 = areaService.getAreaByUpAreaCode(areaLevel1.get(0).getId());
			}
	        request.setAttribute("areaLevel2", areaLevel2);
			List<Area> areaLevel3;
			if(referUser.getAreaLevel3()!=null){
				areaLevel3 = areaService.getAreaByUpAreaCode(referUser.getAreaLevel2().toString());
			}else{
				areaLevel3 = areaService.getAreaByUpAreaCode(areaLevel2.get(0).getId());
			}
	        request.setAttribute("areaLevel3", areaLevel3);
	        view ="ucAccountManagerAuthenFillMsg";
    	}else{
    		view ="ucUserAccountManagerAuthenFillMsg";
    	}
		return view;
	}
    @RequestMapping("/executeAuthen")
    public String executeMsg(HttpServletRequest request,AuthenVo authenVo) throws IOException {
    	User user =this.getCurrentUser(request);
    	String view = "";
		if (user.getExamineStatus() == null || user.getExamineStatus().intValue() != UserExamineContant.THROUGH.intValue()) {
				authenVo.setExamineStatus(UserExamineContant.WAIT_EXAMINE.toString());
		}

    	if(user.getUserType().intValue()!=UserTypeContant.PERSONAL.intValue()){
			enterpriseAuthenService.updateEnterpriseAuthen(user.getId(), authenVo);
    	}else{
			personAuthenService.updateEnterpriseAuthen(user.getId(), authenVo);
    	}
        return "redirect:/qualificationsAuthenView/executeRedirect.do";
    }
	@RequestMapping("/executeRedirect")
	public String executeRedirect(HttpServletRequest request){
		User user =this.getCurrentUser(request);
		String view;
		if(user.getUserType().intValue()!=UserTypeContant.PERSONAL.intValue()){
			String areaName1 = areaService.getSingleArea(user.getAreaLevel1().toString()).getAreaName();
			String areaName2 = areaService.getSingleArea(user.getAreaLevel2().toString()).getAreaName();
			String areaName3 = areaService.getSingleArea(user.getAreaLevel3().toString()).getAreaName();
			request.setAttribute("areaName1", areaName1);
			if("市辖区".equals(areaName2)||"县".equals(areaName2)){
				request.setAttribute("areaName2","");
			}else{
				request.setAttribute("areaName2", areaName2);
			}
			request.setAttribute("areaName3", areaName3);

			view = "ucAccountManagerAuthenExecute";
		}else{
			view = "ucUserAccountManagerAuthenExecute";
		}
		request.setAttribute("user", user);
		return view;
	}


	@RequestMapping("/executeAuthenView")
	public String executeMsgView(HttpServletRequest request) throws IOException {
		User user =this.getCurrentUser(request);
		String view="";
		if(user.getUserType().intValue()!=UserTypeContant.PERSONAL.intValue()){
			String areaName1 = areaService.getSingleArea(user.getAreaLevel1().toString()).getAreaName();
			String areaName2 = areaService.getSingleArea(user.getAreaLevel2().toString()).getAreaName();
			String areaName3 = areaService.getSingleArea(user.getAreaLevel3().toString()).getAreaName();
			request.setAttribute("areaName1", areaName1);
			if("市辖区".equals(areaName2)||"县".equals(areaName2)){
				request.setAttribute("areaName2","");
			}else{
				request.setAttribute("areaName2", areaName2);
			}
			request.setAttribute("areaName3", areaName3);
			view = "ucAccountManagerAuthenExecute";
		}else{
			view = "ucUserAccountManagerAuthenExecute";
		}

		request.setAttribute("user", user);
		return view;
	}
    @RequestMapping("/authenSuccess")
    public String saveEenterpriseInfo(HttpServletRequest request) {
    	User user =this.getCurrentUser(request);
    	String view = "";
    	if(user.getUserType().intValue()!=UserTypeContant.PERSONAL.intValue()){
			String areaName1 = areaService.getSingleArea(user.getAreaLevel1().toString()).getAreaName();
			String areaName2 = areaService.getSingleArea(user.getAreaLevel2().toString()).getAreaName();
			String areaName3 = areaService.getSingleArea(user.getAreaLevel3().toString()).getAreaName();
        	request.setAttribute("areaName1", areaName1);
			if("市辖区".equals(areaName2)||"县".equals(areaName2)){
				request.setAttribute("areaName2","");
			}else{
				request.setAttribute("areaName2", areaName2);
			}
        	request.setAttribute("areaName3", areaName3);
        	view = "ucAccountManagerAuthenSuccess";
    	}else{
    		view = "ucUserAccountManagerAuthenSuccess";
    	}
     	request.setAttribute("user", user);
    	return view;
    }
   @RequestMapping(value="/getEnterpriseAuthenStatus")
   @ResponseBody
   public String getEnterpriseAuthenStatus(HttpServletRequest request){

	   User user = this.getCurrentUser(request);
	   if(user.getExamineStatus()==null){
		   		return "-1";
	   }else if(user.getExamineStatus().intValue()==UserExamineContant.NOT_THROUGH.intValue()){
			return "0";
	   }else if(user.getExamineStatus().intValue()==UserExamineContant.WAIT_EXAMINE.intValue()){
		   	return "2";
	   }else {
			return "1";
	   }
   }
   @RequestMapping(value="/getPersonAuthenStatus")
   @ResponseBody
   public String getPersonAuthenStatus(HttpServletRequest request){
	   return  personAuthenService.getPersonAuthenStatus(this.getCurrentUser(request).getId()) ?
			   FlagContant.SUCCESS_FLAG : FlagContant.FAILURE_FLAG;
   }
    
}
