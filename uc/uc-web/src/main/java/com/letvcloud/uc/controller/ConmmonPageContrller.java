package com.letvcloud.uc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.letvcloud.bill.service.BillServiceOpenService;
import com.letvcloud.saas.common.po.CodeInfo;
import com.letvcloud.saas.common.service.CodeService;
import com.letvcloud.uc.po.User;
import com.letvcloud.uc.service.MessageService;


@Controller
@RequestMapping("/conmmonPage")
public class ConmmonPageContrller extends BaseController {
    @Autowired
    private MessageService messageService;
    @Autowired
    private BillServiceOpenService openService;
    @Autowired
    private CodeService codeService;

    @RequestMapping("/showHeaderParam")

    public void showHeader(HttpServletRequest request, HttpServletResponse response, String jsoncallback) throws IOException {
        User user = getCurrentUser(request);
        if (user == null) {
            iShowHeader(response, new JSONObject(), jsoncallback);
            return;
        }
        List<String> olist = openService.getUserService(user.getId());
        List<CodeInfo> allCodes = codeService.getAllCodes("00046");

        List<Object> pageList = buildMcode(olist, allCodes);
        JSONObject Jshow = new JSONObject();
        String email = user.getEmail();
        String messageCount = Integer.toString(messageService.countUnReadMsg(user.getId(),user.getCreatedTime()));
        Jshow.put("username", email);
        Jshow.put("userAvatar",user.getUserAvatar());
        Jshow.put("messageCount", messageCount);
        Jshow.put("managecontrol", pageList);
        iShowHeader(response, Jshow, jsoncallback);
    }

    private List<Object> buildMcode(List<String> olist, List<CodeInfo> allCodes) {
        List<Object> pageList = new ArrayList<Object>();
        for (int i = 0; i < olist.size(); i++) {
            for (int j = 0; j < allCodes.size(); j++) {
                if (allCodes.get(j).getCode1().equals(olist.get(i).toString())) {
                    Map<String, String> mcode = new HashMap<String, String>();
                    mcode.put("name", allCodes.get(j).getName());//name
                    mcode.put("url", allCodes.get(j).getReserve1());//URL
                    pageList.add(mcode);
                }
            }

        }
        return pageList;
    }

    private void iShowHeader(HttpServletResponse response, JSONObject Jshow, String jsoncallback) throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=utf-8");
        response.setHeader("Access-Control-Allow-Origin", "www.letvcloud.com");
        response.setHeader("Access-Control-Allow-Credentials", "true");
        PrintWriter out = response.getWriter();
        if (StringUtils.isNotEmpty(jsoncallback)) {
            out.print(jsoncallback + "(");
        }
        out.print(Jshow);
        if (StringUtils.isNotEmpty(jsoncallback)) {
            out.print(")");
        }
        out.flush();
        out.close();
    }

    @RequestMapping("/showFooterParam")
    public void showFooter(HttpServletRequest request, HttpServletResponse response) {


    }
}
