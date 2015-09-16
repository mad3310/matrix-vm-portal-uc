package com.letvcloud.uc.service;

import com.letvcloud.uc.po.Invoice;
import com.letvcloud.uc.vo.InvoiceVo;

/**
 * Created by zhaoliang5 on 2015/6/28.
 */
public interface InvoiceService {

    void saveOrUpdateInvoice(InvoiceVo invoiceVo, Long userId);

    Invoice getInvoiceByUserId(Long userId);
}