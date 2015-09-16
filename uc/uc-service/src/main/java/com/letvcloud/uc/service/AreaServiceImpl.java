package com.letvcloud.uc.service;

import com.letvcloud.uc.mapper.AreaMapper;
import com.letvcloud.uc.po.Area;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhaoliang5 on 2015/6/27.
 */

@Service("areaService")
public class AreaServiceImpl implements AreaService {
    @Autowired
    private AreaMapper areaMapper;


    public List<Area> getAreaByLevel(String level) {
        return areaMapper.getAreaByLevel(level);
    }

    public List<Area> getAreaByUpAreaCode(String upAreaCode) {

        return areaMapper.getAreaByUpAreaCode(upAreaCode);
    }

	public Area getSingleArea(String id) {
		return areaMapper.getSingleArea(id);
	}
}
