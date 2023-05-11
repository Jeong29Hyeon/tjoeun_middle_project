package com.mapper;

import com.dto.Coupon;
import com.dto.Goods;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CouponMapper {
    int insertCoupon(Map<String,Object> map);

    List<Coupon> selectAllById(String id);

    int deleteByImpUid(String imp_uid);
}
