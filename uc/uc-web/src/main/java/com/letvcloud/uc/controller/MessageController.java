package com.letvcloud.uc.controller;

import java.util.Date;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.letvcloud.saas.util.vo.PageInfo;
import com.letvcloud.uc.service.MessageService;
import com.letvcloud.uc.po.Message;
import com.letvcloud.uc.po.User;
import com.letvcloud.uc.utils.DateUtil;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
/**
 * Created by gaoyi3 on 2015/6/28.
 */
@Controller
@RequestMapping("/message")
public class MessageController extends BaseController{
    @Autowired
    private MessageService messageService;
    
	private  int pageIndex = 1;
    
    /**
     * 查询所有消息
     * @param request
     * @return
     */
    @RequestMapping("/allMessage.do")
    @ResponseBody
    public Map<String,Object> allMessage(HttpServletRequest request){
        return msgResult(request,"all");
    }
    
    /**
     * 查询未读消息
     */
    @RequestMapping("/unReadMessage.do")
    @ResponseBody
    public Map<String,Object> unReadMessage(HttpServletRequest request){
    	return msgResult(request,"unRead");
    }
    
    /**
     * 标记为已读/删除
     * @param request
     * @param msgId 消息Id数组
     * @param msgStatus 已读或删除状态
     * @param sysType 判断系统消息是否已在关系表中插入数据
     * @param type 操作页面(1：全部消息页面,2：未读消息页面)
     */
    @RequestMapping("/modifyMessage.do")
    @ResponseBody
    public Map<String,Object> modifyMessage(HttpServletRequest request,Long[] msgId,String msgStatus,String[] sysType,String type){
    	Map<String,Object> msgList = new HashMap<String,Object>();
    	User user = getCurrentUser(request);
    	if (user != null) {
    		Long userId = user.getId();
    		int num = messageService.batchModifyMessageInfo(userId, Arrays.asList(msgId),msgStatus,Arrays.asList(sysType));
    		if(num == -1){
    			msgList.put("sign", -1);
    		}else if(num !=0){
    			if(StringUtils.equals(type, "1")){
    				msgList = msgResult(request,"all");
    			}else {
    				msgList = msgResult(request,"unRead");
    			}
    		}else{
    			//logger.info("未标记成功");
    		}
		}
    	return msgList;
    }
    
    /**
     * 根据发送时间查询消息
     * @throws ParseException 
     */
    @RequestMapping("/searchMessage.do")
    @ResponseBody
    public Map<String,Object> searchMessage(HttpServletRequest request) throws ParseException{
    	if(StringUtils.isNotBlank(request.getParameter("pageIndex"))){
    		pageIndex = Integer.parseInt(request.getParameter("pageIndex"));
    	}else{
    		pageIndex = 1;
    	}
    	
    	Map<String,Object> msgList = new HashMap<String,Object>();
    	List<Message> unReadMessageList = new ArrayList<Message>();
    	String startTime = request.getParameter("startTime");
    	String endTime = request.getParameter("endTime");
    	String type = request.getParameter("type");
    	Date sd = DateUtil.formatDate(startTime);
    	Date ed = DateUtil.addMonth(endTime);
    	
    	User user = getCurrentUser(request);
    	if (user != null) {
    		Long userId = user.getId();
    		PageInfo pageInfo = new PageInfo();
    		int totalCount = 0;
    		pageInfo.setPage(pageIndex);
    		if(StringUtils.equals(type, "1")){
        		totalCount = messageService.countByTimeMsg(userId,"",sd,ed,user.getCreatedTime());
        		unReadMessageList = messageService.getMessageByTime(userId,sd,ed,pageInfo.getPage(),pageInfo.getRows(),user.getCreatedTime());
    		}else{
    			totalCount = messageService.countByTimeMsg(userId,"0",sd,ed,user.getCreatedTime());
    			unReadMessageList = messageService.getMessageByStatus(userId,"0",sd,ed,pageInfo.getPage(),pageInfo.getRows(),user.getCreatedTime());
    		}
    		msgList.put("message", unReadMessageList);
    		msgList.put("pageInfo", pageInfo);
    		msgList.put("totalCount", totalCount);
		}
        return msgList;
    }
    
    /**
     * 单条删除
     * @param request
     * @param msgId 消息Id
     */
    @RequestMapping("/delMessage.do")
    public String delMessage(HttpServletRequest request,Long msgId){
    	User user = getCurrentUser(request);
    	if (user != null) {
    		Long userId = user.getId();
    		int num = messageService.modifyMessageInfo(userId, msgId,"2","1");
    		if(num == 0){
    			//logger.info("删除失败");
    		}
		}
    	return "ucMsgCenter";
    }
    
    private Map<String,Object> msgResult(HttpServletRequest request,String method){
    	if(StringUtils.isNotBlank(request.getParameter("pageIndex"))){
    		pageIndex = Integer.parseInt(request.getParameter("pageIndex"));
    	}else{
    		pageIndex = 1;
    	}
    	
    	Map<String,Object> msgList = new HashMap<String,Object>();
    	
    	List<Message> list = new ArrayList<Message>();
    	User user = getCurrentUser(request);
    	if (user != null) {
    		Long userId = user.getId();
            PageInfo pageInfo = new PageInfo();
            pageInfo.setPage(pageIndex);
            int totalCount=0;
    		if(StringUtils.equals(method, "all")){
        		totalCount = messageService.countMsg(userId,user.getCreatedTime());
    			list = messageService.getMessageList(userId,pageInfo.getPage(),pageInfo.getRows(),user.getCreatedTime());
    		}else if(StringUtils.equals(method, "unRead")){
        		totalCount = messageService.countUnReadMsg(userId,user.getCreatedTime());
    			list = messageService.getUnReadMessageList(userId,pageInfo.getPage(),pageInfo.getRows(),user.getCreatedTime());
    		}
    		msgList.put("message", list);
    		msgList.put("pageInfo", pageInfo);
    		msgList.put("totalCount", totalCount);
    		
		}
        return msgList;
    }
    
    /**
     * 上一条/下一条
     * @param request
     * @param msgId 消息Id
     * @param type 操作页面(0：上一条,1：下一条)
     */
    @RequestMapping("/preNextMessage.do")
    @ResponseBody
    public Map<String,Object> preNextMsg(HttpServletRequest request,Long msgId,String type){
    	Map<String,Object> msgList = new HashMap<String,Object>();
		List<Message> list = null;
		Message message = new Message() ;
    	User user = getCurrentUser(request);
    	if (user != null) {
    		Long userId = user.getId();
    		if(StringUtils.equals(type, "1")){
    			list = messageService.nextMsg(userId, msgId,user.getCreatedTime());
    			if(list!=null&&list.size()>0){
    				message = list.get(0);
	    			if(list.size() < 2){
	    				msgList.put("next", 0);
	    			}else{
	    				msgList.put("next", 1);
	    			}
    			}
    		}else if(StringUtils.equals(type, "0")){
    			list = messageService.previousMsg(userId, msgId,user.getCreatedTime());
    			if(list!=null&&list.size()>0){
    				message = list.get(0);
	    			if(list.size() < 2){
	    				msgList.put("pre", 0);
	    			}else{
	    				msgList.put("pre", 1);
	    			}
	    				
    			}
    		}
    		if(message != null && StringUtils.isNotBlank(message.getMsgType())){
	    		if(StringUtils.equals(message.getMsgStatus(), "0")){//判断消息是未读，进而修改状态。
	    	    	int num = messageService.modifyMessageInfo(userId,message.getId(),"1",message.getMsgType());
    			}
    		}
    		msgList.put("message", message);
		}
    	return msgList;
    }
    
    @RequestMapping("/getCountUnReadMsg.do")
    @ResponseBody
    public String getCountUnReadMsg(HttpServletRequest request){
    	User user = getCurrentUser(request);
    	int count = messageService.countUnReadMsg(user.getId(),user.getCreatedTime());
    	return String.valueOf(count);
    }
    
}
