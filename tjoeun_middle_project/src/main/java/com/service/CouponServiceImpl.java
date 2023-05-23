package com.service;

import com.dto.Coupon;
import com.dto.Goods;
import com.dto.Payment;
import com.mapper.CouponMapper;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

@Service
public class CouponServiceImpl implements CouponService {
    CouponMapper couponMapper;
    PaymentService paymentService;

    DataSourceTransactionManager transactionManager;

    public CouponServiceImpl(CouponMapper couponMapper, PaymentService paymentService,
        DataSourceTransactionManager dataSourceTransactionManager) {
        this.couponMapper = couponMapper;
        this.paymentService = paymentService;
        this.transactionManager = dataSourceTransactionManager;
    }

    public void insertCoupon(Map<String, Goods> cart, String imp_uid, Integer paid_amount, String userId) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = transactionManager.getTransaction(def);
        Map<String, Object> map = new HashMap<>();
        map.put("id", userId);
        map.put("imp_uid", imp_uid);
        try {
            for (Goods goods : cart.values()) {
                map.put("gno", goods.getGno());
                for (int i = 0; i < goods.getQuantity(); i++) {
                    couponMapper.insertCoupon(map);
                }
            }
            Payment payment = new Payment();
            payment.setImp_uid(imp_uid);
            payment.setPaid_amount(paid_amount);
            paymentService.insertCouponPayment(payment);
            transactionManager.commit(status);
        } catch (Exception e) {
            transactionManager.rollback(status);
            throw new RuntimeException(e);
        }
    }

    public List<Coupon> selectAllById(String id){
        return couponMapper.selectAllById(id);
    }

    public int deleteByCno(String cno){
        return couponMapper.deleteByCno(cno);
    }

}
