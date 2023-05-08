package com.controller;

import com.dto.Like;
import com.dto.Movie;
import com.dto.Review;
import com.mapper.ReviewMapper;
import com.service.LikeService;
import com.service.MovieService;
import com.service.ReviewService;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@RequestMapping("/movies")
@Controller
public class DetailController {

    ReviewService reviewService;
    LikeService likeService;

    MovieService movieService;
    @Autowired
    public DetailController(ReviewService reviewService, LikeService likeService,
        MovieService movieService) {
        this.reviewService = reviewService;
        this.likeService = likeService;
        this.movieService = movieService;
    }




    //일단 테스트로 다 긁어옴
    @RequestMapping(value = "/detail-view", method = {RequestMethod.GET, RequestMethod.POST})
    public String index(Model model, String seq) throws IOException {
        Movie movie = movieService.getMovie(seq);
        List<Review> reviewList = new ArrayList<>();
        try {
            reviewList = reviewService.selectAllBySeq(seq);
        } catch (Exception e) {
            e.printStackTrace();
            //에러 잡아야함
        }
        //댓글들 다 가져오고
        model.addAttribute("movie", movie);
        model.addAttribute("reviewList", reviewList);

        //좋아요 컨트롤러 추가
        List<Like> likeList = new ArrayList<>();
        for (Review review : reviewList) {
            Like like = new Like();

            like.setReviewno(review.getRno());       //rno 가져와야되는데 방법 생각하기
            like.setUserid(review.getId());         //유저 아이디도 가져와야하는데 여기가 아닌가?

            int ltlike = 0;

            try {
                int check = likeService.ltlikecount(like);

                if (check == 0) {

                    likeService.likeinsert(like);

                } else if (check == 1) {

                    ltlike = likeService.ltlikegetinfo(like);
                    like.setItlike(ltlike);

                }
            } catch (Exception ignored) {
            }
            likeList.add(like);
        }
        model.addAttribute("ltlike", likeList);
        //좋아요 컨트롤러


        return "detail";
    }


}
