package com.letvcloud.uc.controller;

import com.google.common.collect.Lists;
import com.letvcloud.bill.po.BillUserBilling;
import com.letvcloud.bill.service.BillUserServiceBilling;
import com.letvcloud.bill.vo.BillMonthBilling;
import com.letvcloud.bill.vo.BillMonthDetailBilling;
import com.letvcloud.bill.vo.BillMonthExport;
import com.letvcloud.saas.common.po.CodeInfo;
import com.letvcloud.saas.common.service.CodeService;
import com.letvcloud.saas.util.DateTimeUtil;
import com.letvcloud.saas.util.ExportExcel;
import com.letvcloud.uc.po.User;
import com.letvcloud.uc.vo.BillMonthBillingVo;
import com.letvcloud.uc.vo.BillMonthDetailBillingVo;
import com.letvcloud.uc.vo.BillUserBillingVo;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;

/**
 * Created by zhaoliang5 on 2015/6/29.
 */
@Controller
@RequestMapping("uc/bill/")
public class BillController extends BaseController {

    private static Logger logger = LoggerFactory.getLogger(BillController.class);

    //获取服务编码
    private static final String SERVERCODE = "00046";
    // 功能点编码
    private static final String FEATHERCODE = "00047";

    @Autowired
    private BillUserServiceBilling billUserServiceBillingImpl;

    @Autowired
    private CodeService codeService;

    /**
     * 获得账单详情
     * @param orderId
     * @param billingMonth 当前活动月份
     * @param request
     * @return
     */
    @RequestMapping(value = "getBillInfoView")
    public String getBillInfoView(String orderId, String billingId, String billingMonth, HttpServletRequest request) {
        User currentUser = getCurrentUser(request);
        // 月账单总体情况
        BillMonthBillingVo billMonthBillingVo = queryBillUserBIllingVo(currentUser.getId(), billingMonth);
        // 获取具体制定的月账单详情
        BillUserBillingVo billUserBillingVo = billUserBillingVo(billMonthBillingVo, orderId, billingId);

        // 功能点 code
        List<CodeInfo> featherCodes = codeService.getAllCodes(FEATHERCODE);
        List<BillMonthDetailBilling> billMonthDetailBillings = billUserServiceBillingImpl.queryUserServiceDetailBilling(orderId, billingMonth);

        List<BillMonthDetailBillingVo> billMonthDetailBillingVos = Lists.newArrayList();
        for (BillMonthDetailBilling billMonthDetailBilling : billMonthDetailBillings) {
            BillMonthDetailBillingVo billMonthDetailBillingVo = new BillMonthDetailBillingVo();
            BeanUtils.copyProperties(billMonthDetailBilling, billMonthDetailBillingVo);
            String featherCode = billMonthDetailBillingVo.getFeatherCode();
            for (CodeInfo codeInfo : featherCodes) {
                if (featherCode.equals(codeInfo.getCode1() + codeInfo.getCode2())) {
                    billMonthDetailBillingVo.setFeatherCodeDesc(codeInfo.getName());
                }
            }
            BigDecimal discount = new BigDecimal(billMonthDetailBillingVo.getDiscount());
            BigDecimal price = new BigDecimal(billMonthDetailBillingVo.getPrice());
            // 计算折扣后的单价
            String a = String.valueOf(discount.multiply(price));
            billMonthDetailBillingVo.setDiscountPrice(String.valueOf(discount.multiply(price)));
            billMonthDetailBillingVos.add(billMonthDetailBillingVo);
        }
        request.setAttribute("billUserBillingVo", billUserBillingVo);
        request.setAttribute("billMonthBillingVo", billMonthBillingVo);
        // 账单明细
        request.setAttribute("billMonthDetailBillingVos", billMonthDetailBillingVos);
        request.setAttribute("isRejectInvoice", isRejectInvoice(billMonthBillingVo));//是否拒绝索取发票    总费用 是否 小于 已结算费用
        return "ucBillInfo";
    }

    private BillUserBillingVo billUserBillingVo(BillMonthBillingVo billMonthBillingVo, String orderId, String billingId) {
        BillUserBillingVo billUserBillingVo = new BillUserBillingVo();
        if(billMonthBillingVo != null  && billMonthBillingVo.getBillUserBillingVoList() != null) {
            for(BillUserBillingVo billingVo : billMonthBillingVo.getBillUserBillingVoList()) {
                String _billingId = billingVo.getBillingId();
                String _orderid = String.valueOf(billingVo.getOrderId());
                if(_billingId.equals(billingId) && _orderid.equals(orderId)) {
                    billUserBillingVo = billingVo;
                    break;
                }
            }
        }
        return billUserBillingVo;
    }


    /**
     * 我的账单菜单点击进入
     * @param request
     * @param month
     * @return
     */
    @RequestMapping(value = "getMonthBillView")
    public String getMonthBillView(HttpServletRequest request, String year, String month) {
        String activeMonth = month;
        User currentUser = getCurrentUser(request);
        // 月账单 vo
        BillMonthBillingVo billMonthBillingVo = null;
        List<String> userBillingMonths = null;
        // 查询用户的账单年份，只返回年份
        List<String> userBillingYears = billUserServiceBillingImpl.getUserBillingYears(currentUser.getId());
        // 优先按指定年份查询，如果没有指定年份，则按用户以前存在的年份进行查询，如果没有年份存在，则默认当前年份查询
        if (year == null || year.equals("")) {
            if(userBillingYears != null && userBillingYears.size() > 0) {
                year = userBillingYears.get(0);
            } else {
                year = DateTimeUtil.getYear();
                userBillingYears.add(year);
            }
            if(activeMonth == null || activeMonth.equals("")) {
                activeMonth = getActiveMonth(year);
            }
            // 根据年份查询用户账单月
            userBillingMonths = billUserServiceBillingImpl.getUserBillingMonths(year);
            // 查询月账单
            billMonthBillingVo = queryBillUserBIllingVo(currentUser.getId(), activeMonth);
        } else {
            userBillingMonths = billUserServiceBillingImpl.getUserBillingMonths(year);
            // 如果月份也为空，则查询用户已有账单的第一个月份
            if(activeMonth == null || activeMonth.equals("")) {
                // 按制定年份进行查询
                if (userBillingMonths != null && userBillingMonths.size() > 0) {
                    activeMonth = userBillingMonths.get(0);
                } else {
                    activeMonth = getActiveMonth(year);
                }
            }
            billMonthBillingVo = queryBillUserBIllingVo(currentUser.getId(), activeMonth);
        }
//        boolean isOweMoney = false;
//        if(billMonthBillingVo.getOweMoney() > 0) {
//            isOweMoney = true;
//        }
        // 如果返回的账单月没有记录，则取当前年，当前月之前的所有月份
        if(userBillingMonths == null || userBillingMonths.size() == 0) {
            userBillingMonths = getCurrentYearMonth(year);
        }
        if(userBillingYears == null || userBillingYears.size() <= 0) {
            userBillingYears.add(DateTimeUtil.getYear());
        }

//        request.setAttribute("isOweMoney", isOweMoney);// 是否欠费
        request.setAttribute("userBillingYears", userBillingYears);// 所有需要展示的年份
        request.setAttribute("userBillingMonths", userBillingMonths);// 所有需要展示的月份
        request.setAttribute("billMonthBillingVo", billMonthBillingVo);// 月账单信息
        request.setAttribute("activeMonth", activeMonth);// 当前显示的月份
        request.setAttribute("activeYear", year);// 当前显示的年份
        request.setAttribute("isRejectInvoice", isRejectInvoice(billMonthBillingVo));//是否拒绝索取发票    总费用 是否 小于 已结算费用
        return "ucMonthBill";
    }

    /**
     * 返回 true 表示拒绝 索取发票。false 为允许 索取发票
     * @param billMonthBillingVo
     * @return
     */
    private boolean isRejectInvoice(BillMonthBillingVo billMonthBillingVo) {
        double totalMoney = billMonthBillingVo.getTotalMoney();
        double clearMoney = billMonthBillingVo.getClearMoney();
        if(totalMoney - clearMoney >= 0) {
            return false;
        }
        return true;
    }

    /**
     * 导出 月账单明细的 Excel 格式
     */
    @RequestMapping(value = "exportBillExcel")
    public void exportBillExcel(String orderId, String billingId, String billingMonth, String serviceCode,
                                HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/vnd.ms-excel");
        String fileName = billingMonth + new String("发票明细".getBytes(), "iso-8859-1") + ".xls";
        response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\"");
        User currentUser = getCurrentUser(request);
        // 月账单明细
        List<BillMonthExport> billMonthExportList = billUserServiceBillingImpl.getUserBillingExportDetail(orderId,
                billingId, billingMonth, serviceCode, currentUser);

//        BillMonthExport export = new BillMonthExport();
//        export.setBillEndTime(DateTimeUtil.getTodayStart());
//        export.setBillingId(billingId);
//        export.setBillMoney("99999");
//        export.setBillStartTime(DateTimeUtil.getTodayStart());
//        export.setEmail("email@111.com");
//        export.setFeatherTypeName("xxxxxx");
//        export.setFeeName("wwwwwww");
//        export.setOrderId(orderId);
//        export.setServiceName("eeeeeee");
//        export.setState("1");
//        export.setUseAmount(989899L);
//        billMonthExportList.add(export);

        if(billMonthExportList != null) {
            for(BillMonthExport billexport : billMonthExportList) {
                String state = billexport.getState();
                if("1".equals(state)) {
                    billexport.setState("成功");
                } else if("0".equals(state)) {
                    billexport.setState("失败");
                }
            }
        }

        String[] headers = new String[] {"订单编号", "账单编号", "登录邮箱", "产品", "服务类型", "计费方式", "计费起始时间", "计费结束时间", "使用量", "费用", "扣费状态"};
        ExportExcel exportExcel = new ExportExcel();
        exportExcel.exportExcel(billingMonth + "发票明细", headers, billMonthExportList, response.getOutputStream(), "yyyy-MM-dd  HH:mm:ss");
    }

    /**
     * 根据用户ID 和 年月 获得该月份的用户账单信息
     * @param userId
     * @param yearMonth
     * @return
     */
    private BillMonthBillingVo queryBillUserBIllingVo(Long userId, String yearMonth) {
        if(!StringUtils.isNotBlank(yearMonth)) {
            yearMonth = DateTimeUtil.getYear() + DateTimeUtil.getMonth();
        }
        // 查询当月账单
        BillMonthBilling billing = billUserServiceBillingImpl.queryUserServiceBilling(userId, yearMonth);
        // 查询当月账单Vo  是为了 转换服务编码增加了字段
        BillMonthBillingVo billMonthBillingVo = new BillMonthBillingVo();
        // 拷贝属性
        BeanUtils.copyProperties(billing, billMonthBillingVo);
        // 当月账单详细VOList
        List<BillUserBillingVo> billUserBillingVos = Lists.newArrayList();
        // 当月账单详细
        List<BillUserBilling> billUserBillingList = billing.getBillUserBillingList();
        // 获取服务编码
        List<CodeInfo> allCodes = codeService.getAllCodes(SERVERCODE);

        if (billUserBillingList != null && billUserBillingList.size() > 0) {
            for (BillUserBilling billUserBilling : billUserBillingList) {
                BillUserBillingVo billUserBillingVo = new BillUserBillingVo();
                BeanUtils.copyProperties(billUserBilling, billUserBillingVo);
                for (CodeInfo codeInfo : allCodes) {
                    if (billUserBilling.getServiceCode().equals(codeInfo.getCode1())) {
                        billUserBillingVo.setServiceCodeDesc(codeInfo.getName());
                    }
                }
                billUserBillingVos.add(billUserBillingVo);
            }
            billMonthBillingVo.setBillUserBillingVoList(billUserBillingVos);
        }
        return billMonthBillingVo;
    }

    /**
     * 获取当年当前的所有月份
     * @return
     */
    private List<String> getCurrentYearMonth(String year) {
        int yearInt = Integer.valueOf(year);
        int m = Integer.valueOf(DateTimeUtil.getMonth());
        List<String> list = new ArrayList<String>();
        String yearMonthStr = null;
        for(int i = 1; i < m; i++) {
            if(i < 10) {
                yearMonthStr = yearInt + "0" + i;
            } else {
                yearMonthStr = "" + yearInt + i;
            }
            list.add(yearMonthStr);
        }
        return list;
    }

    /**
     * 获取当前月的前一个月
     * @param year
     * @return
     */
    private String getActiveMonth(String year) {
        String activeMonth = null;
        // 当前月的前一个月
        int m = Integer.valueOf(DateTimeUtil.getMonth()) - 1;
        if(m < 10) {
            activeMonth = "0" + m;
        } else {
            activeMonth = String.valueOf(m);
        }
        activeMonth = year + activeMonth;
        return activeMonth;
    }

    /**
     * 导出月账单的明细
     * @param orderId
     * @param billingMonth
     * @return
     */
    public List<BillMonthDetailBillingVo> exportBillExcel(String orderId, String billingMonth) {
        // 功能点 code
        List<CodeInfo> featherCodes = codeService.getAllCodes(FEATHERCODE);
        List<BillMonthDetailBilling> billMonthDetailBillings = billUserServiceBillingImpl.queryUserServiceDetailBilling(orderId, billingMonth);
        // 月账单明细
        List<BillMonthDetailBillingVo> billMonthDetailBillingVos = Lists.newArrayList();
        for (BillMonthDetailBilling billMonthDetailBilling : billMonthDetailBillings) {
            BillMonthDetailBillingVo billMonthDetailBillingVo = new BillMonthDetailBillingVo();
            BeanUtils.copyProperties(billMonthDetailBilling, billMonthDetailBillingVo);

            String featherCode = billMonthDetailBillingVo.getFeatherCode();
            for (CodeInfo codeInfo : featherCodes) {
                if (featherCode.equals(codeInfo.getCode1() + codeInfo.getCode2())) {
                    billMonthDetailBillingVo.setFeatherCodeDesc(codeInfo.getName());
                }
            }
            billMonthDetailBillingVos.add(billMonthDetailBillingVo);
        }
        return billMonthDetailBillingVos;
    }
}
