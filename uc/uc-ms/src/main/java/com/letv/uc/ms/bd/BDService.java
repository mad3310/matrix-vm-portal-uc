package com.letv.uc.ms.bd;

import com.letv.uc.ms.facade.UcUserInfoServiceFacade;
import com.letv.uc.response.Constant;
import com.letv.uc.response.DataResponse;
import com.letv.uc.response.QueryDataResponse;
import com.letvcloud.uc.ms.dto.UcUserInfoCQDTO;
import com.letvcloud.uc.ms.dto.UcUserInfoPQDTO;
import com.letvcloud.uc.ms.dto.UcUserInfoServiceStateDTO;
import com.letvcloud.uc.ms.model.UcUserInfo;
import com.letvcloud.uc.ms.service.UcUserInfoService;
import com.letvcloud.uc.pojo.PaginationSupport;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Map;

/**
 * Created by ggmaster on 15/9/1.
 */
@Component
public class BDService {

    @Resource
    UcUserInfoServiceFacade userInfoServiceFacade;
    @Resource
    UcUserInfoService ucUserInfoService;

    /** 按条件分页查询 */
    public QueryDataResponse findUcUserInfoPage(@RequestParam Map<String, String> params) throws Exception {

        PaginationSupport ps = ucUserInfoService.findUcUserInfoPage(params);
        QueryDataResponse response = new QueryDataResponse();
        response.setRows(ps.getList());
        response.setStartIndex(ps.getStartIndex());
        response.setTotal(ps.getTotalCount());
        response.setPageSize(ps.getPageSize());
        response.setPageIndex(ps.getPageIndex());
        response.setMessage(Constant.RESULT_SUCCESS);
        response.setResult(Constant.RESULT_SUCCESS);
        return response;
    }

    /** 按主键查询个人资质信息 */
    public DataResponse getUcUserInfoPQDTO(@PathVariable String id) throws Exception {

        UcUserInfoPQDTO ucUserInfoPQDTO = ucUserInfoService.getUcUserInfoPQDTO(Long.parseLong(id));
        DataResponse response = new DataResponse();
        response.setData(ucUserInfoPQDTO);
        response.setMessage(Constant.RESULT_SUCCESS);
        response.setResult(Constant.RESULT_SUCCESS);
        return response;
    }

    /** 按主键查询实体 */
    public DataResponse getUcUserInfo(@PathVariable String id) throws Exception {

        UcUserInfo ucUserInfo = ucUserInfoService.getUcUserInfo(Long.parseLong(id));
        DataResponse response = new DataResponse();
        response.setData(ucUserInfo);
        response.setMessage(Constant.RESULT_SUCCESS);
        response.setResult(Constant.RESULT_SUCCESS);
        return response;
    }

    /** 按主键查询企业资质信息 */
    public DataResponse getUcUserInfoCQDTO(@PathVariable String id) throws Exception {

        UcUserInfoCQDTO ucUserInfoCQDTO = ucUserInfoService.getUcUserInfoCQDTO(Long.parseLong(id));
        DataResponse response = new DataResponse();
        response.setData(ucUserInfoCQDTO);
        response.setMessage(Constant.RESULT_SUCCESS);
        response.setResult(Constant.RESULT_SUCCESS);
        return response;
    }

    /** 按条件分页查询(资质) */
    public QueryDataResponse findUcUserInfoCertificatePage(@RequestParam Map<String, String> params) throws Exception {

        PaginationSupport ps = userInfoServiceFacade.findUcUserInfoCertificatePage(params);
        QueryDataResponse response = new QueryDataResponse();
        response.setRows(ps.getList());
        response.setStartIndex(ps.getStartIndex());
        response.setTotal(ps.getTotalCount());
        response.setPageSize(ps.getPageSize());
        response.setPageIndex(ps.getPageIndex());
        response.setMessage(Constant.RESULT_SUCCESS);
        response.setResult(Constant.RESULT_SUCCESS);
        return response;
    }

    /** 更新资质 */
    public DataResponse updateUcUserInfoCertificate(@PathVariable String id, @RequestBody UcUserInfo ucUserInfo)
            throws Exception {

        ucUserInfo.setId(Long.parseLong(id));
        DataResponse response = new DataResponse();
        if (userInfoServiceFacade.updateUcUserInfoCertificate(ucUserInfo)) {
            response.setMessage(Constant.RESULT_SUCCESS);
            response.setResult(Constant.RESULT_SUCCESS);
        } else {
            response.setResult(Constant.RESULT_FAILED);
            response.setMessage(Constant.RESULT_FAILED);
        }
        return response;
    }

    /** 更新云直播状态 */
    public DataResponse updateUcUserInfoState(@PathVariable String id, @RequestBody Map<String, String> params)
            throws Exception {

        params.put("id", id);
        DataResponse response = new DataResponse();
        if (userInfoServiceFacade.updateUcUserInfoState(params)) {
            response.setMessage(Constant.RESULT_SUCCESS);
            response.setResult(Constant.RESULT_SUCCESS);
        } else {
            response.setResult(Constant.RESULT_FAILED);
            response.setMessage(Constant.RESULT_FAILED);
        }
        return response;
    }

    /** 更新实体 */
    public DataResponse updateUcUserInfo(@PathVariable String id, @RequestBody UcUserInfo ucUserInfo) throws Exception {

        ucUserInfo.setId(Long.parseLong(id));
        DataResponse response = new DataResponse();
        if (ucUserInfoService.updateUcUserInfo(ucUserInfo)) {
            response.setMessage(Constant.RESULT_SUCCESS);
            response.setResult(Constant.RESULT_SUCCESS);
        } else {
            response.setResult(Constant.RESULT_FAILED);
            response.setMessage(Constant.RESULT_FAILED);
        }
        return response;
    }

    /** 按用户id查询用户信息和开通业务 */
    public DataResponse getUcUserInfoServiceState(@PathVariable String id) throws Exception {

        UcUserInfoServiceStateDTO ucUserInfoServiceStateDTO = userInfoServiceFacade.getUcUserInfoServiceStateDTO(Long
                .valueOf(id));
        DataResponse response = new DataResponse();
        response.setData(ucUserInfoServiceStateDTO);
        response.setMessage(Constant.RESULT_SUCCESS);
        response.setResult(Constant.RESULT_SUCCESS);
        return response;
    }
}
