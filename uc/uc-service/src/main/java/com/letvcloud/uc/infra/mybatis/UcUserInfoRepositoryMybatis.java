package com.letvcloud.uc.infra.mybatis;

import com.letvcloud.uc.ms.repository.UcUserInfoRepository;
import com.letvcloud.uc.exception.UcUserInfoException;
import com.letvcloud.uc.infra.mybatis.mapper.UcUserInfoExample;
import com.letvcloud.uc.infra.mybatis.mapper.UcUserInfoMapper;
import com.letvcloud.uc.pojo.PaginationSupport;
import com.letvcloud.uc.ms.dto.UcUserInfoBriefDTO;
import com.letvcloud.uc.ms.dto.UcUserInfoCQDTO;
import com.letvcloud.uc.ms.dto.UcUserInfoCertificateDTO;
import com.letvcloud.uc.ms.dto.UcUserInfoPQDTO;
import com.letvcloud.uc.ms.model.UcUserInfo;
import com.letvcloud.uc.utils.DateUtil;
import com.letvcloud.uc.utils.PageUtil;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by ggmaster on 15/8/28.
 */
@Repository
public class UcUserInfoRepositoryMybatis implements UcUserInfoRepository {
    @Resource
    UcUserInfoMapper ucUserInfoMapper;

    /** 按条件分页查询 */
    @Override
    public PaginationSupport findUcUserInfoPage(Map<String, String> findMap) throws UcUserInfoException {

        try {
            List<UcUserInfoBriefDTO> listDto = new ArrayList<UcUserInfoBriefDTO>();
            // 分页参数封装
            int pageIndex = PageUtil.getStart(0, 0);// 起始页码
            int pageSize = PageUtil.getSize(0);// 每页条数
            try {
                pageIndex = Integer.parseInt(findMap.get("page"));
            } catch (Exception e) {
                pageIndex = PageUtil.getStart(0, 0);
            }
            try {
                pageSize = Integer.parseInt(findMap.get("rows"));
            } catch (Exception e) {
                pageSize = PageUtil.getSize(0);
            }
            int startIndex = PageUtil.getStart(pageIndex, pageSize);// 计算起始行
            UcUserInfoExample example = new UcUserInfoExample();
            assembleCondition(findMap, example, startIndex, pageSize);
            int totalCount = ucUserInfoMapper.countByExample(example);
            if (totalCount > 0) {
                // 查询数据
                List<UcUserInfo> items = ucUserInfoMapper.selectByExample(example);
                if (null != items && items.size() > 0) {
                    for (UcUserInfo user : items) {
                        UcUserInfoBriefDTO ucUserInfoBriefDTO = new UcUserInfoBriefDTO();
                        ucUserInfoBriefDTO.setUcUserInfo(user);
                        listDto.add(ucUserInfoBriefDTO);
                    }
                }
            }
            return new PaginationSupport(listDto, totalCount, pageSize, startIndex);
        } catch (Exception e) {
            throw new UcUserInfoException("failed to find UcUserInfoPage." + e);
        }
    }

    /** 按条件分页查询资质 */
    @Override

    public PaginationSupport findUcUserInfoCertificatePage(Map<String, String> findMap) throws UcUserInfoException {

        try {
            List<UcUserInfoCertificateDTO> listDto = new ArrayList<UcUserInfoCertificateDTO>();
            // 分页参数封装
            int pageIndex = PageUtil.getStart(0, 0);// 起始页码
            int pageSize = PageUtil.getSize(0);// 每页条数
            try {
                pageIndex = Integer.parseInt(findMap.get("page"));
            } catch (Exception e) {
                pageIndex = PageUtil.getStart(0, 0);
            }
            try {
                pageSize = Integer.parseInt(findMap.get("rows"));
            } catch (Exception e) {
                pageSize = PageUtil.getSize(0);
            }
            int startIndex = PageUtil.getStart(pageIndex, pageSize);// 计算起始行
            UcUserInfoExample example = new UcUserInfoExample();
            // 固定排序字段
            example.setOrderByClause("createdtime desc");
            assembleCondition(findMap, example, startIndex, pageSize);
            int totalCount = ucUserInfoMapper.countByExample(example);
            if (totalCount > 0) {
                // 查询数据
                List<UcUserInfo> items = ucUserInfoMapper.selectByExample(example);
                if (null != items && items.size() > 0) {
                    for (UcUserInfo user : items) {
                        listDto.add(new UcUserInfoCertificateDTO(user));
                    }
                }
            }
            return new PaginationSupport(listDto, totalCount, pageSize, startIndex);
        } catch (Exception e) {
            throw new UcUserInfoException("failed to find UcUserInfoCertificatePage." + e);
        }
    }

    /** 按条件查询列表 */
    @Override

    public List<UcUserInfo> findUcUserInfo(Map<String, String> findMap) throws UcUserInfoException {

        UcUserInfoExample example = new UcUserInfoExample();
        assembleCondition(findMap, example, null, null);
        return ucUserInfoMapper.selectByExample(example);
    }

    /** 查询个人资质信息 */
    @Override

    public UcUserInfoPQDTO getUcUserInfoPQDTO(Long id) throws UcUserInfoException {

        UcUserInfo user = this.getUcUserInfo(id);
        return new UcUserInfoPQDTO(user);
    }

    /** 查询企业资质信息 */
    @Override

    public UcUserInfoCQDTO getUcUserInfoCQDTO(Long id) throws UcUserInfoException {

        UcUserInfo user = this.getUcUserInfo(id);
        return new UcUserInfoCQDTO(user);
    }

    /** 按主键查询实体 */
    @Override

    public UcUserInfo getUcUserInfo(Long id) throws UcUserInfoException {

        UcUserInfo ucUser = ucUserInfoMapper.selectByPrimaryKey(id);
        if (null == ucUser) {
            throw new UcUserInfoException("UcUserInfo not found.");
        }
        return ucUser;
    }

    /** 更新实体 */
    @Override

    public boolean updateUcUserInfo(UcUserInfo ucUserInfo) throws UcUserInfoException {

        return ucUserInfoMapper.updateByPrimaryKeySelective(ucUserInfo) == 1;
    }


    /* 组合条件 */
    private void assembleCondition(Map<String, String> findMap, UcUserInfoExample example, Integer startIndex,
                                   Integer pageSize) {

        // 封装参数
        if (null != findMap) {
            UcUserInfoExample.Criteria criteria = example.createCriteria();
            String id = findMap.get("id");
            if (StringUtils.hasLength(id)) {
                criteria.andIdEqualTo(Long.parseLong(id));
            }
            String email = findMap.get("email");
            if (StringUtils.hasLength(email)) {
                criteria.andEmailEqualTo(email);
            }
            String contacts = findMap.get("contacts");
            if (StringUtils.hasLength(contacts)) {
                criteria.andContactsEqualTo(contacts);
            }
            String mobile = findMap.get("mobile");
            if (StringUtils.hasLength(mobile)) {
                criteria.andMobileEqualTo(mobile);
            }
            String enterprisename = findMap.get("enterprisename");
            if (StringUtils.hasLength(enterprisename)) {
                criteria.andEnterprisenameEqualTo(enterprisename);
            }
            String usertype = findMap.get("usertype");
            if (StringUtils.hasLength(usertype)) {
                criteria.andUsertypeEqualTo(Integer.valueOf(usertype));
            }
            String examinestatus = findMap.get("examinestatus");
            if (StringUtils.hasLength(examinestatus)) {
                criteria.andExaminestatusEqualTo(Byte.valueOf(examinestatus));
            }
            String userstatus = findMap.get("userstatus");
            if (StringUtils.hasLength(userstatus)) {
                criteria.andUserstatusEqualTo(Byte.valueOf(userstatus));
            }
            String starttime = findMap.get("starttime");
            String endtime = findMap.get("endtime");
            if (StringUtils.hasLength(starttime) && StringUtils.hasLength(endtime)) {
                criteria.andCreatedtimeBetween(DateUtil.parseDate(starttime, "yyyy-MM-dd HH:mm:ss"),
                        DateUtil.parseDate(endtime, "yyyy-MM-dd HH:mm:ss"));
            }

            // 分页
            if (null != startIndex && null != pageSize) {
                example.setLimitValue1(startIndex);
                example.setLimitValue2(pageSize);
            }
        }
    }

}
