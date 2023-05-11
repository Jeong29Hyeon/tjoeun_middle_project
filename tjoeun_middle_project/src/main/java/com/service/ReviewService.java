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

    public List<Review> selectAllBySeq(String seq) throws Exception{
        return reviewMapper.selectAllBySeq(seq);
    }
    //좋아요 기능 수정중
    public int likegetinfo(Review review) {
        try {

            return reviewMapper.likegetinfo(review);
        } catch (Exception e) {
            System.out.println("getInfo fail");
            e.printStackTrace();
        }

        return 0;
    }
    public void likeAdd(Review review) {
        try {

            reviewMapper.likeAdd(review);
        } catch (Exception e) {
            System.out.println("update fail");
            e.printStackTrace();
        }
    }

    public void likeSub(Review review) {
        try {

            reviewMapper.likeSub(review);
        } catch (Exception e) {
            System.out.println("update fail");
            e.printStackTrace();
        }
    }
}
