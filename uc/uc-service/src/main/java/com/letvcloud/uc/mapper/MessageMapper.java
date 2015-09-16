package com.letvcloud.uc.mapper;

import com.letvcloud.uc.mapper.annotations.MyBatisDao;
import com.letvcloud.uc.po.Message;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Created by gaoyi3 on 2015/6/28.
 */
@MyBatisDao
public interface MessageMapper {
	/**根据用户id获取消息列表 Long userId,Date registerTime*/
    List<Message> getMessageListByPage(Map<String, Object> paramMap);
	/**根据用户id获取未读消息列表Long userId,Date registerTime*/
    List<Message> getUnReadMessageListByPage(Map<String, Object> paramMap);
    /**根据消息id查询消息详情 */
    Message getMessageById(Long msgId);
    /**根据创建时间来查询用户消息列表Long userId,Date startTime,Date endTime,Date registerTime*/
    List<Message> getMessageByTimePage(Map<String, Object> paramMap);
    /**根据消息状态、创建时间来查询用户消息列表Long userId,String msgStatus,Date startTime,Date endTime,Date registerTime*/
    List<Message> getMessageByStatusPage(Map<String, Object> paramMap);
    /**单条删除、修改*/
    int modifyMessageInfo(@Param("userId") Long userId, @Param("msgId") Long msgId, @Param("msgStatus") String msgStatus);
    /**批量删除、修改 */
    int batchModifyMessageInfo(@Param("userId") Long userId, @Param("msgId") List<Long> msgId, @Param("msgStatus") String msgStatus);
    /**单条插入*/
    int insertMessage(@Param("userId") Long userId, @Param("msgId") Long msgId, @Param("msgStatus") String msgStatus);
    /**批量插入(个人操作)*/
    int batchInsertMessage(@Param("userId") Long userId, @Param("msgId") List<Long> msgId, @Param("msgStatus") String msgStatus);
	/**根据用户id统计消息Long userId,Date registerTime*/
    int getCountTotalMsg(Map<String, Object> paramMap);
    /**统计未读消息条数Long userIdDate registerTime*/
    int getCountUnReadMsg(Map<String, Object> paramMap);
    /**根据条件统计消息条数Long userId,String msgStatus,Date startTime,Date endTime,Date registerTime*/
    int getCountByTimeMsg(Map<String, Object> paramMap);
    /**发布消息*/
    int pubMessage(Message message);
    /**批量插入(系统操作)*/
    int batchInsertRelations(@Param("userId") List<Long> userId, @Param("msgId") Long msgId, @Param("msgStatus") String msgStatus);
    
}