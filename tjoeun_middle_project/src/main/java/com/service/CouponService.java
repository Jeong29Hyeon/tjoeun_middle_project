package com.service;

import com.dto.Goods;
import com.mapper.CouponMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class CouponService {
    CouponMapper couponMapper;
    @Autowired
    public CouponService(CouponMapper couponMapper) {
        this.couponMapper = couponMapper;
    }


    public void insertCoupon(Goods goods, String id) throws Exception {
        Map<String,Object> map = new HashMap<>();
        map.put("gno",goods.getGno());
        map.put("id",id);
        int result = couponMapper.insertCoupon(map);
        if(result < 1){
            throw new Exception("쿠폰 안생김");
        }
    }
}
