package com.mapper;

import com.dto.Payment;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PaymentMapper {
    int insertTicketPayment(Payment payment);
    int insertCouponPayment(Payment payment);

    String selectImpUidByTno(Integer tno);
}
