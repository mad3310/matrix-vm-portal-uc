package com.letvcloud.uc.service;

import com.letvcloud.uc.po.Message;

import java.util.Date;
import java.util.List;

/**
 * Created by gaoyi3 on 2015/6/28.
 */
public interface MessageService {
	/**根据用户id获取消息列表
	 * userId 用户id
	 * registerTime 用户注册时间
	 * */
    List<Message> getMessageList(Long userId,Date registerTime);
	/**根据用户id获取未读消息列表
	 * userId 用户id
	 * registerTime 用户注册时间
	 * */
    List<Message> getUnReadMessageList(Long userId,Date registerTime);
	/**根据用户id获取消息列表
	 * userId 用户id
	 * pageIndex 第几页
	 * pageSize 每页条数
	 * registerTime 用户注册时间
	 * */
    List<Message> getMessageList(Long userId, int pageIndex, int pageSize,Date registerTime);
	/**根据用户id获取未读消息列表
	 * userId 用户id
	 * pageIndex 第几页
	 * pageSize 每页条数
	 * registerTime 用户注册时间
	 * */
    List<Message> getUnReadMessageList(Long userId, int pageIndex, int pageSize,Date registerTime);
    /**根据消息id查询消息详情
     * msgId 消息Id
     *  */
    Message getMessageById(Long msgId);
    /**根据创建时间来查询用户消息列表
     * userId 用户id
     * startTime 开始时间
     * endTime 结束时间
	 * pageIndex 第几页
	 * pageSize 每页条数
	 */
    List<Message> getMessageByTime(Long userId, Date startTime, Date endTime, int pageIndex, int pageSize,Date registerTime);
    /**根据消息状态、创建时间来查询用户消息列表
     * userId 用户id
     * msgStatus 消息状态
     * startTime 开始时间
     * endTime 结束时间
	 * pageIndex 第几页
	 * pageSize 每页条数
	 * registerTime 用户注册时间
     * */
    List<Message> getMessageByStatus(Long userId, String msgStatus, Date startTime, Date endTime, int pageIndex, int pageSize,Date registerTime);
    /**单个删除、修改
     * userId 用户id
     * msgId 消息Id
     * msgStatus 消息状态
     * type 关系表是否有值
     * */
    int modifyMessageInfo(Long userId, Long msgId, String msgStatus, String type);
    /**批量删除、修改 
     * userId 用户id
     * msgId 消息Id数组
     * msgStatus 消息状态
     * type 关系表是否有值数组
     * */
    int batchModifyMessageInfo(Long userId, List<Long> msgId, String msgStatus, List<String> type);
	/**根据用户id统计消息*/
    int countMsg(Long userId,Date registerTime);
    /**统计未读消息条数
     * userId 用户id
	 * registerTime 用户注册时间
     * */
    int countUnReadMsg(Long userId,Date registerTime);
    /**根据条件统计消息条数
     * userId 用户id
	 * registerTime 用户注册时间
     * */
    int countByTimeMsg(Long userId, String msgStatus, Date startTime, Date endTime,Date registerTime);
    
    /**发布消息
     * message 消息实体
     * userId 用户id数组
     * */
    int pubMessage(Message message, List<Long> userId);
    
	/**下一条消息记录
	 * userId 用户id
	 * registerTime 用户注册时间
	 * */
    List<Message> nextMsg(Long userId, Long msgId,Date registerTime);
	/**上一条消息记录
	 * userId 用户id
	 * registerTime 用户注册时间
	 * */
    List<Message> previousMsg(Long userId, Long msgId,Date registerTime);
    
}
