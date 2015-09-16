package com.letvcloud.uc.controller;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.letvcloud.uc.service.MessageService;
import com.letvcloud.uc.po.Message;
import com.letvcloud.uc.po.User;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * Created by gaoyi3 on 2015/6/28.
 */
@Controller
@RequestMapping("/messageView")
public class MessageViewController extends BaseController{
    @Autowired
    private MessageService messageService;
    
    @RequestMapping("/msgCenterView.do")
    public String msgCenterView(HttpServletRequest request){	
        return "ucMsgCenter";
    }
    
    /**
     * 消息详情
     */
    @RequestMapping("/msgCenterDetailView.do")
    public String msgCenterDetailView(HttpServletRequest request,Long msgId,String msgStatus){
		Message message = messageService.getMessageById(msgId);
		message.setMsgStatus(msgStatus);
		request.setAttribute("message",message);
		User user = getCurrentUser(request);
		
    	if (user != null) {
    		Long userId = user.getId();
    		if(StringUtils.equals(msgStatus, "0")){//判断消息是未读，进而修改状态。
	    		int num = messageService.modifyMessageInfo(userId,msgId,"1",message.getMsgType());
	    		if(num == 1){
	    			//logger.info("");
	    		}
    		}
    		
    		List<Message> nextMessage = messageService.nextMsg(userId, msgId,user.getCreatedTime());
    		if(nextMessage==null||nextMessage.size()==0){
    			request.setAttribute("next", 0);
    		}
    		
    		List<Message>  preMessage = messageService.previousMsg(userId,msgId,user.getCreatedTime());
    		if(preMessage==null||preMessage.size()==0){
    			request.setAttribute("pre", 0);
    		}
		}
        return "ucMsgCenterDetail";
    }
    
}
