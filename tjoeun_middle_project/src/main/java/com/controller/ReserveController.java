package com.controller;

import com.dto.Movie;
//import com.dto.Ticket;
import com.dto.Ticket;
import com.service.HallService;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

@Controller
public class ReserveController {
    HallService hallMapper;

    @Autowired
    public ReserveController(HallService hallMapper) {
        this.hallMapper = hallMapper;
    }

    @GetMapping("/movieRoom")
    public String movieRoom() {
        return "/movie/movieRoom";
    }

    @PostMapping("/movieRoom")
    public String movieRoom(Model model, Ticket ticket,
                            String titleInfo,String hallInfo, String dayInfo, String timeInfo) {
        System.out.println(titleInfo);
        System.out.println(hallInfo);
        System.out.println(dayInfo);
        System.out.println(timeInfo);
        model.addAttribute("ticket",ticket);
        return "/movie/movieRoom";
    }

    @RequestMapping(value = "/movieSelect", method = RequestMethod.GET)
    public String selectTime(Model model, String seq, Movie m) throws IOException {
        if (seq == null) {
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
        } else {
            System.out.println(m.getSeq());
            System.out.println(m.getTitle());
            model.addAttribute("movie", m);
        }
        model.addAttribute("hallList", hallMapper.selectAll());

        ArrayList<String> list = new ArrayList<>();
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("d일_E요일");      // 원래 d일(E)로 표현했으나 jquery에서 ()특수문자 못받아드림
        list.add(0, sdf.format(cal.getTime()));
        for (int i = 1; i < 7; i++) {
            cal.add(Calendar.DAY_OF_WEEK, 1);
            list.add(sdf.format(cal.getTime()));
        }
        model.addAttribute("dayList", list);

        return "/movie/movieSelect";
    }
}
