package com.service;

import com.dto.Goods;
import com.mapper.GoodsMapper;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GoodsService {
    GoodsMapper goodsMapper;
    @Autowired
    public GoodsService(GoodsMapper goodsMapper) {
        this.goodsMapper = goodsMapper;
    }


    public void insertGoods(Goods goods) throws Exception {
        int result = goodsMapper.insertGoods(goods);
        if(result < 1){
            throw new Exception("굿즈 생성 에러");
        }
    }

    public List<Goods> getGoodsList() throws Exception {
        List<Goods> goodsList = goodsMapper.selectAll();
        if(goodsList == null){
            throw new Exception("굿즈 없음");
        }
        return goodsList;
    }
}
