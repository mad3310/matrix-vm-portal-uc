package com.letvcloud.uc.mapper;

import com.letvcloud.uc.mapper.annotations.MyBatisDao;
import com.letvcloud.uc.po.Invoice;
import org.apache.ibatis.annotations.Param;

/**
 * Created by zhaoliang5 on 2015/6/28.
 */
@MyBatisDao
public interface InvoiceMapper {
    int saveInvoice(Invoice invoice);

    Invoice getInvoiceByUserId(Long userId);

    int modifyInvoiceByUserId(@Param("invoice") Invoice invoice);
}