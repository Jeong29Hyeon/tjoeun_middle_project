package com.mapper;

import com.dto.Like;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LikeMapper {
    //좋아요 dto만들고 매퍼 추가
    int ltlikecount(Like like);
    int ltlikegetinfo(Like like);
    int likeinsert(Like like);
    int likeupdate(Like like);
}
