package com.letv.uc.ms.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/userManage")
public class UserManageViewController {
    
    private static final Logger LOG = LoggerFactory.getLogger(UserManageViewController.class);

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public ModelAndView show() {
        ModelAndView modelView = new ModelAndView("userManage/view");
        return modelView;
    }
}
