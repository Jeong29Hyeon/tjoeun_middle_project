package com.controller;

import com.dto.Movie;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.IOException;

@RequestMapping("/movies")
@Controller
public class DetailController {

    //일단 테스트로 다 긁어옴
    @RequestMapping(value = "/detail-view", method = {RequestMethod.GET, RequestMethod.POST})
    public String index(Model model,String seq) throws IOException {
        Document doc = Jsoup.connect("http://www.cgv.co.kr/movies/detail-view/?midx="+seq).get(); //url설정
        Elements imgs = doc.select("span.thumb-image > img"); //포스터 이미지
//        Elements ranks = doc.select(".rank"); //영화 순위
        Elements titles = doc.select("div.title strong"); //제목
//        Elements rateInfos = doc.select(".percent span"); //
//        Elements openDateInfos = doc.select("span.txt-info > strong");
        Elements story = doc.select("div.sect-story-movie");    //줄거리
        //디테일이니까 하나만 가져오고 싶은데
        Movie movie = new Movie();
        movie.setImg(imgs.get(0).attr("src"));
//        movie.setRank(ranks.text());
        movie.setTitle(titles.get(0).text());
//        movie.setRateInfo(rateInfos.text());
//        movie.setOpeningDate(openDateInfos.text());
        movie.setStory(story.get(0).text());

        model.addAttribute("movie", movie);
        return "detail";
    }
}
