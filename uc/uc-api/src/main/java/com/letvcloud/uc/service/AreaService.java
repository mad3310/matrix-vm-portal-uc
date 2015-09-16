package com.letvcloud.uc.service;

import com.letvcloud.uc.po.Area;

import java.util.List;

/**
 * Created by zhaoliang5 on 2015/6/27.
 */
public interface AreaService {
    List<Area> getAreaByLevel(String level);

    List<Area> getAreaByUpAreaCode(String upAreaCode);
    
    Area getSingleArea(String id);
}
