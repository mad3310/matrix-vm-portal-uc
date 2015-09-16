package com.letvcloud.uc.service;

import com.letvcloud.uc.mapper.MessageMapper;
import com.letvcloud.uc.po.Message;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * Created by gaoyi3 on 2015/6/28.
 */
@Service("messageService")
public class MessageServiceImpl extends BaseServiceImpl implements MessageService {
	private static final long serialVersionUID = 1309508814696566943L;

	@Autowired
    private MessageMapper msgMapper;

	public List<Message> getMessageList(Long userId,int pageIndex,int pageSize,Date registerTime){
		Map<String,Object> paramMap=new HashMap<String,Object>();
		paramMap.put("userId",userId);
		paramMap.put("registerTime",registerTime);
		
		List<Message> list = new ArrayList<Message>();
		try {
			list = (List<Message>)getPageList(MessageMapper.class,"getMessageListByPage", paramMap, pageIndex,pageSize);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<Message> getMessageList(Long userId,Date registerTime){
		Map<String,Object> paramMap=new HashMap<String,Object>();
		paramMap.put("userId",userId);
		paramMap.put("registerTime",registerTime);
		
		return msgMapper.getMessageListByPage(paramMap);
	}
	
	public List<Message> getUnReadMessageList(Long userId,int pageIndex,int pageSize,Date registerTime){
		Map<String,Object> paramMap=new HashMap<String,Object>();
		paramMap.put("userId",userId);
		paramMap.put("registerTime",registerTime);
	
		List<Message> list = new ArrayList<Message>();
		try {
			list = (List<Message>)getPageList(MessageMapper.class,"getUnReadMessageListByPage", paramMap, pageIndex,pageSize);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public List<Message> getUnReadMessageList(Long userId,Date registerTime){
		Map<String,Object> paramMap=new HashMap<String,Object>();
		paramMap.put("userId",userId);
		paramMap.put("registerTime",registerTime);
	
		return msgMapper.getUnReadMessageListByPage(paramMap);
	}
	

	public Message getMessageById(Long msgId) {
		return msgMapper.getMessageById(msgId);
	}

	public List<Message> getMessageByTime(Long userId, Date startTime,Date endTime,int pageIndex,int pageSize,Date registerTime){
		Map<String,Object> paramMap=new HashMap<String,Object>();
		paramMap.put("userId",userId);
		paramMap.put("startTime",startTime);
		paramMap.put("endTime",endTime);
		paramMap.put("registerTime",registerTime);
		
		List<Message> list = new ArrayList<Message>();
		try {
			list = (List<Message>)getPageList(MessageMapper.class,"getMessageByTimePage", paramMap, pageIndex,pageSize);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Message> getMessageByStatus(Long userId, String msgStatus,
			Date startTime, Date endTime,int pageIndex,int pageSize,Date registerTime){
		Map<String,Object> paramMap=new HashMap<String,Object>();
		paramMap.put("userId",userId);
		paramMap.put("msgStatus",msgStatus);
		paramMap.put("startTime",startTime);
		paramMap.put("endTime",endTime);
		paramMap.put("registerTime",registerTime);
		
		List<Message> list = new ArrayList<Message>();
		try {
			list = (List<Message>)getPageList(MessageMapper.class,"getMessageByStatusPage", paramMap, pageIndex,pageSize);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public int modifyMessageInfo(Long userId, Long msgId, String msgStatus,String type) {
		int incount = 0, upcount = 0;
		if(StringUtils.equals(type, "0")){
			incount = msgMapper.insertMessage(userId,msgId,msgStatus);
		}else{
			upcount = msgMapper.modifyMessageInfo(userId,msgId,msgStatus);
		}
		return incount+upcount;
	}

	public int batchModifyMessageInfo(Long userId, List<Long> msgId, String msgStatus,List<String> type) {
		int num = 0;
		if(StringUtils.endsWith(msgStatus, "1")){
			for(int i = 0; i < type.size(); i++){
				String id = type.get(i);
				if(id.endsWith("1")){
					num++;
				}
			}
		}
		if(num < type.size()){
			List<Long> sysMsg = new ArrayList<Long>();
			if(type != null && type.size() > 0){
				for(int i = 0,count = 0;i < type.size();i++){
					if(StringUtils.equals(type.get(i),"00")){
						sysMsg.add(msgId.get(i-count));
						msgId.remove(i-count);
						count++;//记录删除次数
					}
				}
			}
			
			int incount = 0, upcount = 0;
			if(sysMsg.size() > 0){
				incount = msgMapper.batchInsertMessage(userId,sysMsg,msgStatus);
			}
			if(msgId.size() > 0){
				
				upcount = msgMapper.batchModifyMessageInfo(userId,msgId,msgStatus);
			}
			return incount+upcount;
		}
		return -1;
	}

	public int countUnReadMsg(Long userId,Date registerTime){
		Map<String,Object> paramMap=new HashMap<String,Object>();
		paramMap.put("userId",userId);
		paramMap.put("registerTime",registerTime);
	
		return msgMapper.getCountUnReadMsg(paramMap);
	}

	public int pubMessage(Message message,List<Long> userId) {
		int id = msgMapper.pubMessage(message);
		String msgType = message.getMsgType();
		if(id > 0){
			if(StringUtils.equals(msgType, "1")){//个人消息
				if(userId.size()>0){
					msgMapper.insertMessage(userId.get(0),message.getId(), "0");
				}
			}else if(StringUtils.equals(msgType, "2")){//批量消息
				msgMapper.batchInsertRelations(userId,message.getId(), "0");
			}
		}
		return id;
	}

	public int countMsg(Long userId,Date registerTime){
		Map<String,Object> paramMap=new HashMap<String,Object>();
		paramMap.put("userId",userId);
		paramMap.put("registerTime",registerTime);
	
		return msgMapper.getCountTotalMsg(paramMap);
	}
	
	public int countByTimeMsg(Long userId,String msgStatus,Date startTime,Date endTime,Date registerTime){
		Map<String,Object> paramMap=new HashMap<String,Object>();
		paramMap.put("userId",userId);
		paramMap.put("msgStatus",msgStatus);
		paramMap.put("startTime",startTime);
		paramMap.put("endTime",endTime);
		paramMap.put("registerTime",registerTime);
	
		return msgMapper.getCountByTimeMsg(paramMap);
	}

	public List<Message> nextMsg(Long userId, Long msgId,Date registerTime){
		Map<String,Object> paramMap=new HashMap<String,Object>();
		paramMap.put("userId",userId);
		paramMap.put("registerTime",registerTime);
		
		List<Message> list= msgMapper.getMessageListByPage(paramMap);
		List<Message> msgList = new ArrayList<Message>();
		if(list != null && list.size() > 0){
			for(int i = 0; i < list.size(); i++){
				long id = list.get(i).getId();
				if(id == msgId){
					int index = i + 1;
					if(index < list.size()){
						msgList.add(list.get(index));
					}
					if(index+1 < list.size()){
						msgList.add(list.get(index+1));
					}
				}
			}
		}
		return msgList;
	}

	public List<Message> previousMsg(Long userId, Long msgId,Date registerTime){
		Map<String,Object> paramMap=new HashMap<String,Object>();
		paramMap.put("userId",userId);
		paramMap.put("registerTime",registerTime);
	
		List<Message> list= msgMapper.getMessageListByPage(paramMap);
		List<Message> msgList = new ArrayList<Message>();
		if(list != null && list.size() > 0){
			for(int i = 0; i < list.size(); i++){
				long id = list.get(i).getId();
				if(id == msgId){
					int index = i - 1;
					if(index >= 0){
						msgList.add(list.get(index));
					}
					if(index-1 >= 0){
						msgList.add(list.get(index-1));
					}
				}
			}
		}
		return msgList;
	}
	
}