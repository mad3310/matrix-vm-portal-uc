package com.letvcloud.uc.controller;

import com.letvcloud.uc.service.AreaService;
import com.letvcloud.uc.po.Area;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by zhaoliang5 on 2015/6/29.
 */

@Controller
@RequestMapping("/area")
public class AreaController {

    @Autowired
    private AreaService areaService;


    @RequestMapping("/getArea")
    @ResponseBody
    public List<Area> getArea(String upAreaCode) {
        List<Area> areaList = areaService.getAreaByUpAreaCode(upAreaCode);
        return areaList;
    }

    @RequestMapping("/getAreaByLevel")
    @ResponseBody
    public List<Area> getAreaByLevel(String level) {
        return areaService.getAreaByLevel(level);
    }

}