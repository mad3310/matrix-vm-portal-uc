package com.letv.uc.ms.bd;

import com.letv.uc.response.DataResponse;
import com.letv.uc.response.QueryDataResponse;
import com.letvcloud.saas.util.FastJsonUtil;
import com.letvcloud.uc.ms.model.UcUserInfo;
import com.letvcloud.uc.exception.UcUserInfoException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.net.URLEncoder;
import java.util.Map;

@Service
public class RestUcUserInfoServiceBD implements IUcUserInfoServiceBD {

    private static final Logger LOG = LoggerFactory.getLogger(RestUcUserInfoServiceBD.class);

    @Resource
    BDService bdService;

    /**
     * 按条件分页查询
     */
    @Override
    public String getUcUserInfoList(Map<String, String> params) throws UcUserInfoException {

        String result = null;
        try {
            String stime = params.get("starttime");
            if (StringUtils.hasLength(stime)) {
                params.put("starttime", URLEncoder.encode(stime));
            }
            String etime = params.get("endtime");
            if (StringUtils.hasLength(etime)) {
                params.put("endtime", URLEncoder.encode(etime));
            }
            QueryDataResponse queryDataResponse = bdService.findUcUserInfoPage(params);
            result = FastJsonUtil.obj2json(queryDataResponse);
        } catch (Exception e) {
            throw new UcUserInfoException("failed to getUcUserInfoList." + e);
        }
        LOG.debug("getUcUserInfoList result:" + result);
        return result;
    }

    @Override
    public String getUcUserInfoPQDTOById(String id) throws UcUserInfoException {

        String result = null;
        try {
            DataResponse dataResponse = bdService.getUcUserInfoPQDTO(id);
            result = FastJsonUtil.obj2json(dataResponse);
        } catch (Exception e) {
            throw new UcUserInfoException("failed to getUcUserInfoPQDTOById." + e);
        }
        LOG.debug("getUcUserInfoPQDTOById result:" + result);
        return result;
    }

    @Override
    public String getUcUserInfoCQDTOById(String id) throws UcUserInfoException {

        String result = null;
        try {
            DataResponse dataResponse = bdService.getUcUserInfoPQDTO(id);
            result = FastJsonUtil.obj2json(dataResponse);
        } catch (Exception e) {
            throw new UcUserInfoException("failed to getUcUserInfoCQDTOById." + e);
        }
        LOG.debug("getUcUserInfoCQDTOById result:" + result);
        return result;
    }

    /**
     * 更新实体
     */
    @Override
    public String putUcUserInfoById(String id, Map<String, String> params) throws UcUserInfoException {

        String result = null;
        try {
            UcUserInfo ucUserInfo = new UcUserInfo();
            //TODO
            DataResponse dataResponse = bdService.updateUcUserInfo(id, ucUserInfo);
            result = FastJsonUtil.obj2json(dataResponse);
        } catch (Exception e) {
            throw new UcUserInfoException("failed to putUcUserInfoById." + e);
        }
        LOG.debug("putUcUserInfoById result:" + result);
        return result;
    }

    /**
     * 更新资质
     */
    @Override
    public String putUcUserInfoCertificateById(String id, Map<String, String> params) throws UcUserInfoException {

        String result = null;
        try {
            UcUserInfo ucUserInfo = new UcUserInfo();
            //TODO
            DataResponse dataResponse = bdService.updateUcUserInfoCertificate(id, ucUserInfo);
            result = FastJsonUtil.obj2json(dataResponse);
        } catch (Exception e) {
            throw new UcUserInfoException("failed to putUcUserInfoCertificateById." + e);
        }
        LOG.debug("putUcUserInfoCertificateById result:" + result);
        return result;
    }

    /**
     * 更新云直播状态
     */
    @Override
    public String putUcUserInfoStateById(String id, Map<String, String> params) throws UcUserInfoException {

        String result = null;
        try {
            DataResponse dataResponse = bdService.updateUcUserInfoState(id, params);
            result = FastJsonUtil.obj2json(dataResponse);
        } catch (Exception e) {
            throw new UcUserInfoException("failed to putUcUserInfoStateById." + e);
        }
        LOG.debug("putUcUserInfoStateById result:" + result);
        return result;
    }

    /**
     * 按主键查询实体
     */
    @Override
    public String getUcUserInfoById(String id) throws UcUserInfoException {

        String result = null;
        try {
            DataResponse dataResponse = bdService.getUcUserInfo(id);
            result = FastJsonUtil.obj2json(dataResponse);

        } catch (Exception e) {
            throw new UcUserInfoException("failed to getUcUserInfoById." + e);
        }
        LOG.debug("getUcUserInfoById result:" + result);
        return result;
    }

    /**
     * 按主键查询用户信息和开通业务
     */
    @Override
    public String getUcUserInfoServiceStateById(String id) throws UcUserInfoException {

        String result = null;
        try {
            DataResponse dataResponse = bdService.getUcUserInfoServiceState(id);
            result = FastJsonUtil.obj2json(dataResponse);

        } catch (Exception e) {
            throw new UcUserInfoException("failed to getUcUserInfoById." + e);
        }
        LOG.debug("getUcUserInfoById result:" + result);
        return result;
    }

    /**
     * 按条件分页查询资质
     */
    @Override
    public String getUcUserInfoCertificateList(Map<String, String> params) throws UcUserInfoException {

        String result = null;
        try {
            String stime = params.get("starttime");
            if (StringUtils.hasLength(stime)) {
                params.put("starttime", URLEncoder.encode(stime));
            }
            String etime = params.get("endtime");
            if (StringUtils.hasLength(etime)) {
                params.put("endtime", URLEncoder.encode(etime));
            }
            QueryDataResponse queryDataResponse = bdService.findUcUserInfoCertificatePage(params);
            result = FastJsonUtil.obj2json(queryDataResponse);
        } catch (Exception e) {
            throw new UcUserInfoException("failed to getUcUserInfoCertificateList list." + e);
        }
        LOG.debug("getUcUserInfoCertificateList result:" + result);
        return result;
    }
}
