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
    public String writeComment(Review review){
        try {
            reviewService.insertComment(review);
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
        return "success";
    }

    @PostMapping("/edit")
    @ResponseBody
    public String editComment(Review review){
        try {
            reviewService.updateComment(review);
        } catch (Exception e) {
            return "fail";
        }
        return "success";
    }
    @PostMapping("/delete")
    @ResponseBody
    public String deleteComment(Integer rno){
        try {
            reviewService.deleteComment(rno);
        } catch (Exception e) {
            return "fail";
        }
        return "success";
    }

}
