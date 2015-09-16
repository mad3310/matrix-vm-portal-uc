package com.letvcloud.uc.controller;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.letvcloud.bill.po.BillRechargeRecord;
import com.letvcloud.bill.po.BillUserAmount;
import com.letvcloud.bill.service.BillUserAmountService;
import com.letvcloud.bill.service.BillUserServiceBilling;
import com.letvcloud.saas.util.BeanMapConverUtil;
import com.letvcloud.saas.util.FastJsonUtil;
import com.letvcloud.saas.util.MD5Util;
import com.letvcloud.saas.util.StringUtil;
import com.letvcloud.saas.util.vo.PageInfo;
import com.letvcloud.saas.util.vo.PageResult;
import com.letvcloud.uc.po.User;
import com.letvcloud.uc.service.MessageBusService;
import com.letvcloud.uc.utils.Const;
import com.letvcloud.uc.vo.RechargeBossReturnVo;
import com.letvcloud.uc.vo.RechargeBossVo;
import com.letvcloud.uc.vo.RechargeVo;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.BufferedHttpEntity;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.HttpClientBuilder;
import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;


/**
 * Created by zhaoliang5 on 2015/6/27.
 */


@Controller
@RequestMapping("/recharge")
public class RechargeController extends BaseController {

    private Logger logger = LoggerFactory.getLogger(RechargeController.class);

    @Autowired
    private BillUserAmountService billUserAmountServiceImpl;

    @Autowired
    private BillUserServiceBilling billUserServiceBilling;

    @Autowired
    private MessageBusService messageBusServiceImpl;


    @Value("#{configProperties['cz.zfbreqAddr']}")
    private String zfbreqAddr;

    @Value("#{configProperties['cz.wxreqAddr']}")
    private String wxreqAddr;

    @Value("#{configProperties['cz.backUrl']}")
    private String backUrl;

    @Value("#{configProperties['cz.fronturl']}")
    private String fronturl;

    @Value("#{configProperties['cz.rechargePop']}")
    private String popUrl;

    /**
     * 充值方法
     * @param rechargeVo
     * @return
     */
    @RequestMapping("/rechargeOperate")
    public String rechargeOperate(HttpServletRequest request, RechargeVo rechargeVo) throws IOException {
        String targetResult = "";
        if (StringUtils.isBlank(rechargeVo.getChargeMoney()) || null == rechargeVo.getRechargeWay()) {
            logger.error("充值金额或充值方式错误：充值金额" + rechargeVo.getChargeMoney() +",充值方式" + rechargeVo.getRechargeWay());
        }
        try{
            Integer.parseInt(rechargeVo.getChargeMoney());
        }catch (NumberFormatException e){
            logger.error("充值金额错误"+ rechargeVo.getChargeMoney());
        }
        if(!(rechargeVo.getRechargeWay() instanceof Integer)){
            logger.error("充值方式类型错误" + rechargeVo.getRechargeWay());
        }
        if(Const.chargeZFB != rechargeVo.getRechargeWay() && Const.chargeWX != rechargeVo.getRechargeWay()){
            logger.error("充值方式错误" + rechargeVo.getRechargeWay());
        }

        User currentUser = this.getCurrentUser(request);
        //  生成充值流水
        Long userId = currentUser.getId();
        String tradingNumber = billUserAmountServiceImpl.recharge(userId, new BigDecimal(rechargeVo.getChargeMoney()), rechargeVo.getRechargeWay());
        if (Const.chargeZFB.equals(rechargeVo.getRechargeWay())) { //支付宝充值
            logger.info("请求支付宝：userId=" + currentUser.getId() +"交易信息=" + BeanMapConverUtil.beanToMap(setRechargeBossVo("1",currentUser,tradingNumber,rechargeVo.getChargeMoney())));
            targetResult = executePost(60000, 60000, zfbreqAddr, BeanMapConverUtil.beanToMap(setRechargeBossVo("1",currentUser,tradingNumber,rechargeVo.getChargeMoney())));
        } else if (Const.chargeWX.equals(rechargeVo.getRechargeWay())) { //微信充值
            logger.info("请求微信：userId=" + currentUser.getId() +"交易信息=" + tradingNumber);
            targetResult = "/recharge/rechargeQrcode.do?tradeNum=" + tradingNumber;
        }
        return "redirect:"+targetResult;
    }


    @RequestMapping("/rechargeFinishPop")
    public String rechargeFinishPop(HttpServletRequest request){
        request.setAttribute("popUrl", popUrl);
        return "rechargeFinishPop";
    }

    /**
     * 充值完成，boss系统回调函数，如果不传success或true会一直回调
     * @param rechargeBossReturnVo
     * @return
     */
    @RequestMapping("/rechargeFinish")
    public @ResponseBody String rechargeFinish(RechargeBossReturnVo rechargeBossReturnVo) {
        String result = StringUtils.EMPTY;
        StringBuilder signStr = new StringBuilder();
        signStr.append("corderid=");
        signStr.append(rechargeBossReturnVo.getCorderid().trim());
        signStr.append("&6033bd29078a5e094bf53748238aae82");
        signStr.append("&money=");
        signStr.append(rechargeBossReturnVo.getMoney().trim());
        signStr.append("&companyid=");
        signStr.append(rechargeBossReturnVo.getCompanyid().trim());
        String sign = MD5Util.MD5(signStr.toString());
        logger.info("BOSS系统回调信息：" + FastJsonUtil.obj2json(rechargeBossReturnVo));
        if (sign.equals(rechargeBossReturnVo.getSign())){
            if (rechargeBossReturnVo != null && StringUtils.isNotBlank(rechargeBossReturnVo.getCorderid()) &&
                    StringUtils.isNotBlank(rechargeBossReturnVo.getMoney()) && StringUtils.isNotBlank(rechargeBossReturnVo.getSign()) && StringUtils.isNotBlank(rechargeBossReturnVo.getUserid())) {
                //查询该用户上次交易号进行充值的充值记录
                BillRechargeRecord rechargeRecord = billUserAmountServiceImpl.getRechargeRecord(rechargeBossReturnVo.getCorderid());
                int success = rechargeRecord.getSuccess(); // success 0：失败 1 成功
                //交易记录为失败状态，则更改用户充值记录状态为成功
                if (success == 0) {
                    long total = billUserAmountServiceImpl.rechargeSuccess
                            (Long.parseLong(rechargeBossReturnVo.getUserid()), rechargeBossReturnVo.getCorderid(), rechargeBossReturnVo.getOrdernumber(), new BigDecimal(rechargeBossReturnVo.getMoney()));

                    if (total == 1) { //状态修改成功

                        //充值成功欠费账单清账
                        billUserServiceBilling.clearOweBilling(Long.parseLong(rechargeBossReturnVo.getUserid()), new BigDecimal(rechargeBossReturnVo.getMoney()));
                        BillUserAmount billUserAmount = billUserAmountServiceImpl.getUserAmount(Long.parseLong(rechargeBossReturnVo.getUserid()));
                        //发送充值成功短信
                        DateTime dateTime = new DateTime();
                        messageBusServiceImpl.sendRechargeMsgBus(Long.parseLong(rechargeBossReturnVo.getUserid()),dateTime.toString("MM月dd日HH:mm"),rechargeBossReturnVo.getMoney(),billUserAmount.getAvailableAmount().toString());
                        logger.info("充值成功，userId=" + rechargeBossReturnVo.getUserid() +"充值清账成功");
                        result = "success";
                    }
                }else {
                    logger.info("充值已经成功");
                    result = "success";
                }
            }
        }
        return result;
    }

    /**
     * 充值弹出框
     * @param request
     * @return
     */
    @RequestMapping("/rechargePop")
    public String rechargePopView(HttpServletRequest request) {
        User currentUser = this.getCurrentUser(request);
        logger.info("充值弹窗，userId=" + currentUser.getId());
        BillUserAmount billUserAmount = billUserAmountServiceImpl.getUserAmount(currentUser.getId());
        DecimalFormat formatter=new DecimalFormat("0.00");//制定精度
        String userAmount = formatter.format(billUserAmount.getAvailableAmount().doubleValue());
        request.setAttribute("accountMoney", userAmount);
        return "rechargePop";
    }

    /**
     * 充值详细页面
     *
     * @param request
     * @return
     */
    @RequestMapping("/rechargeDetailsView")
    public String rechargeDetailsView(HttpServletRequest request) {
        BigDecimal totalMoney = new BigDecimal(0);
        User currentUser = this.getCurrentUser(request);
        logger.info("充值详细页面，userId=" + currentUser.getId());
        BillUserAmount billUserAmount = billUserAmountServiceImpl.getUserAmount(currentUser.getId());
        if (billUserAmount != null) {
            totalMoney = billUserAmount.getAvailableAmount();
        }
        DecimalFormat formatter=new DecimalFormat("0.00");//制定精度
        String userAmount = formatter.format(totalMoney.doubleValue());
        request.setAttribute("totalMoney",userAmount);
        return "rechargeDetails";
    }

    /**
     * 获取充值明细数据
     * @param request
     * @param start
     * @param fetchSize
     * @return
     */
    @RequestMapping("/loadRechargeDetails")
    public @ResponseBody String rechargeDetails(HttpServletRequest request,Long start, Integer fetchSize){
        PageInfo pageInfo = new PageInfo();
        User currentUser = this.getCurrentUser(request);
        pageInfo.setRows(fetchSize);
        pageInfo.setPage(start.intValue());
        PageResult pageResult = billUserAmountServiceImpl.getUserAmountRecord(pageInfo, currentUser.getId());
        return FastJsonUtil.obj2jsonDateFormat(pageResult);
    }

    /**
     * HttpClient post调用，状态码302直接跳转
     *
     * @param connectTimeOut
     * @param readDataTimeOut
     * @param url
     * @param params
     * @return
     * @throws IOException
     */
    private String executePost(int connectTimeOut, int readDataTimeOut, String url, Map<String, String> params)
            throws IOException {
        HttpClient httpClient = HttpClientBuilder.create().build();
        RequestConfig config = RequestConfig.custom().setConnectTimeout(connectTimeOut)
                .setSocketTimeout(readDataTimeOut).build();
        MultipartEntityBuilder multipartEntityBuilder = MultipartEntityBuilder.create();
        if (params != null) {
            for (String key : params.keySet()) {
                multipartEntityBuilder.addTextBody(key, params.get(key));
            }
        }
        HttpPost httppost = new HttpPost(url);
        httppost.setEntity(multipartEntityBuilder.build());
        httppost.setConfig(config);
        HttpResponse response = null;
        String result = "";
        response = httpClient.execute(httppost);
        int statusCode = response.getStatusLine().getStatusCode();
        HttpEntity respEntity = response.getEntity();
        if (respEntity != null) {
            respEntity = new BufferedHttpEntity(respEntity);

            InputStream in = respEntity.getContent();
            result = IOUtils.toString(in);
            in.close();
        }
        if (statusCode == 302) {
            Header[] hs = response.getHeaders("Location");
            if (hs.length > 0) {
                return hs[0].getValue();
            } else {
                throw new IOException("调用URL返回错误状态。statusCode=" + statusCode + ";URL=" + url + ";result=" + result);
            }
        } else if (statusCode != 200) {
            throw new IOException("调用URL返回错误状态。statusCode=" + statusCode + ";URL=" + url + ";result=" + result);
        }
        return result;
    }

    /**
     * 跳转到二维码页面
     * @param request
     * @param tradeNum
     * @return
     * @throws IOException
     */
    @RequestMapping("/rechargeQrcode")
    public String rechargeQrcode(HttpServletRequest request,String tradeNum) throws IOException {
        logger.info("跳转到微信二维码页面，交易号"  + tradeNum);
        BillRechargeRecord rechargeRecord = billUserAmountServiceImpl.getRechargeRecord(tradeNum);
        logger.info("充值记录信息，" + FastJsonUtil.obj2json(rechargeRecord));
        request.setAttribute("tradeNum",tradeNum);
        request.setAttribute("chargeMoney",rechargeRecord.getAmount());
        return "rechargeQrcode";
    }

    /**
     * 生成二维码
     * @param request
     * @param response
     * @param tradeNum
     * @param chargeMoney
     * @throws IOException
     * @throws WriterException
     */
    @RequestMapping("/qrcodeImage")
    public void generateQRcode(HttpServletRequest request,HttpServletResponse response,String tradeNum,String chargeMoney) throws IOException, WriterException {
        User currentUser = this.getCurrentUser(request);
        String targetResult;
        logger.info("请求微信生成二维码，userId="+currentUser.getId()+", 充值金额=" + chargeMoney + ",充值交易号=" + tradeNum);
        targetResult = executePost(60000, 60000, wxreqAddr, BeanMapConverUtil.beanToMap(setRechargeBossVo("2",currentUser,tradeNum,chargeMoney)));
        Map<String, String> targetMap = FastJsonUtil.parseJSON2Map(targetResult);
        String content = targetMap.get("wxurl");// 内容
        int width = 200; // 图像宽度
        int height = 200; // 图像高度
        String format = "png";
        Map<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>();
        hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
        BitMatrix bitMatrix = new MultiFormatWriter().encode(content,
                BarcodeFormat.QR_CODE, width, height, hints);// 生成矩阵
        OutputStream outputStream = response.getOutputStream();
        MatrixToImageWriter.writeToStream(bitMatrix,format,outputStream);
        outputStream.flush();
    }

    /**
     * 设置boss系统vo
     * @param chargeWay
     * @param user
     * @param tradeNum
     * @param chargeMoney
     * @return
     * @throws UnsupportedEncodingException
     */
    private RechargeBossVo setRechargeBossVo(String chargeWay,User user,String tradeNum,String chargeMoney) throws UnsupportedEncodingException {
        RechargeBossVo rechargeBossVo = new RechargeBossVo();
        rechargeBossVo.setCorderid(tradeNum);
        rechargeBossVo.setUserid(Long.toString(user.getId()));
        rechargeBossVo.setUsername(user.getContacts());
        rechargeBossVo.setBackurl(backUrl);
        rechargeBossVo.setFronturl(fronturl + "?corderId=" + tradeNum);
        rechargeBossVo.setPrice(new BigDecimal(chargeMoney));
        rechargeBossVo.setProductname(URLEncoder.encode("充值", "UTF-8"));
        rechargeBossVo.setProductdesc(URLEncoder.encode("充值", "UTF-8"));
        if (chargeWay.equals("1")){
            rechargeBossVo.setReqAddr(zfbreqAddr);
        }else if(chargeWay.equals("2")){
            rechargeBossVo.setReqAddr(wxreqAddr);
        }
        return rechargeBossVo;
    }

    /**
     * 充值完成
     *
     * @return
     */
    @RequestMapping("/rechargeDone")
    public @ResponseBody String rechargeDone(HttpServletRequest request) {
        BigDecimal totalMoney = new BigDecimal(0);
        User currentUser = this.getCurrentUser(request);
        BillUserAmount billUserAmount = billUserAmountServiceImpl.getUserAmount(currentUser.getId());
        if (billUserAmount != null) {
            totalMoney = billUserAmount.getAvailableAmount();
        }
        logger.info("充值完成，userId="+currentUser.getId()+"," + FastJsonUtil.obj2json(billUserAmount));
        DecimalFormat formatter=new DecimalFormat("0.00");//制定精度
        String userAmount = formatter.format(totalMoney.doubleValue());
        return FastJsonUtil.obj2json(userAmount);
    }


    /**
     * 跳转到充值状态页
     * @param request
     * @param corderId
     * @return
     */
    @RequestMapping(value = "/rechargeSuccess")
    public String rechargeSuccess(HttpServletRequest request,String corderId){
        logger.info("充值成功页，充值交易号:" + corderId);
        BillRechargeRecord rechargeRecord = billUserAmountServiceImpl.getRechargeRecord(corderId);
        logger.info("跳转到充值成功页：" + FastJsonUtil.obj2json(rechargeRecord));
        request.setAttribute("state",rechargeRecord.getSuccess());
        request.setAttribute("totalMoney",rechargeRecord.getAmount());
        request.setAttribute("orderNum",rechargeRecord.getOrderNum());
        return "rechargeSuccess";
    }

    /**
     * 判断是否已经充值
     * @param corderId
     * @return
     */
    @RequestMapping("/whetherRecharge")
    public @ResponseBody String whetherRecharge(String corderId){
        logger.info("是否已经充值，充值交易号:" + corderId);
        BillRechargeRecord rechargeRecord = billUserAmountServiceImpl.getRechargeRecord(corderId);
        String orderNum = "";
        if (StringUtils.isNotBlank(rechargeRecord.getOrderNum())){
            orderNum = corderId;
        }
        return FastJsonUtil.obj2json(orderNum);
    }
}
