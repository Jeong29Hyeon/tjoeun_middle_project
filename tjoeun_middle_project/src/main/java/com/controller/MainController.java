package com.controller;

import com.dto.Movie;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
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
        List<Movie> movies = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            Movie movie = new Movie();
            String url = imgs.get(i).attr("src");   //url자를려고 넣었음 ㅎㅎ
            String[] urlParts = url.split("/");     ///기준으로 잘랐는데 7번째가 영화 코드임 ^^
            movie.setSeq(Integer.parseInt(urlParts[7]));
            movie.setImg(imgs.get(i).attr("src"));
            movie.setRank(ranks.get(i).text());
            movie.setTitle(titles.get(i).text());
            movie.setRateInfo(rateInfos.get(i).text());
            movie.setOpeningDate(openDateInfos.get(i).text());
            movies.add(movie);
        }
        model.addAttribute("movies", movies);
        return "index";
    }

}
