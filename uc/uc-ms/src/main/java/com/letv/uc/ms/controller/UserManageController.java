package com.letv.uc.ms.controller;

import com.letv.uc.ms.bd.IUcUserInfoServiceBD;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping("/userManage")
public class UserManageController {
    
    private static final Logger LOG = LoggerFactory.getLogger(UserManageController.class);
    
    @Resource
    private IUcUserInfoServiceBD restUcUserInfoServiceBD;
    
    /** 按条件分页查询 */
    @RequestMapping(value= "/pageList", method = RequestMethod.GET)
    @ResponseBody
    public String getUcUserInfoList(@RequestParam Map<String, String> params) throws Exception {
    
        return restUcUserInfoServiceBD.getUcUserInfoList(params);
    }
    
    /** 按主键查询个人资质信息 */
    @RequestMapping(value = "/pq/{id}/{page}", method = RequestMethod.GET)
    public String getUcUserInfoPQDTOById(@PathVariable String id, @PathVariable String page, Model m) throws Exception {
    
        String json = restUcUserInfoServiceBD.getUcUserInfoPQDTOById(id);
        LOG.debug("json:" + json);
        m.addAttribute("response", json);
        return "/ucUserInfo/" + page;
    }
    
    /** 按主键查询实体 */
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String getUcUserInfoById(@PathVariable String id, Model m) throws Exception {
    
        String json = restUcUserInfoServiceBD.getUcUserInfoById(id);
        LOG.debug("json:" + json);
        m.addAttribute("response", json);
        return "/ucUserInfo/ucUserInfoEdit";
    }
    
    /** 按主键查询用户信息和开通业务 */
    @RequestMapping(value = "/serviceState/{id}", method = RequestMethod.GET)
    public String getUcUserInfoServiceStateById(@PathVariable String id, Model m) throws Exception {
    
        String json = restUcUserInfoServiceBD.getUcUserInfoServiceStateById(id);
        LOG.debug("json:" + json);
        m.addAttribute("response", json);
        return "/ucUserInfo/ucUserInfoEdit";
    }
    
    /** 按主键查询企业资质信息 */
    @RequestMapping(value = "/cq/{id}/{page}", method = RequestMethod.GET)
    public String getUcUserInfoCQDTOById(@PathVariable String id, @PathVariable String page, Model m) throws Exception {
    
        String json = restUcUserInfoServiceBD.getUcUserInfoCQDTOById(id);
        LOG.debug("json:" + json);
        m.addAttribute("response", json);
        return "/ucUserInfo/" + page;
    }
    
    /** 按主键查询云直播信息 */
    @RequestMapping(value = "/lq/{id}/{page}", method = RequestMethod.GET)
    public String getUcUserInfoLQDTOById(@PathVariable String id, @PathVariable String page, Model m) throws Exception {
    
        String json = restUcUserInfoServiceBD.getUcUserInfoById(id);
        LOG.debug("json:" + json);
        m.addAttribute("response", json);
        return "/ucUserInfo/" + page;
    }
    
    /** 更新实体 */
    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    @ResponseBody
    public String putUcUserInfoById(@PathVariable String id, @RequestParam Map<String, String> params) throws Exception {
    
        return restUcUserInfoServiceBD.putUcUserInfoById(id, params);
    }
    
    /** 更新资质 */
    @RequestMapping(value = "/certificate/{id}", method = RequestMethod.PUT)
    @ResponseBody
    public String putUcUserInfoCertificateById(@PathVariable String id, @RequestParam Map<String, String> params)
            throws Exception {
    
        return restUcUserInfoServiceBD.putUcUserInfoCertificateById(id, params);
    }
    
    /** 更新云直播状态 */
    @RequestMapping(value = "/live/{id}", method = RequestMethod.PUT)
    @ResponseBody
    public String putUcUserInfoStateById(@PathVariable String id, @RequestParam Map<String, String> params)
            throws Exception {
    
        return restUcUserInfoServiceBD.putUcUserInfoStateById(id, params);
    }
    
    /** 按条件分页查询资质列表 */
    @RequestMapping(value = "/certificate", method = RequestMethod.GET)
    @ResponseBody
    public String getUcUserInfoCertificateList(@RequestParam Map<String, String> params) throws Exception {
    
        return restUcUserInfoServiceBD.getUcUserInfoCertificateList(params);
    }
}
