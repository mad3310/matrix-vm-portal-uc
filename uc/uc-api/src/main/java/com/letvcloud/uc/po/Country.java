package com.letvcloud.uc.po;

import java.io.Serializable;

/**
 * Created by zhaoliang5 on 2015/6/26 9:18.
 */
public class Country implements Serializable {
    private static final long serialVersionUID = -5042025477859438841L;

    private Long id;

    private String countryName;

    private String countryDomainName;

    private String countryAreaNum;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCountryName() {
        return countryName;
    }

    public void setCountryName(String countryName) {
        this.countryName = countryName;
    }

    public String getCountryDomainName() {
        return countryDomainName;
    }

    public void setCountryDomainName(String countryDomainName) {
        this.countryDomainName = countryDomainName;
    }

    public String getCountryAreaNum() {
        return countryAreaNum;
    }

    public void setCountryAreaNum(String countryAreaNum) {
        this.countryAreaNum = countryAreaNum;
    }

}
