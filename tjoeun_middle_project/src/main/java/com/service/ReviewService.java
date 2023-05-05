package com.service;

import com.dto.Review;
import com.mapper.ReviewMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewService {
    ReviewMapper reviewMapper;
    @Autowired
    public ReviewService(ReviewMapper reviewMapper) {
        this.reviewMapper = reviewMapper;
    }

    public void insertReview(Review reviewDto) throws Exception {
        int result = reviewMapper.insertReview(reviewDto);
        if(result == 0){
            throw new Exception("댓글작성 실패");
        }
    }

    public void updateReview(Review reviewDto) throws Exception {
        int result = reviewMapper.updateReview(reviewDto);
        if(result == 0){
            throw new Exception("댓글 수정 실패");
        }
    }

    public void deleteReview(Integer rno) throws Exception {
        int result = reviewMapper.deleteReview(rno);
        if(result == 0){
            throw new Exception("댓글 삭제 실패");
        }
    }

    public List<Review> selectAllBySeq(Integer seq) throws Exception{
        return reviewMapper.selectAllBySeq(seq);
    }
}
