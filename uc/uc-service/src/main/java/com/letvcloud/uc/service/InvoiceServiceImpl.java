package com.letvcloud.uc.service;

import com.letvcloud.uc.mapper.InvoiceMapper;
import com.letvcloud.uc.po.Invoice;
import com.letvcloud.uc.vo.InvoiceVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by zhaoliang5 on 2015/6/28.
 */
@Service("invoiceService")
public class InvoiceServiceImpl implements InvoiceService {

    private static Logger logger = LoggerFactory.getLogger(InvoiceServiceImpl.class);

    @Autowired
    private InvoiceMapper invoiceMapperDao;

    @Override
    public void saveOrUpdateInvoice(InvoiceVo invoiceVo, Long userId) {
        if (invoiceVo != null && userId != null) {
            Invoice invoice = invoiceMapperDao.getInvoiceByUserId(userId);
            if (invoice != null) {
                Invoice invo = new Invoice();
                BeanUtils.copyProperties(invoiceVo, invo);
                invo.setId(invoice.getId());
                invoiceMapperDao.modifyInvoiceByUserId(invo);
            } else {
                invoice = new Invoice();
                BeanUtils.copyProperties(invoiceVo, invoice);
                invoiceMapperDao.saveInvoice(invoice);
            }
        }
    }

    public Invoice getInvoiceByUserId(Long userId) {
        return invoiceMapperDao.getInvoiceByUserId(userId);
    }
}