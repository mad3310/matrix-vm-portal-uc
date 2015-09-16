package com.letvcloud.uc.api.controller;

import ch.qos.logback.classic.Logger;
import com.letvcloud.bill.po.BillUserAmount;
import com.letvcloud.bill.service.BillServiceOpenService;
import com.letvcloud.bill.service.BillUserAmountService;
import com.letvcloud.bill.vo.BillServiceOpen;
import com.letvcloud.saas.controller.FastJsonViewSupport;
import com.letvcloud.saas.exception.BusinessException;
import com.letvcloud.saas.util.StringUtil;
import com.letvcloud.uc.api.po.UserVo;
import com.letvcloud.uc.api.vo.CustomerVO;
import com.letvcloud.uc.po.User;
import com.letvcloud.uc.service.UserService;
import com.letvcloud.uc.utils.CheckUtils;
import com.letvcloud.uc.utils.constant.UserTypeContant;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 */

@Controller
@RequestMapping("/customer")
public class CustomerController {

    private static org.slf4j.Logger logger = LoggerFactory.getLogger(CustomerController.class);

    @Autowired
    UserService userService;

    @Autowired
    BillUserAmountService billUserAmountService;

    @Autowired
    BillServiceOpenService billServiceOpenService;

    @RequestMapping(value = "checkEmail",method = RequestMethod.GET)
    @ResponseBody
    public Map<String,Object> checkEmail(@RequestParam("email")String email) throws BusinessException {
        Map<String,Object> result = new HashMap<String, Object>();

        if(StringUtil.isEmpty(email) || !CheckUtils.isEmail(email)){
            result.put("status","0");
            result.put("msg","邮箱格式不正确 "+ email);
            return result;
        }

        try{
            User user = userService.getUserByEmail(email);
            if(user != null){
                result.put("status","1");
                result.put("msg","邮箱已经被注册");
            }else{
                result.put("status","0");
            }
        }catch (Exception e){
            logger.error("", e);
            throw new BusinessException("-1",e);
        }
        return result;
    }

    @RequestMapping(value = "checkPhone",method = RequestMethod.GET)
    @ResponseBody
    public Map<String,Object> checkPhone(@RequestParam("mobile")String mobile) throws BusinessException {
        Map<String,Object> result = new HashMap<String, Object>();

        if(StringUtil.isEmpty(mobile) || !CheckUtils.isMobile(mobile)){
            result.put("status","0");
            result.put("msg","手机号格式不正确 "+ mobile);
            return result;
        }
        try{
            User user = userService.getUserByMobile(mobile,"86");
            if(user != null){
                result.put("status","1");
                result.put("msg","手机号已经被注册");
            }else{
                result.put("status","0");
            }
        }catch (Exception e){
            logger.error("", e);
            throw new BusinessException("-1",e);
        }
        return result;
    }

    @RequestMapping(value = "addCustomer",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> addCustomer(@RequestBody com.letvcloud.uc.vo.UserVo userVo) throws BusinessException {
        Map<String,Object> result = new HashMap<String, Object>();

        if(StringUtil.isEmpty(userVo.getEmail()) || !CheckUtils.isEmail(userVo.getEmail())){
            result.put("status","0");
            result.put("msg","邮箱为空或格式不正确 "+ userVo.getEmail());
            return result;
        }
        if(StringUtil.isEmpty(userVo.getMobile()) || !CheckUtils.isMobile(userVo.getMobile())){
            result.put("status","0");
            result.put("msg","手机号为空或格式不正确 "+ userVo.getMobile());
            return result;
        }

//        if(StringUtil.isEmpty(userVo.getPassword())){
//            result.put("status","0");
//            result.put("msg","密码不能为空 "+ userVo.getPassword());
//            return result;
//        }

        if(StringUtil.isEmpty(userVo.getContacts())){
            result.put("status","0");
            result.put("msg","联系人不能为空 "+ userVo.getContacts());
            return result;
        }

        String mobile = userVo.getMobile();
        if(userService.getUserByMobile(mobile,"86") != null){//如果手机号已经被注册过，就不能再注册了
            result.put("status","0");
            result.put("msg","该手机号已注册 " + mobile);
            return result;
        }
        String email = userVo.getEmail();
        if(userService.getUserByEmail(email) != null ){
            result.put("status","0");
            result.put("msg","该邮箱已注册 " + email);
            return result;
        }
        try{
            userVo.setUserType(UserTypeContant.ENTERPRISEINPROXY);
            userVo.setCountryCode("86");
            User user = userService.registerUser(userVo);
            if (user != null) {
                billUserAmountService.createUserAmount(user.getId());
                //serivceCode:100直播 101:点播
                //cdnfeeCode:001：流量，002:带宽
                billServiceOpenService.openServiceDefault(user.getId(),"101","001");
            }

            Map<String ,Object> data = new HashMap<String, Object>();
            data.put("user_id", user.getId() + "");
            data.put("user_unique", user.getUserUnique());
            data.put("user_key", user.getUserKey());

            result.put("status", "1");
            result.put("msg","success");
            result.put("data",data);

            return result;

        }catch (Exception e){//注册未成功
            e.printStackTrace();
            logger.error("", e);
            throw new BusinessException("-1",e);
        }


    }

    @RequestMapping(value = "editCustomer",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> editCustomer(@RequestBody CustomerVO vo) throws BusinessException {
        Map<String,Object> result = new HashMap<String, Object>();

        if(vo.getUserid() == null){
            result.put("status","0");
            result.put("msg","用户ID不能为空 "+ vo.getUserid());
            return result;
        }

        if(StringUtil.isEmpty(vo.getContacts())){
            result.put("status","0");
            result.put("msg","联系人不能为空 "+ vo.getContacts());
            return result;
        }

        if( vo.getMobile() != null ){
            if(!CheckUtils.isMobile(vo.getMobile())) {
                result.put("status","0");
                result.put("msg","手机号格式不正确 "+ vo.getMobile());
                return result;
            }

            User user = userService.getUserByMobile(vo.getMobile(),"86");
            if(user != null){
                if(user.getId() != vo.getUserid().longValue()) {
                    result.put("status","0");
                    result.put("msg","该手机号已其他用户绑定，不能修改 "+ vo.getMobile());
                    return result;
                }
            }
        }


        try{
            User user = userService.getUserById(vo.getUserid());
            if(user == null){
                result.put("status","0");
                result.put("msg", "没有找到该用户 " + vo.getUserid());
                return result;
            }

            com.letvcloud.uc.vo.UserVo userVo = new com.letvcloud.uc.vo.UserVo();
            if(vo.getEnterpriseName() != null){
                userVo.setEnterpriseName(vo.getEnterpriseName());
            }else if(user.getEnterpriseName() != null){
                userVo.setEnterpriseName(user.getEnterpriseName());
            }else{
                userVo.setEnterpriseName("");
            }
            if(vo.getContacts() != null){
                userVo.setContacts(vo.getContacts());
            }else{
                userVo.setContacts(user.getContacts());
            }
            if(vo.getSiteType() != null){
                userVo.setSiteType(vo.getSiteType());
            }else if(user.getSiteType() != null){
                userVo.setSiteType(user.getSiteType());
            }else{
                userVo.setSiteType(0);
            }
            if(vo.getSiteDomain() != null){
                userVo.setSiteDomain(vo.getSiteDomain());
            }else if(user.getSiteDomain() != null){
                userVo.setSiteDomain(user.getSiteDomain());
            }else{
                userVo.setSiteDomain("");
            }
            if(vo.getSiteName() != null){
                userVo.setSiteName(vo.getSiteName());
            }else if(user.getSiteName() != null){
                userVo.setSiteName(user.getSiteName());
            }else{
                userVo.setSiteName("");
            }

            if(vo.getMobile() != null){
                userVo.setMobile(vo.getMobile());
            }else if(user.getMobile() != null){
                userVo.setMobile(user.getMobile());
            }else{
                userVo.setMobile("");
            }

            userVo.setUserType(UserTypeContant.ENTERPRISEINPROXY);

            userService.modifyUserInfo(vo.getUserid(), userVo);

            result.put("status","1");
            result.put("msg","success");
            return result;

        }catch (Exception e){//修改未成功
            e.printStackTrace();
            logger.error("", e);
            throw new BusinessException("-1",e);
        }

    }

    @RequestMapping(value = "updatePwd" ,method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> updatePwd(@RequestBody CustomerVO vo) throws BusinessException {
        Map<String,Object> result = new HashMap<String, Object>();

        if(vo.getUserid() == null){
            result.put("status","0");
            result.put("msg","用户ID不能为空 "+ vo.getUserid());
            return result;
        }

        if(StringUtil.isEmpty(vo.getPassword())){
            result.put("status","0");
            result.put("msg","密码不能为空 "+ vo.getPassword());
            return result;
        }

        try{
            userService.modifyPassword(vo.getUserid(), vo.getPassword());

            result.put("status","1");
            result.put("msg","success");
            return result;

        }catch (Exception e){//修改未成功
            e.printStackTrace();
            logger.error("", e);
            throw new BusinessException("-1",e);
        }

    }

    @RequestMapping(value = "setPasswdEmail" ,method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> setPasswdEmail(@RequestBody CustomerVO vo) throws BusinessException {
        Map<String,Object> result = new HashMap<String, Object>();

        if(vo.getUserid() == null){
            result.put("status","0");
            result.put("msg","用户ID不能为空 "+ vo.getUserid());
            return result;
        }

        if(StringUtil.isEmpty(vo.getEmail())){
            result.put("status","0");
            result.put("msg","邮箱地址不能为空 "+ vo.getEmail());
            return result;
        }

        try{
            String msg = "http://uc.letvcloud.com/userView/accountManagerView.do";
//            sendMsgUtils.sendMessage(vo.getMobile(),msg);
            result.put("status","1");
            result.put("msg","success");
            return result;

        }catch (Exception e){//修改未成功
            e.printStackTrace();
            logger.error("", e);
            throw new BusinessException("-1",e);
        }

    }

    @RequestMapping(value = "delCustomer",method = RequestMethod.DELETE)
    @ResponseBody
    public Map<String,Object> delCustomer(@RequestParam("ids") String userIds) throws BusinessException {
        Map<String,Object> result = new HashMap<String, Object>();

        try{
//            int res = userService.deleteUsers(userIds);

            System.out.println(userIds);

            return result;

        }catch (Exception e){//修改未成功
            e.printStackTrace();
            logger.error("", e);
            throw new BusinessException("-1",e);
        }


    }


    /**
     * 启用
     * @return
     */
    @RequestMapping(value = "/startCustomer",method = RequestMethod.GET)
    @ResponseBody
    public Map startCustomer(@RequestParam("userid") Long id) throws BusinessException{
        Map<String,Object> result = new HashMap<String, Object>();
        if(id == null){
            result.put("status","0");
            result.put("msg","用户ID不能为空 ");
            return result;
        }
        try{
            userService.startCustomer(id);
            result.put("status","1");
            result.put("msg", "success");
            return result;

        }catch (Exception e){//修改未成功
            e.printStackTrace();
            logger.error("", e);
            throw new BusinessException("-1",e);
        }
    }

    /**
     * 停用
     * @return
     */
    @RequestMapping(value = "/stopCustomer",method = RequestMethod.GET)
    @ResponseBody
    public Map stopCustomer(@RequestParam("userid") Long id) throws BusinessException{
        Map<String,Object> result = new HashMap<String, Object>();
        if(id == null){
            result.put("status","0");
            result.put("msg","用户ID不能为空 ");
            return result;
        }
        try{
            userService.stopCustomer(id);
            result.put("status","1");
            result.put("msg", "success");
            return result;

        }catch (Exception e){//修改未成功
            e.printStackTrace();
            logger.error("", e);
            throw new BusinessException("-1",e);
        }
    }


    /**
     * 获取大于id的集合
     * @return
     */
    @RequestMapping(value = "/findGreaterIds",method = RequestMethod.GET)
    @ResponseBody
    public Map findGreaterIds(@RequestParam("id") Long id){
        Map<String,Object> result = new HashMap<String, Object>();
        List<Long> list = userService.findGreaterIds(id);
        result.put("list", list);
        return result;
    }
}
