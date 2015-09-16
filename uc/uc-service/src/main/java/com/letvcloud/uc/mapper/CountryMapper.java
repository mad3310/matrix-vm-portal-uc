package com.letvcloud.uc.mapper;

import com.letvcloud.uc.mapper.annotations.MyBatisDao;
import com.letvcloud.uc.po.Country;

import java.util.List;

/**
 * Created by zhaoliang5 on 2015/6/26.
 */
@MyBatisDao
public interface CountryMapper {
    List<Country> getCountryList();
}
