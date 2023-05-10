package com.mapper;

import com.dto.Goods;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface CouponMapper {
    int insertCoupon(Map<String,Object> map);
}
