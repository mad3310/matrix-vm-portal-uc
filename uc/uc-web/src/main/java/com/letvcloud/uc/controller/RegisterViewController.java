package com.letvcloud.uc.controller;

import com.letvcloud.uc.service.CountryService;
import com.letvcloud.uc.po.Country;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by zhaoliang5 on 2015/6/29.
 */

@Controller
@RequestMapping("/registerView")
public class RegisterViewController {


    @Autowired
    private CountryService countryService;

    @RequestMapping(value = "/registerUserView", method = RequestMethod.GET)
    public String registerUserView(HttpServletRequest request) {

        List<Country> countryList = countryService.getCountryList();

        request.setAttribute("countryList", countryList);
        return "/register";
    }
}
