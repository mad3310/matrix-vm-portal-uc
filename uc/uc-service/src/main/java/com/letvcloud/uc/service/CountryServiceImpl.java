package com.letvcloud.uc.service;

import com.letvcloud.uc.mapper.CountryMapper;
import com.letvcloud.uc.po.Country;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhaoliang5 on 2015/6/26 9:33.
 */

@Service("countryService")
public class CountryServiceImpl implements CountryService {

    @Autowired
    private CountryMapper countryMapper;

    public List<Country> getCountryList() {
        return countryMapper.getCountryList();
    }
}
