package com.controller;

import com.dto.Cinema;
import com.dto.Poster;
import com.service.CinemaService;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ReserveController {
    CinemaService cinemaService;
    @Autowired
    public ReserveController(CinemaService cinemaService){
        this.cinemaService = cinemaService;
    }

    @GetMapping("/movieRoom")
    public String movieRoom(String title){
        return "/movie/movieRoom";
    }
    @RequestMapping(value = "/movieSelect", method = {RequestMethod.GET,RequestMethod.POST})
    public String selectTime(Model model, Cinema cinema) throws IOException {
        String currentMovieUrl = "http://www.cgv.co.kr/movies/";
        Document doc = Jsoup.connect(currentMovieUrl).get();
        Elements imgs = doc.select("span.thumb-image > img"); //포스터 이미지
        Elements ranks = doc.select(".rank"); //영화 순위
        Elements titles = doc.select("div.box-contents strong.title"); //제목
        Elements rateInfos = doc.select(".percent span"); //
        Elements openDateInfos = doc.select("span.txt-info > strong");
        //일단 10개 추후에 <더보기> 를 추가하는건 어떨까?
        List<Poster> posters = new ArrayList<>();
        for(int i = 0; i < 10; i++){
            Poster poster = new Poster();
            poster.setImg(imgs.get(i).attr("src"));
            poster.setRank(ranks.get(i).text());
            poster.setTitle(titles.get(i).text());
            poster.setRateInfo(rateInfos.get(i).text());
            poster.setOpeningDate(openDateInfos.get(i).text());
            posters.add(poster);
        }
        model.addAttribute("posters",posters);
//        Cinema cinemaInfo = cinemaService.select(cinema);
        model.addAttribute("cinemaList",cinemaService.selectAll(cinema));
        System.out.println(cinemaService.selectAll(cinema).get(0).getCinema_num());
        return "/movie/movieSelect";
    }
}
