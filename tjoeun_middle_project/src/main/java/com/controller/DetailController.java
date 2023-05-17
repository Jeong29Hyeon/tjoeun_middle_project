package com.controller;

import com.dto.Like;
import com.dto.Movie;
import com.dto.Review;
import com.dto.User;
import com.mapper.ReviewMapper;
import com.service.LikeService;
import com.service.MovieService;
import com.service.ReviewService;
import org.checkerframework.checker.units.qual.A;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
    public String index(Model model, String seq, HttpSession session) {
        Movie movie = movieService.getMovie(seq);
        List<Review> reviewList = new ArrayList<>();
        List<Like> likeList = new ArrayList<>();
        String userId = "";
        if(session.getAttribute("user") != null){
            User user = (User) session.getAttribute("user");
            userId = user.getId();
        }

        try {
            likeList = likeService.selectByUserIdSeq(userId, seq);
            reviewList = reviewService.selectAllBySeq(seq);
        } catch (Exception e) {
            e.printStackTrace();
            //에러 잡아야함
        }
        //댓글들 다 가져오고
        model.addAttribute("likeList", likeList);
        model.addAttribute("movie", movie);
        model.addAttribute("reviewList", reviewList);

        //좋아요 컨트롤러 추가
        return "detail";
    }


}
