package com.mapper;

import com.dto.Like;
import com.dto.Review;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface LikeMapper {
    //좋아요 dto만들고 매퍼 추가
    Like likeselect(Review review);
    int ltlikegetinfo(Review review);
    int likeinsert(Review review);
    int likedelete(Review review);

    List<Like> selectAllBySeq(String seq);
    List<Like> selectByUserIdSeq(Map<String,Object> map);

}
