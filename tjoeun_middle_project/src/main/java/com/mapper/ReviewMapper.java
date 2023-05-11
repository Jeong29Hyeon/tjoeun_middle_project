package com.mapper;

import com.dto.Review;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReviewMapper {
    int insertReview(Review reviewDto);

    int updateReview(Review reviewDto);

    int deleteReview(Integer rno);
    void likeAdd(Review review);
    void likeSub(Review review);
    int likegetinfo(Review review);
    List<Review> selectAllBySeq(String seq);
//    int selectAll();
}
