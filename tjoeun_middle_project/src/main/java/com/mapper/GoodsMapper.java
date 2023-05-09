package com.mapper;

import com.dto.Goods;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface GoodsMapper {

    int insertGoods(Goods goods);

    List<Goods> selectAll();

}
