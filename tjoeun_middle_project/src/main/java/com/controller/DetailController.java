package com.controller;

import com.dto.Poster;
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
    public String index(Model model,String detailUrl) throws IOException {
        Document doc = Jsoup.connect("http://www.cgv.co.kr/movies/detail-view/?midx="+detailUrl).get(); //url설정
        Elements imgs = doc.select("span.thumb-image > img"); //포스터 이미지
//        Elements ranks = doc.select(".rank"); //영화 순위
        Elements titles = doc.select("div.title strong"); //제목
//        Elements rateInfos = doc.select(".percent span"); //
//        Elements openDateInfos = doc.select("span.txt-info > strong");
        Elements story = doc.select("div.sect-story-movie");    //줄거리
        System.out.println(titles.get(0).text());
        System.out.println(story.get(0).text());
        System.out.println("test2^^");
        //디테일이니까 하나만 가져오고 싶은데
        Poster poster = new Poster();
        poster.setImg(imgs.get(0).attr("src"));
//        poster.setRank(ranks.text());
        poster.setTitle(titles.get(0).text());
//        poster.setRateInfo(rateInfos.text());
//        poster.setOpeningDate(openDateInfos.text());
        poster.setStory(story.get(0).text());

        model.addAttribute("poster", poster);
        return "detail";
    }
}
