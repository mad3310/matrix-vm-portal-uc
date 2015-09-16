package com.letvcloud.uc.utils;

import java.util.Date;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.letvcloud.saas.util.mail.MailAuthenticator;

/**
 * Created by zhaoliang5 on 2015/7/4.
 */
@Component
public class SendMailUtils {

    Logger logger = LoggerFactory.getLogger(SendMailUtils.class);
	@Value("#{configProperties['hostName']}")
	String hostName;
	@Value("#{configProperties['username']}")
	String username;
	@Value("#{configProperties['password']}")
	String password;
	@Value("#{configProperties['charset']}")
	String charset;
    @Value("#{configProperties['sendMailAddress']}")
    String sendMailAddress;

    public static void main(String[] args) {


        //sendHtmlMail("2710695210@qq.com", "激活成功", "1234");


    }

    public  void sendHtmlMail(String receiveEmail, String subject, String msg) {
        // 判断是否需要身份认证
        MailAuthenticator authenticator = null;
        Properties p = new Properties();
        p.put("mail.smtp.host", hostName);
        p.put("mail.smtp.port", 25);
        p.put("mail.smtp.auth", "true");
        // 如果需要身份认证，则创建一个密码验证器
            authenticator = new MailAuthenticator(username, password);
        // 根据邮件会话属性和密码验证器构造一个发送邮件的session
        Session sendMailSession = Session.getDefaultInstance(p, authenticator);
        try {
            // 根据session创建一个邮件消息
            Message mailMessage = new MimeMessage(sendMailSession);
            // 创建邮件发送者地址
            Address from = new InternetAddress(sendMailAddress);
            // 设置邮件消息的发送者
            mailMessage.setFrom(from);
            // 创建邮件的接收者地址，并设置到邮件消息中
            String[] tos = receiveEmail.split(",");
            Address[] addressess = new Address[tos.length];
            for (int temp = 0; temp < tos.length; temp++) {
                try {
                    Address to = new InternetAddress(tos[temp]);
                    addressess[temp] = to;
                } catch (AddressException e) {

                }
            }
            mailMessage.addRecipients(Message.RecipientType.TO, addressess);
            // 设置邮件消息的主题
            mailMessage.setSubject(subject);
            // 设置邮件消息发送的时间
            mailMessage.setSentDate(new Date());
            // MiniMultipart类是一个容器类，包含MimeBodyPart类型的对象
            Multipart mainPart = new MimeMultipart();
            // 创建一个包含HTML内容的MimeBodyPart
            BodyPart html = new MimeBodyPart();
            // 设置HTML内容
            html.setContent(msg, "text/html; charset=utf-8");
            mainPart.addBodyPart(html);
            // 将MiniMultipart对象设置为邮件内容
            mailMessage.setContent(mainPart);
            // 发送邮件
            Transport.send(mailMessage);
            logger.info("send mail success :receiveEmail:{},subject:{}",receiveEmail,subject);
        } catch (Exception ex) {
            logger.error("send mail success :receiveEmail:{},subject:{},errormessage:{}",receiveEmail,subject,ex.getMessage());
        }
    }
}
