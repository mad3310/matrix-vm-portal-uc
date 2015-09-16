package com.letvcloud.uc.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.lecloud.statistics.bill.BusinessType;
import com.lecloud.statistics.bill.pojo.UserCalculation;
import com.lecloud.statistics.bill.service.business.BillingDataService;
import com.letvcloud.bill.BillServiceType;
import com.letvcloud.bill.po.BillUserAmount;
import com.letvcloud.bill.service.BillServiceOpenService;
import com.letvcloud.bill.service.BillUserAmountService;
import com.letvcloud.bill.vo.BillServiceOpen;
import com.letvcloud.bill.vo.FeatherCondition;
import com.letvcloud.saas.exception.Url404Exception;
import com.letvcloud.saas.util.FastJsonUtil;
import com.letvcloud.saas.util.HttpAPI;
import com.letvcloud.saas.util.MD5Util;
import com.letvcloud.saas.util.StringUtil;
import com.letvcloud.uc.po.User;
import com.letvcloud.uc.service.EnterpriseAuthenService;
import com.letvcloud.uc.service.UserService;
import com.thoughtworks.xstream.mapper.Mapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

//import com.lecloud.statistics.bill.service.business.BillingDataService;

/**
 * Created by wanglei14 on 2015/7/9.
 */
@Controller
@RequestMapping("/serviceOpen")
public class ServiceOpenController extends BaseController{
    //控制台首页
    @Value("#{configProperties['serviceOpen.ctrlUrl']}")
    private String CTRL_URL;
    @Value("#{configProperties['serviceOpen.liveCtrlUrl']}")
    private String LIVE_CTRL_URL;
    private static Map<String,String> values = new HashMap<String,String>();
    //存储空间获取URL
    @Value("#{configProperties['serviceOpen.capacityUrl']}")
    private String CAPACITY_URL;
    //转码时长获取URL
    @Value("#{configProperties['serviceOpen.incrementUrl']}")
    private String INCREMENT_URL;
    static{
        values.put("001","按流量");
        values.put("002","按带宽");
        values.put("003","95峰值");
        values.put("004","第四峰值");
        values.put("005","月最高峰");
        values.put("006","总月流量");
        values.put("007","日峰均值");
    }
    //p2p计算系数
    private static final BigDecimal P2P_VALUE=new BigDecimal("0.68");
    @Autowired
    BillServiceOpenService billServiceOpenServiceImpl;
    @Autowired
    BillUserAmountService billUserAmountServiceImpl;
    @Autowired
    EnterpriseAuthenService enterpriseAuthenService;
    @Autowired
    BillingDataService billingDataService;
    @Autowired
    UserService userService;

    private static final Logger logger = LoggerFactory.getLogger(ServiceOpenController.class);
/**直播开通
    @RequestMapping(value="/liveOpen")
    public String liveOpenInit(HttpServletRequest request){
       Long userId = 13L;
        if(!billServiceOpenServiceImpl.isServiceOpened(userId,BillServiceType.CLOUD_LIVE)){
            return CTRL_URL;
        }else {
            return "liveOpen";
        }
    }
 **/
    @RequestMapping(value = "/vodOpen")
    public String vodOpenInit(HttpServletRequest request){
        Long userId = getCurrentUser(request).getId();
        //如果已经开通跳转控制台
        if(billServiceOpenServiceImpl.isServiceOpened(userId,BillServiceType.CLOUD_VOD)) {
            return "redirect:" + CTRL_URL;
        }else{
            return "vodOpen";
        }
    }

    @RequestMapping(value = "/openService")
    public String openService(HttpServletRequest req,HttpServletResponse res) throws IOException{
        res.setContentType("text/html");
        res.setCharacterEncoding("UTF-8");
        PrintWriter out = res.getWriter();
        com.alibaba.fastjson.JSONObject result = new com.alibaba.fastjson.JSONObject();

        Long userId = getCurrentUser(req).getId();
        String serviceCode = req.getParameter("serviceCode");
        String cdnFeeCode = req.getParameter("cdnFeeCode");
        if(StringUtil.isEmpty(serviceCode) || StringUtil.isEmpty(cdnFeeCode)){
            logger.info("参数为空");
            //参数为空
            return null;
        }
        if(!serviceCode.matches("100|101") || !cdnFeeCode.matches("001|002")){
            logger.info("参数不合法");
            //参数不对
            return null;
        }
        //未经过身份认证(云直播)ps:云点播不需要认证
        if(BillServiceType.CLOUD_LIVE.equals(serviceCode) && !enterpriseAuthenService.getEnterproseAuthenStatus(userId)){
            result.put("state",2);
            out.print(result);
            return null;
        }
        //服务已开通
        if(billServiceOpenServiceImpl.isServiceOpened(userId,serviceCode)){
            return "redirect:"+CTRL_URL;
        }

        billServiceOpenServiceImpl.openServiceDefault(userId,serviceCode,cdnFeeCode);
        //开通云直播顺便开通云点播
        if(BillServiceType.CLOUD_LIVE.equals(serviceCode) && !billServiceOpenServiceImpl.isServiceOpened(userId,"101")){
                billServiceOpenServiceImpl.openServiceDefault(userId, "101", cdnFeeCode);
        }
        int i = 0;
        String status = "";
        do {
            try {
                String ret = postUser(userId);
                Map<String,String> resultMap = FastJsonUtil.parseJSON2Map(ret);
                status = resultMap.get("status");
                i++;
            } catch (IOException e) {
                e.printStackTrace();
                i++;
            }
        }while(i < 3 && !"1".equals(status) );
        result.put("state", 1);
        out.print(result.toString());
        return null;
    }

    @RequestMapping(value = "/openLive")
    public String openLive(HttpServletRequest req,HttpServletResponse res) throws IOException{
        res.setContentType("text/html");
        res.setCharacterEncoding("UTF-8");
        PrintWriter out = res.getWriter();
        com.alibaba.fastjson.JSONObject result = new com.alibaba.fastjson.JSONObject();

        Long userId = getCurrentUser(req).getId();
        //String cdnFeeCode = req.getParameter("cdnFeeCode");
        //默认按流量计费
        String cdnFeeCode = "001";
        if(StringUtil.isEmpty(cdnFeeCode)){
            logger.info("参数为空");
            //参数为空
            return null;
        }
        if(!cdnFeeCode.matches("001|002")){
            logger.info("参数不合法");
            //参数不对
            return null;
        }
        //未经过身份认证(云直播)ps:云点播不需要认证
        Integer authState = enterpriseAuthenService.getEnterproseAuthenStatusInfo(userId);
        if(authState == null || authState==0){
            result.put("state",2);
            out.print(result);
            return null;
        }else if( authState == 2){
            result.put("state",3);
            out.print(result);
            return null;
//            return "redirect:/qualificationsAuthenView/executeAuthenView.do";
        }
        Integer veryfyState = billServiceOpenServiceImpl.getState(userId,BillServiceType.CLOUD_LIVE);
        if(veryfyState != null && veryfyState == 0){
            result.put("state",4);
            out.print(result);
            return null;
        }

        //服务已开通并且经过审核
        if(billServiceOpenServiceImpl.isServiceOpened(userId,BillServiceType.CLOUD_LIVE)){
            return "redirect:"+LIVE_CTRL_URL;
        }

        billServiceOpenServiceImpl.openServiceDefault(userId,BillServiceType.CLOUD_LIVE,cdnFeeCode);
        //开通云直播顺便开通云点播
        if(!billServiceOpenServiceImpl.isServiceOpened(userId,BillServiceType.CLOUD_VOD)){
            billServiceOpenServiceImpl.openServiceDefault(userId,BillServiceType.CLOUD_VOD, cdnFeeCode);
            //通知点播系统
            int i = 0;
            String status = "";
            do {
                try {
                    String ret = postUser(userId);
                    Map<String,String> resultMap = FastJsonUtil.parseJSON2Map(ret);
                    status = resultMap.get("status");
                    i++;
                } catch (IOException e) {
                    e.printStackTrace();
                    i++;
                    logger.info("同步用户请求异常", e);
                }
            }while(i < 3 && !"1".equals(status) );
        }
        result.put("state", 1);
        out.print(result.toString());
        return null;
    }
    /**
     * 开通点播
     * @param req
     * @param res
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/openVod")
    public String openVod(HttpServletRequest req,HttpServletResponse res) throws IOException{
        res.setContentType("text/html");
        res.setCharacterEncoding("UTF-8");
        PrintWriter out = res.getWriter();
        com.alibaba.fastjson.JSONObject result = new com.alibaba.fastjson.JSONObject();

        Long userId = getCurrentUser(req).getId();
//        String cdnFeeCode = req.getParameter("cdnFeeCode");
        String cdnFeeCode="001";
        if(StringUtil.isEmpty(cdnFeeCode)){
            //参数为空
            return null;
        }
        if(!cdnFeeCode.matches("001|002")){
            //参数不对
            return null;
        }
        //服务已开通
        if(billServiceOpenServiceImpl.isServiceOpened(userId,BillServiceType.CLOUD_VOD)){
            return "redirect:"+CTRL_URL;
        }
        billServiceOpenServiceImpl.openServiceDefault(userId,BillServiceType.CLOUD_VOD,cdnFeeCode);
        int i = 0;
        String status = "";
        do {
            try {
                String ret = postUser(userId);
                Map<String,String> resultMap = FastJsonUtil.parseJSON2Map(ret);
                status = resultMap.get("status");
                i++;
            } catch (IOException e) {
                e.printStackTrace();
                i++;
                logger.info("同步用户请求异常",e);
            }
        }while(i < 3 && !"1".equals(status) );
        result.put("state", 1);
        if(billServiceOpenServiceImpl.isServiceOpened(userId,BillServiceType.CLOUD_LIVE)){
            result.put("isLive",1);
        }else{
            result.put("isLive",0);
        }
        out.print(result.toString());
        return null;
    }
    @RequestMapping(value="/openLiveConfirm")
    public ModelAndView openLiveConfirm(HttpServletRequest request){
        Long userId = getCurrentUser(request).getId();
        Map<String,Object> model = new HashMap<String, Object>();

        BillUserAmount amount = billUserAmountServiceImpl.getUserAmount(userId);
        model.put("amount",amount.getAvailableAmount());
        //身份认证的处理
        model.put("authState",1);
        Integer authState = enterpriseAuthenService.getEnterproseAuthenStatusInfo(userId);
        if(authState== null || authState==0){
            model.put("authState",2);
            return new ModelAndView("openLiveConfirm",model);
        }else if(authState == 2){
            model.put("authState",3);
            return new ModelAndView("openLiveConfirm",model);
        }
        Integer state = billServiceOpenServiceImpl.getState(userId, BillServiceType.CLOUD_LIVE);

        //如果已开通服务跳转控制台
//        if(billServiceOpenServiceImpl.isServiceOpened(userId,BillServiceType.CLOUD_LIVE)){
//            return new ModelAndView("redirect:"+LIVE_CTRL_URL);
//        }
        if(state != null ){
            if(state == 1){
                return new ModelAndView("redirect:"+LIVE_CTRL_URL);
            }else if(state == 0) {
                model.put("authState", 4);
                return new ModelAndView("openLiveConfirm", model);
            }
        }
        return new ModelAndView("openLiveConfirm",model);
    }
    @RequestMapping(value="/openVodConfirm")
    public ModelAndView openVodConfirm(HttpServletRequest request){
        Long userId =getCurrentUser(request).getId();
        //如果服务已经开通调往控制台
        if(billServiceOpenServiceImpl.isServiceOpened(userId,BillServiceType.CLOUD_VOD)){
            return new ModelAndView("redirect:"+CTRL_URL);
        }
        Map<String,Object> model = new HashMap<String, Object>();
        //当前计费方式
        String feeCodeNow = request.getParameter("feeCodeNow");
        //用户余额
        BillUserAmount amount = billUserAmountServiceImpl.getUserAmount(userId);
        model.put("amount",amount.getAvailableAmount());
        model.put("feeCodeNow",feeCodeNow);
        //未经过身份认证的处理
        model.put("authState",1);
        /**点播身份认证判断删除
        if(!enterpriseAuthenService.getEnterproseAuthenStatus(userId)){
            model.put("authState",2);
            return new ModelAndView("openVodConfirm",model);
        }
         **/

        return new ModelAndView("openVodConfirm",model);
    }


    @RequestMapping(value = "/showLive")
    public ModelAndView showLive(HttpServletRequest req){
        //TODO
        Long userId=getCurrentUser(req).getId();
        //如果未开通前往开通页面
        if(!billServiceOpenServiceImpl.isServiceOpened(userId,BillServiceType.CLOUD_LIVE)){
            return new ModelAndView("redirect:openLiveConfirm.do");
        }
        BillServiceOpen serviceOpen = billServiceOpenServiceImpl.getServiceByCode(userId, BillServiceType.CLOUD_LIVE);

        Map<String,Object> model = new HashMap<String, Object>();
        //扣费方式
        model.put("feeCode",values.get(serviceOpen.getFeeCodeNow()));
//        model.put("feeCodeNext",values.get(!StringUtil.isEmpty(serviceOpen.getFeeCodeNext())?serviceOpen.getFeeCodeNext()
//                :serviceOpen.getFeeCodeNow()));
        //业务状态
        model.put("state",serviceOpen.getAmountState());
        //峰值带宽
        DateFormat format = new SimpleDateFormat("yyyyMM");
        String date = format.format(System.currentTimeMillis());
        //计算系数
        Double cal = calculateLoss(serviceOpen.getLossValue(),serviceOpen.getP2pValue());
        UserCalculation userCalculation = new UserCalculation(cal);
        //峰值带宽
        double bandWidth= billingDataService.queryTopBandwidthByMonth(userId.toString(), BusinessType.CLOUD_LIVE,
                userCalculation,date);
        if(bandWidth < 1024){
            model.put("bandwidth",bandWidth+"M");
        }else {
            model.put("bandwidth", String.format("%.2f", (double) bandWidth / 1024)+"G");
        }

        //转码时长
        /**
        String incrementJson = "";
        long increment=0L;
        String increUrl = INCREMENT_URL+userId.toString()+"?type=0";
        try{
            incrementJson = HttpAPI.executeGet(3000,3000,increUrl);
        }catch(Url404Exception e){

        }catch(IOException e1){

        }
        if(incrementJson !=""){
            JSONObject incrementObj = JSON.parseObject(incrementJson);
            if(incrementObj.getInteger("retCode") == 0) {
                increment = incrementObj.getJSONObject("data").getLong("duration");
            }else{
                //todo
                //异常处理
            }
        }
        model.put("increment",increment/60);
       **/
        return new ModelAndView("showLive",model);
    }
    @RequestMapping(value = "/showVod")
    public ModelAndView showVod(HttpServletRequest req){
        //TODO
        Long userId=getCurrentUser(req).getId();
        if(!billServiceOpenServiceImpl.isServiceOpened(userId,BillServiceType.CLOUD_VOD)){
            return new ModelAndView("redirect:vodOpen.do");
        }
        BillServiceOpen serviceOpen = billServiceOpenServiceImpl.getServiceByCode(userId,BillServiceType.CLOUD_VOD);
        Map<String,Object> model = new HashMap<String,Object>();
        //扣费方式
        model.put("feeCode",values.get(serviceOpen.getFeeCodeNow()));
        model.put("feeCodeNext",values.get(!StringUtil.isEmpty(serviceOpen.getFeeCodeNext())?serviceOpen.getFeeCodeNext()
        :serviceOpen.getFeeCodeNow()));
        model.put("state",serviceOpen.getAmountState());
        //TODO
        DateFormat format = new SimpleDateFormat("yyyyMM");
        String date = format.format(System.currentTimeMillis());
        //计算系数
        Double cal= calculateLoss(serviceOpen.getLossValue(),serviceOpen.getP2pValue());
        //计费系数
        UserCalculation userCalculation = new UserCalculation(cal);
        //本月累计流量
        double traffic = billingDataService.queryTrafficByMonth(userId.toString(),BusinessType.CLOUD_VOD
        ,userCalculation,date);
        if(traffic <1024){
            model.put("traffic",traffic+"M");
        }else {
            model.put("traffic", String.format("%.2f", traffic / 1024)+"G");
        }
        //峰值带宽
        double bandWidth = billingDataService.queryTopBandwidthByMonth(userId.toString(),BusinessType.CLOUD_VOD
        ,userCalculation,date);
        if(bandWidth < 1024){
            model.put("bandwidth",String.valueOf(bandWidth)+"M");
        }else {
            model.put("bandwidth", String.format("%.2f", bandWidth / 1024)+"G");
        }
        //存储空间
        String capacityUrl = CAPACITY_URL+userId.toString();
        String capacityJson = "";
        //单位M
        long capacity = 0L;
        try {
           capacityJson = HttpAPI.executeGet(3000, 300, capacityUrl);
        }catch(Url404Exception e){

        }catch(IOException e1){

        }
        if(capacityJson !="") {
            JSONObject capacityObj = JSON.parseObject(capacityJson);
            if(capacityObj.getInteger("retCode") == 0) {
                capacity = capacityObj.getJSONObject("data").getLong("totalSize");
            }else{
                //todo
                //异常处理
            }
        }
        if (capacity < 1024) {
            model.put("capacity",(double)capacity+"M");
        }else {
            model.put("capacity", String.format("%.2f", (double) capacity / 1024)+"G");
        }

        //转码时长
        /**
        String incrementJson = "";
        long increment=0L;
        String increUrl = INCREMENT_URL+userId.toString();
        try{
            incrementJson = HttpAPI.executeGet(3000,3000,increUrl);
        }catch(Url404Exception e){

        }catch(IOException e1){

        }
        if(incrementJson !=""){
            JSONObject incrementObj = JSON.parseObject(incrementJson);
            if(incrementObj.getInteger("retCode") == 0) {
                increment = incrementObj.getJSONObject("data").getLong("duration");
            }else{
                //todo
                //异常处理
            }
        }
        model.put("increment",increment/60);
         **/
        return new ModelAndView("showVod",model);
    }
    @RequestMapping(value = "showCdn")
    public ModelAndView showCdn(HttpServletRequest req){
        Long userId = getCurrentUser(req).getId();
        Map<String,Object> model = new HashMap<String,Object>();
        DateFormat format = new SimpleDateFormat("yyyyMM");
        String date = format.format(System.currentTimeMillis());
        //直播CDN
        BillServiceOpen cdnLive = billServiceOpenServiceImpl.getServiceByCode(userId,BillServiceType.CDN_STREAM_DIS);
        if(cdnLive == null){
            model.put("liveExist",false);
        }else{
            model.put("liveExist",true);
            model.put("liveFeeCode",values.get(cdnLive.getFeeCodeNow()));
            model.put("liveFeeCodeNext", values.get(!StringUtil.isEmpty(cdnLive.getFeeCodeNext()) ? cdnLive.getFeeCodeNext()
                    : cdnLive.getFeeCodeNow()));
            model.put("liveState", cdnLive.getAmountState());
            //计算系数
            Double cal= calculateLoss(cdnLive.getLossValue(),cdnLive.getP2pValue());
            //计费系数
            UserCalculation userCalculation = new UserCalculation(cal);
            //本月累计流量
            double traffic = billingDataService.queryTrafficByMonth(userId.toString(),BusinessType.CDN_STREAM
                    ,userCalculation,date);
            if(traffic < 1024){
                model.put("liveTraffic", traffic+"M");
            }else {
                model.put("liveTraffic", String.format("%.2f", traffic / 1024)+"G");
            }
            //峰值带宽
            double bandWidth = billingDataService.queryTopBandwidthByMonth(userId.toString(),BusinessType.CDN_STREAM
                    ,userCalculation,date);
            if(bandWidth < 1024){
                model.put("liveBandwidth",bandWidth+"M");
            }else{
                model.put("liveBandwidth",String.format("%.2f",bandWidth/1024)+"G");
            }

        }
        BillServiceOpen cdnVod = billServiceOpenServiceImpl.getServiceByCode(userId,BillServiceType.CDN_FILE_SPEED);
        if(cdnVod == null){
            model.put("vodExist",false);
        }else{
            model.put("vodExist",true);
            model.put("vodFeeCode",values.get(cdnVod.getFeeCodeNow()));

            model.put("vodFeeCodeNext",values.get(!StringUtil.isEmpty(cdnVod.getFeeCodeNext()) ? cdnVod.getFeeCodeNext()
                    : cdnVod.getFeeCodeNow()));
            model.put("vodState", cdnVod.getAmountState());
            //计算系数
            Double cal= calculateLoss(cdnVod.getLossValue(),cdnVod.getP2pValue());
            //计费系数
            UserCalculation userCalculation = new UserCalculation(cal);
            //本月累计流量
            double traffic = billingDataService.queryTrafficByMonth(userId.toString(),BusinessType.CDN_DISTRIBUTE
                    ,userCalculation,date);
            if(traffic < 1024){
                model.put("vodTraffic", traffic+"M");
            }else {
                model.put("vodTraffic", String.format("%.2f",  traffic / 1024)+"G");
            }
            //峰值带宽
            double bandWidth = billingDataService.queryTopBandwidthByMonth(userId.toString(),BusinessType.CDN_DISTRIBUTE
                    ,userCalculation,date);
            if(bandWidth < 1024){
                model.put("vodBandwidth", bandWidth+"M");
            }else {
                model.put("vodBandwidth", String.format("%.2f", bandWidth / 1024)+"G");
            }
        }

        return new ModelAndView("showCdn",model);
    }
    @RequestMapping(value = "changeService")
    public void changeService(HttpServletRequest req,HttpServletResponse res) throws IOException{

        Long userId = getCurrentUser(req).getId();
        res.setContentType("text/html");
        res.setCharacterEncoding("UTF-8");
        PrintWriter out = res.getWriter();
        String serviceCode = req.getParameter("serviceCode");
        String featherCode = req.getParameter("featherCode");
        FeatherCondition condition = new FeatherCondition();
        condition.setUserId(userId);
        condition.setServiceCode(serviceCode);
        condition.setFeatherCode(featherCode);
        String feeCodeNext =req.getParameter("feeCodeNext");
        condition.setFeeCodeNext(feeCodeNext);
        billServiceOpenServiceImpl.changeFeather(condition);

        com.alibaba.fastjson.JSONObject data = new com.alibaba.fastjson.JSONObject();
        //生效时间
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.MONTH,cal.get(Calendar.MONTH)+1);
        cal.set(Calendar.DAY_OF_MONTH,1);
        String date = new SimpleDateFormat("yyyy.MM.dd").format(cal.getTime());
        data.put("date", date);
        data.put("state",1);
        out.print(data);

    }
    @RequestMapping(value = "/showServiceChange")
    public ModelAndView changeServiceShow(HttpServletRequest request){
        User user = this.getCurrentUser(request);
        Map<String,Object>  model = new HashMap<String,Object>();
        String serviceCode = request.getParameter("serviceCode");
        BillUserAmount amount = billUserAmountServiceImpl.getUserAmount(user.getId());
        model.put("amount",amount.getAvailableAmount());
        model.put("serviceCode", serviceCode);
        BillServiceOpen serviceOpen = billServiceOpenServiceImpl.getServiceByCode(user.getId(),serviceCode);
        if(serviceOpen == null){
            return null;
        }
        model.put("feeCode",serviceOpen.getFeeCodeNext());
        //生效时间
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.MONTH,cal.get(Calendar.MONTH)+1);
        cal.set(Calendar.DAY_OF_MONTH,1);
        String date = new SimpleDateFormat("yyyy.MM.dd").format(cal.getTime());
        model.put("date",date);

        return new ModelAndView("showServiceChange",model);
    }

    private String postUser(Long userId) throws IOException {
        User user =userService.getUserById(userId);
        String url = "http://vod.letvcloud.com/api/addUserinfo";
        String secret="uc!@#^%$";
        Map<String,String> params = new HashMap<String,String>();
        params.put("app","uc");
        params.put("email",user.getEmail());
        params.put("user_id",user.getId().toString());
        params.put("user_key",user.getUserKey());
        //todo
        params.put("user_name", URLEncoder.encode(user.getContacts(), "UTF-8"));
        params.put("user_type",user.getUserType().toString());
        params.put("user_unique",user.getUserUnique());
        params.put("mobile",user.getMobile());
        params.put("enterpriseName",URLEncoder.encode(user.getEnterpriseName(),"UTF-8"));
        String[] keys={"app","email","enterpriseName","mobile","user_id","user_key","user_name","user_type","user_unique"};
        Arrays.sort(keys);
        StringBuilder signStr = new StringBuilder();
        for(int i =0;i<keys.length;i++){
            signStr.append(keys[i]).append(params.get(keys[i]));
        }
        signStr.append(secret);
        String sign = MD5Util.MD5(signStr.toString());
        params.put("sign",sign);
        String result  = HttpAPI.executePost(30000,30000,url,params);
        return result;
    }

    private Double calculateLoss(String lossValue, String p2pValue) {
        //  系数公式：  1 + 带宽损耗 + (p2p商务系数 * p2p分享率) / (1 - p2p分享率)  其中 p2p分享率 = 68%
        BigDecimal fenzi = new BigDecimal(p2pValue).multiply(P2P_VALUE).setScale(8, BigDecimal.ROUND_HALF_UP);
        BigDecimal fenmu = new BigDecimal(1).subtract(P2P_VALUE).setScale(8, BigDecimal.ROUND_HALF_UP);
        BigDecimal divideValue = fenzi.divide(fenmu);
        BigDecimal userLoss = new BigDecimal(1).add(new BigDecimal(lossValue)).add(divideValue);
        return new Double(userLoss.toString());
    }
}
