package com.letv.uc.ms.controller;

import com.letv.live.framework.controller.BaseController;
import com.letvcloud.uc.po.TranscodeServer;
import com.letvcloud.uc.vo.TranscodeServerCondition;
import com.letvcloud.saas.exception.BusinessException;
import com.letvcloud.saas.util.FastJsonUtil;
import com.letvcloud.saas.util.InputCheckUtil;
import com.letvcloud.saas.util.vo.PageInfo;
import com.letvcloud.saas.util.vo.PageResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
//@RequestMapping(value = "/uc/*")
public class TranscodeServerController extends BaseController {


    @RequestMapping(value = "/transcodeServer/open", method = RequestMethod.GET)
    public ModelAndView showTranscodeServerMng() {
        ModelAndView modelView = new ModelAndView("uc/transcodeServerMng");
        return modelView;
    }

    @RequestMapping(value = "transcodeServer/search", method = RequestMethod.GET)
    @ResponseBody
    public String getAllTranscodeServerList(TranscodeServerCondition transcodeServerCondition, PageInfo pageInfo) {
        PageResult pageResult = null;//transcodeServerService.searchTranscodeServers(transcodeServerCondition, pageInfo.getOffset(), pageInfo.getRows());
        return FastJsonUtil.obj2json(pageResult);

    }

    @RequestMapping(value = "transcodeServer/saveOrUpdate", method = RequestMethod.POST)
    @ResponseBody
    public void saveOrUpdate(TranscodeServer transcodeServer, HttpServletRequest request) throws BusinessException {
        //transcodeServerService.save(transcodeServer);
    }

    @RequestMapping(value = "transcodeServer/getByIp", method = RequestMethod.GET)
    @ResponseBody
    public String getTranscodeServer(String serverIp) {
        TranscodeServer result = null;//transcodeServerService.getByIp(serverIp);
        return FastJsonUtil.obj2json(result);
    }

    @RequestMapping(value = "transcodeServer/dele", method = RequestMethod.DELETE)
    @ResponseBody
    public void deleTranscodeServer(String serverIp) {
        InputCheckUtil.checkNotEmpty(serverIp, "serverIp");
        //transcodeServerService.delete(serverIp);
    }

}
