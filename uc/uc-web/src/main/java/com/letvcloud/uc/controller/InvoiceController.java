package com.letvcloud.uc.controller;

import com.letvcloud.bill.po.BillUserInvoice;
import com.letvcloud.bill.service.BillUserInvoiceService;
import com.letvcloud.saas.common.po.CodeInfo;
import com.letvcloud.saas.common.service.CodeService;
import com.letvcloud.saas.util.DateTimeUtil;
import com.letvcloud.saas.util.FastJsonUtil;
import com.letvcloud.uc.po.Area;
import com.letvcloud.uc.po.Invoice;
import com.letvcloud.uc.po.User;
import com.letvcloud.uc.service.AreaService;
import com.letvcloud.uc.service.EnterpriseAuthenService;
import com.letvcloud.uc.service.InvoiceService;
import com.letvcloud.uc.utils.constant.UserTypeContant;
import com.letvcloud.uc.vo.BillMonthBillingVo;
import com.letvcloud.uc.vo.BillUserBillingVo;
import com.letvcloud.uc.vo.InvoiceVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 发票设置
 * Created by zhaoliang5 on 2015/6/29.
 */
@Controller
@RequestMapping("uc/invoice/")
public class InvoiceController extends BaseController {

    //获取服务编码
    private static final String SERVERCODE = "00046";
    private static final String AREALEVEL_ONE = "1";// 省市

    private static Logger logger = LoggerFactory.getLogger(InvoiceController.class);
    @Autowired
    private AreaService areaService;

    @Autowired
    private InvoiceService invoiceService;

    @Autowired
    private BillUserInvoiceService billUserInvoiceService;

    @Autowired
    private EnterpriseAuthenService enterpriseAuthenService;

    @Autowired
    private CodeService codeService;
    /**
     * 发票设置保存
     *
     * @param invoiceVo
     * @param request
     * @return
     */
    @RequestMapping(value = "saveOrUpdateInvoice",  method = RequestMethod.POST)
    public String saveOrUpdateInvoice(InvoiceVo invoiceVo, HttpServletRequest request) {
        User user = getCurrentUser(request);
        invoiceVo.setUserId(user.getId());
        invoiceService.saveOrUpdateInvoice(invoiceVo, user.getId());
        //setAreaName(invoiceVo, invoiceVo);
        return "redirect:getInvoiceSetingView.do";
    }

    /**
     * 获取发票设置页面信息，左侧菜单点击
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/getInvoiceSetingView")
    public String getInvoiceSetingView(HttpServletRequest request) {
        // 获取用户信息
        User user = getCurrentUser(request);
        // 获取用户设置的发票信息
        Invoice invoice = invoiceService.getInvoiceByUserId(user.getId());
        if(invoice == null) {
            invoice = new Invoice();
        }
        boolean isCompany = false;
        //boolean isPass = true;// true 通过， FALSE 未通过
        Integer passState = 0;// 如果是公司，则标示公司的资质审核状态
        // 用户为公司类型
        if(user.getUserType() != null && (user.getUserType() == UserTypeContant.ENTERPRISE ||
                user.getUserType() == UserTypeContant.BIGENTERPRISE)) {
            isCompany = true;
            // 企业用户是否企业资质认证通过  0 未通过 ，1 通过 ，2 等待审核， NULL 用户未上传资质信息
            passState = enterpriseAuthenService.getEnterproseAuthenStatusInfo(user.getId());
            invoice.setInvoiceTitle(user.getEnterpriseName());
        } else {
            invoice.setInvoiceTitle("个人");
        }
        // 设置地区相关数据
        Map<String, Object> areaMap = setAreaData(invoice);
        request.setAttribute("areaLevel1List", areaMap.get("areaLevel1List"));
        request.setAttribute("areaLevel2List", areaMap.get("areaLevel2List"));
        request.setAttribute("areaLevel3List", areaMap.get("areaLevel3List"));
        request.setAttribute("invoice", invoice);
        request.setAttribute("currentUser", user);
        request.setAttribute("isCompany", isCompany);
        request.setAttribute("passState", passState);
        return "ucInvoiceSeting";
    }

    /**
     * 设置地区相关数据
     */
    private Map<String, Object> setAreaData(Invoice invoice) {
        Map<String, Object> result = new HashMap<String, Object>();
        // 获取地区中的一级信息
        List<Area> areaLevel1List = areaService.getAreaByLevel(AREALEVEL_ONE);
        result.put("areaLevel1List", areaLevel1List);
        if(invoice != null) {
            String areaLevel1 = invoice.getAreaLevel1();
            String areaLevel2 = invoice.getAreaLevel2();
            // 地区中 二级信息
            List<Area> areaLevel2List = areaService.getAreaByUpAreaCode(areaLevel1);
            // 地区中 三级信息
            List<Area> areaLevel3List = areaService.getAreaByUpAreaCode(areaLevel2);
            result.put("areaLevel2List", areaLevel2List);
            result.put("areaLevel3List", areaLevel3List);
        }
        return result;
    }


    /**
     * 索要发票，先进行信息确认
     */
    @RequestMapping("/getInvoiceConfirm")
    @ResponseBody
    public String getInvoiceConfirm(HttpServletRequest request, String billMonthMoney,
                                    String activeMonth, String serviceCode) {
        Map<String, Object> result = new HashMap<String, Object>();
        // 获取用户信息
        User user = getCurrentUser(request);
        // 如果是企业用户，则isPass 为true，如果为普通用户，则isPass 也为true
        // boolean isPass = true;
        Integer passState = 0;// 如果是公司，则标示公司的资质审核状态
        boolean isCompany = false;

        Invoice invoice = invoiceService.getInvoiceByUserId(user.getId());
        // 获取用户设置的发票信息
        InvoiceVo invoiceVo = this.invoiceToVo(invoice, billMonthMoney, activeMonth, serviceCode);
        // 用户为公司类型
        if(user.getUserType() != null && (user.getUserType() == UserTypeContant.ENTERPRISE ||
                user.getUserType() == UserTypeContant.BIGENTERPRISE)) {
            isCompany = true;
            // 企业用户是否企业资质认证通过  0 未通过 ，1 通过 ，2 等待审核， NULL 用户未上传资质信息
            passState = enterpriseAuthenService.getEnterproseAuthenStatusInfo(user.getId());
            invoiceVo.setInvoiceTitle(user.getEnterpriseName());
            invoiceVo.setIssueType(user.getUserType());
        } else {
            invoiceVo.setInvoiceTitle("个人");
            invoiceVo.setIssueType(user.getUserType());
        }
        // 没有进行发票设置，请先设置发票设置
        if(invoice == null) {
            result.put("isSettingInvoice", false);
        } else {
            result.put("isSettingInvoice", true);// TODO 应该改成 true
        }
        // 设置地区相关数据
        Map<String, Object> areaMap = setAreaData(invoice);
        result.putAll(areaMap);
        result.put("invoiceVo", invoiceVo);
        result.put("passState", passState);
        result.put("isCompany", isCompany);
        return FastJsonUtil.obj2json(result);
    }

    /**
     * 索要账单发票
     */
    @RequestMapping(value = "/askBillInvoice", method = RequestMethod.POST)
    @ResponseBody
    public String askBillInvoice(HttpServletRequest request, InvoiceVo invoiceVo, String orderId,
                                 String activeMonth, String billingId, String billingMoney) {
        // 获取用户信息
        User user = getCurrentUser(request);
        Invoice invoice = this.invoiceService.getInvoiceByUserId(user.getId());

        BillUserInvoice billUserInvoice = new BillUserInvoice();
        billUserInvoice.setAddress(invoiceVo.getAddress());
        billUserInvoice.setAreaLevel1(invoiceVo.getAreaLevel1());
        billUserInvoice.setAreaLevel2(invoiceVo.getAreaLevel2());
        billUserInvoice.setAreaLevel3(invoiceVo.getAreaLevel3());
        billUserInvoice.setEmail(user.getEmail());
        billUserInvoice.setBillingMonth(activeMonth);
        billUserInvoice.setCreatedTime(DateTimeUtil.getCurrentDate());
        billUserInvoice.setInvoiceTitle(invoiceVo.getInvoiceTitle());
        billUserInvoice.setInvoiceType(invoice == null ? 1 : invoice.getInvoiceType());
        billUserInvoice.setMobile(invoiceVo.getMobile());
        billUserInvoice.setOrderId(Long.valueOf(orderId));
        billUserInvoice.setZipCode(invoiceVo.getZipCode());
        billUserInvoice.setReceiveName(invoiceVo.getReceiveName());
        // 开具类型 与用户类型一致
        billUserInvoice.setIssueType(invoice == null? user.getUserType() : invoice.getIssueType());
        billUserInvoice.setBillingMoney(billingMoney);
        billUserInvoice.setBillingId(billingId);
        billUserInvoice.setBillingContents(invoiceVo.getInvoiceContent());
        billUserInvoice.setUserId(user.getId());

        billUserInvoiceService.createUserInvoice(billUserInvoice);
        invoiceVo.setUserId(user.getId());
        invoiceVo.setIssueType(invoice == null? user.getUserType() : invoice.getIssueType());
        invoiceVo.setInvoiceType(invoice == null ? 1 : invoice.getInvoiceType());
        this.invoiceService.saveOrUpdateInvoice(invoiceVo, user.getId());
        return "{\"status\":\"200\"}";
    }


    private InvoiceVo setAreaName(Invoice invoice, InvoiceVo invoiceVo) {
        if(invoice != null && invoiceVo != null) {
            BeanUtils.copyProperties(invoice, invoiceVo);
            //地址 一级
            Area area1 = areaService.getSingleArea(invoice.getAreaLevel1());
            invoiceVo.setAreaLevel1Name(area1.getAreaName());
            //地址 二级
            Area area2 = areaService.getSingleArea(invoice.getAreaLevel2());
            invoiceVo.setAreaLevel2Name(area2.getAreaName());
            //地址 三级
            Area area3 = areaService.getSingleArea(invoice.getAreaLevel3());
            invoiceVo.setAreaLevel3Name(area3.getAreaName());
        }
        return invoiceVo;
    }

    private InvoiceVo invoiceToVo(Invoice invoice, String billMonthMoney, String activeMonth, String serviceCode) {
        InvoiceVo invoiceVo = new InvoiceVo();
        invoiceVo = setAreaName(invoice, invoiceVo);
        invoiceVo.setIssueTypeName("增值税普通发票");
        // 发票金额
        invoiceVo.setInvoiceMoney(Double.valueOf(billMonthMoney));
        invoiceVo.setInvoiceContent("技术服务费");
        int year = Integer.valueOf(activeMonth.substring(0, 4));
        int month = Integer.valueOf(activeMonth.substring(4));

        String startTime = year + "." + activeMonth.substring(4) + "." + "01";
        String endTime = getEndTime(year, month);
        invoiceVo.setBillStartTime(startTime);
        invoiceVo.setBillEndTime(endTime);
        invoiceVo.setBillTypeName("云直播按流量计费（假值）");
        // 产品名称
        List<CodeInfo> allCodes = codeService.getAllCodes(SERVERCODE);
        for (CodeInfo codeInfo : allCodes) {
            if (codeInfo.getCode1().equals(serviceCode)) {
                invoiceVo.setServiceCodeName(codeInfo.getName());
            }
        }
        // 产品名称码
        invoiceVo.setServiceCode(serviceCode);
        invoiceVo.setBillTypeName("按流量");
        return invoiceVo;
    }

    /**
     * 获取一个月的最后一天
     * @param year
     * @param month
     * @return
     */
    private String getEndTime(int year, int month) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.YEAR, year);
        calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH) + 1);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        calendar.add(Calendar.DAY_OF_MONTH, -1);
        return "" + calendar.get(Calendar.YEAR) + "."
                + calendar.get(Calendar.MONTH) + "."
                + calendar.get(Calendar.DAY_OF_MONTH);
    }
}
