package com.letvcloud.uc.infra.mybatis.mapper;

import com.letvcloud.uc.ms.model.UcCountry;
import com.letvcloud.uc.mapper.annotations.MyBatisDao;
import org.apache.ibatis.annotations.Param;

import java.util.List;
@MyBatisDao
public interface UcCountryMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    int countByExample(UcCountryExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    int deleteByExample(UcCountryExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    int insert(UcCountry record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    int insertSelective(UcCountry record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    List<UcCountry> selectByExample(UcCountryExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    UcCountry selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    int updateByExampleSelective(@Param("record") UcCountry record, @Param("example") UcCountryExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    int updateByExample(@Param("record") UcCountry record, @Param("example") UcCountryExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    int updateByPrimaryKeySelective(UcCountry record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    int updateByPrimaryKey(UcCountry record);
}