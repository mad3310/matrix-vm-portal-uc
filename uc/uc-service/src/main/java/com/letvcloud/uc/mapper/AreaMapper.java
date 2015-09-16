package com.letvcloud.uc.mapper;

import com.letvcloud.uc.mapper.annotations.MyBatisDao;
import com.letvcloud.uc.po.Area;

import java.util.List;

/**
 * Created by zhaoliang5 on 2015/6/27.
 */
@MyBatisDao
public interface AreaMapper {
    List<Area> getAreaByLevel(String level);


    List<Area> getAreaByUpAreaCode(String upAreaCode);
    
    Area getSingleArea(String id);

}
