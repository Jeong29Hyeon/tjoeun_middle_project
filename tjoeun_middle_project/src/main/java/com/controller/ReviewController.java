package com.controller;

import com.dto.Review;
import com.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@RequestMapping("/review")
@Controller
public class ReviewController {
    ReviewService reviewService;
    @Autowired
    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
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

}
