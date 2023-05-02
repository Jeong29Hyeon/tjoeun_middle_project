package com.controller;

import com.dto.Poster;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController {
    @RequestMapping(value = "/", method = {RequestMethod.GET, RequestMethod.POST})
    public String index(Model model) throws IOException {
        String currentMovieUrl = "http://www.cgv.co.kr/movies/";
        Document doc = Jsoup.connect(currentMovieUrl).get();
        Elements imgs = doc.select("span.thumb-image > img"); //포스터 이미지
        Elements ranks = doc.select(".rank"); //영화 순위
        Elements titles = doc.select("div.box-contents strong.title"); //제목
        Elements rateInfos = doc.select(".percent span"); //
        Elements openDateInfos = doc.select("span.txt-info > strong");
        //일단 10개 추후에 <더보기> 를 추가하는건 어떨까?
        List<Poster> posters = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            Poster poster = new Poster();
            poster.setSeq(i);
            poster.setImg(imgs.get(i).attr("src"));
            poster.setRank(ranks.get(i).text());
            poster.setTitle(titles.get(i).text());
            poster.setRateInfo(rateInfos.get(i).text());
            poster.setOpeningDate(openDateInfos.get(i).text());
            String url = imgs.get(i).attr("src");   //url자를려고 넣었음 ㅎㅎ
            String[] urlParts = url.split("/");     ///기준으로 잘랐는데 7번째가 영화 코드임 ^^
            poster.setDetailUrl(urlParts[7]);       // 그래서 7번째꺼 deatilUrl로 셋해줌
            posters.add(poster);
        }
        model.addAttribute("posters", posters);
        return "index";
    }

}
