package com.letv.uc.ms.facade.impl;

import com.letv.uc.ms.facade.UcUserInfoServiceFacade;
import com.letvcloud.bill.vo.BillServiceOpen;
import com.letvcloud.uc.ms.dto.UcUserInfoCertificateDTO;
import com.letvcloud.uc.ms.dto.UcUserInfoServiceStateDTO;
import com.letvcloud.uc.ms.model.UcUserInfo;
import com.letvcloud.uc.ms.service.UcUserInfoService;
import com.letvcloud.uc.exception.UcUserInfoException;
import com.letvcloud.uc.exception.UcUserInfoServiceSFException;
import com.letvcloud.uc.exception.UcUserInfoServiceTOAException;
import com.letvcloud.uc.pojo.PaginationSupport;
import com.letvcloud.uc.utils.XMemcacheUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by ggmaster on 15/9/1.
 */
@Component
public class UcUserInfoServiceFacadeImpl implements UcUserInfoServiceFacade {

    private static final Logger LOG = LoggerFactory.getLogger(UcUserInfoServiceFacadeImpl.class);
    @Resource
    UcUserInfoService ucUserInfoService;
    @Resource
    com.letvcloud.bill.service.BillServiceOpenService billServiceOpenService;
    @Resource
    com.letvcloud.uc.service.MessageBusService messageBusService;

    /**
     * 更新业务状态(临时)
     */
    @Override
    public boolean updateUcUserInfoState(Map<String, String> map) throws UcUserInfoException {
        billServiceOpenService.changeServiceState(Long.parseLong(map.get("id")), map.get("servicecode"),
                Integer.parseInt(map.get("state")));
        return true;
    }

    @Override
    public UcUserInfoServiceStateDTO getUcUserInfoServiceStateDTO(Long id) throws UcUserInfoServiceTOAException,
            UcUserInfoException {

        UcUserInfo ucUserInfo = ucUserInfoService.getUcUserInfo(id);
        List<BillServiceOpen> billServiceOpenList = billServiceOpenService.getServiceByUserId(id);
        UcUserInfoServiceStateDTO ucUserInfoServiceStateDTO = new UcUserInfoServiceStateDTO(ucUserInfo,
                billServiceOpenList);
        return ucUserInfoServiceStateDTO;
    }

    /**
     * 更新资质
     */
    @Override
    public boolean updateUcUserInfoCertificate(UcUserInfo ucUserInfo) throws UcUserInfoException,
            UcUserInfoServiceSFException {

        boolean flag = false;
        if (ucUserInfoService.updateUcUserInfo(ucUserInfo)) {
            try {
                // 删除缓存
                XMemcacheUtil.deleteToCache(getUserIdKey(ucUserInfo.getId()));
                XMemcacheUtil.deleteToCache(getUserEmailKey(ucUserInfo.getEmail()));
                XMemcacheUtil.deleteToCache(getUserUUKey(ucUserInfo.getUserunique()));
                // 调用dubble发通知
                messageBusService.sendQualificationMsgBus(ucUserInfo.getExaminestatus() == 1, ucUserInfo.getId());
            } catch (Exception e) {
                throw new UcUserInfoServiceSFException("updateUcUserInfoCertificate err:" + e.getMessage());
            }
        }
        flag = true;
        return flag;
    }

    /**
     * 按条件分页查询资质
     */
    @Override
    public PaginationSupport findUcUserInfoCertificatePage(Map<String, String> findMap) throws UcUserInfoException {

        try {
            PaginationSupport ps = ucUserInfoService.findUcUserInfoCertificatePage(findMap);
            List<UcUserInfoCertificateDTO> listDto = ps.getList();

            // 临时获取云直播状态
            Long id = null;
            for (UcUserInfoCertificateDTO ucUserInfoCertificateDTO : listDto) {
                try {
                    id = ucUserInfoCertificateDTO.getId();
                    com.letvcloud.bill.vo.BillServiceOpen bo = billServiceOpenService.getServiceByCode(id, "100");
                    ucUserInfoCertificateDTO.setState(bo.getState());
                } catch (Exception e) {
                    LOG.error("failed to getServiceByCode:" + id);
                }
            }
            return ps;
        } catch (Exception e) {
            throw new UcUserInfoException("failed to find findUcUserInfoCertificatePage." + e);
        }
    }

    private String getUserIdKey(Long id) {

        return "uc:userId:" + id;
    }

    private String getUserEmailKey(String email) {

        return "uc:userEmail:" + email;
    }

    private String getUserUUKey(String unique) {

        return "uc:userUu:" + unique;
    }
}
