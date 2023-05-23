package com.service;

import com.dto.Coupon;
import com.dto.Goods;
import java.util.List;
import java.util.Map;

public interface CouponService {
    void insertCoupon(Map<String, Goods> cart, String imp_uid, Integer paid_amount, String userId);
    List<Coupon> selectAllById(String id);
    int deleteByCno(String cno);


}
