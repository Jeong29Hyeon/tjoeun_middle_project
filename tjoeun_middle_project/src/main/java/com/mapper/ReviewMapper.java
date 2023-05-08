package com.mapper;

import com.dto.Review;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReviewMapper {
    int insertReview(Review reviewDto);

    int updateReview(Review reviewDto);

    int deleteReview(Integer rno);

    List<Review> selectAllBySeq(Integer seq);

    //    int selectAll();
    //좋아요 기능 추가중
    void likeupdate(Review review);
    int likegetinfo(Review review);
}
