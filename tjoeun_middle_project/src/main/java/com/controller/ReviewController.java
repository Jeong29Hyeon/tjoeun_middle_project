package com.controller;

import com.dto.Like;
import com.dto.Review;
import com.service.LikeService;
import com.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@RequestMapping("/review")
@Controller
public class ReviewController {
    ReviewService reviewService;
    LikeService likeService;

    @Autowired
    public ReviewController(ReviewService reviewService, LikeService likeService) {
        this.reviewService = reviewService;
        this.likeService = likeService;
    }


    @PostMapping("/write")
    @ResponseBody
    public String writeReview(Review review){
        try {
            reviewService.insertReview(review);
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
        return "success";
    }

    @PostMapping("/edit")
    @ResponseBody
    public String editReview(Review review){
        try {
            reviewService.updateReview(review);
        } catch (Exception e) {
            return "fail";
        }
        return "success";
    }
    @PostMapping("/delete")
    @ResponseBody
    public String deleteReview(Integer rno){
        try {
            reviewService.deleteReview(rno);
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
        return "success";
    }

    //댓글 좋아요 컨트롤러가 따로필요한가? 여기다 하면 안되나?
    @PostMapping("/update")
    @ResponseBody
    public int likeupdate(Review review){
        Like temp;
        try {
            temp = likeService.likeselect(review);
            if(temp == null){
                int result = likeService.likeinsert(review);
                reviewService.likeAdd(review);
                return 1;
            }else {
                likeService.likedelete(review);
                reviewService.likeSub(review);
                return 0;
            }

        }catch(Exception e) {
            e.printStackTrace();
            return 0;
        }

    }


}
