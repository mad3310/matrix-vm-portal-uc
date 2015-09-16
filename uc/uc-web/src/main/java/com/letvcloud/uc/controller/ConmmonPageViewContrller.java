package com.letvcloud.uc.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ConmmonPageViewContrller {
	@RequestMapping("/showHeader")
	public String showHeader(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
        return "openheaderdiv";
	}
    @RequestMapping("/showHeaderUc")
    public String showHeaderUc(HttpServletRequest request,HttpServletResponse response,Integer tm) throws ServletException, IOException{
        if(tm!=null&&tm==1){
            return "openheaderdivTm";
        }else{
            return "openheaderdivTmn";
        }
    }
	@RequestMapping("/showFooter")
	public String showFooter(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
        return "footerall";
	}
}
