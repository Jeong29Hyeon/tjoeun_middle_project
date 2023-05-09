package com.service;

import com.dto.Movie;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

@Service
public class MovieService {

    public List<Movie> getMovies() {
        List<Movie> movies = new ArrayList<>();
        String reqURL = "https://www.megabox.co.kr/on/oh/oha/Movie/selectMovieList.do";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            // 요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("content-Type",
                "application/x-www-form-urlencoded;charset=UTF-8");
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("currentPage=1");
            sb.append("&recordCountPerPage=10");
            sb.append("&pageType=ticketing");
            sb.append("&onairYn=Y");
            sb.append("&specialYn=N");
            bw.write(sb.toString());
            bw.flush();
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            StringBuilder result = new StringBuilder();

            while ((line = br.readLine()) != null) {
                result.append(line);
            }
            JSONParser jsonParser = new JSONParser();
            JSONObject obj = (JSONObject) jsonParser.parse(result.toString());
            JSONArray movieList = (JSONArray) obj.get("movieList");
            for(Object o : movieList){
                JSONObject eachMovie = (JSONObject) o;
                Movie movie = new Movie();
                movie.setSeq(eachMovie.get("movieNo").toString());
                movie.setImg("https://img.megabox.co.kr"+eachMovie.get("imgPathNm").toString());
                movie.setRank(eachMovie.get("boxoRank").toString());
                movie.setTitle(eachMovie.get("movieNm").toString());
                movie.setRateInfo(eachMovie.get("boxoBokdRt").toString());
                movie.setOpeningDate(eachMovie.get("rfilmDe").toString());
                movies.add(movie);
            }
        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
        return movies;
    }

    public Movie getMovie(String seq){
        String reqURL = "https://www.megabox.co.kr/on/oh/oha/Movie/selectMovieList.do";
        Movie movie = new Movie();
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            // 요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("content-Type",
                "application/x-www-form-urlencoded;charset=UTF-8");
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("currentPage=1");
            sb.append("&recordCountPerPage=10");
            sb.append("&pageType=ticketing");
            sb.append("&onairYn=Y");
            sb.append("&specialYn=N");
            bw.write(sb.toString());
            bw.flush();
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            StringBuilder result = new StringBuilder();

            while ((line = br.readLine()) != null) {
                result.append(line);
            }
            JSONParser jsonParser = new JSONParser();
            JSONObject obj = (JSONObject) jsonParser.parse(result.toString());
            JSONArray movieList = (JSONArray) obj.get("movieList");
            for(Object o : movieList){
                JSONObject eachMovie = (JSONObject) o;
                if(eachMovie.get("movieNo").toString().equals(seq)){
                    movie.setSeq(eachMovie.get("movieNo").toString());
                    movie.setImg("https://img.megabox.co.kr"+eachMovie.get("imgPathNm").toString());
                    movie.setRank(eachMovie.get("boxoRank").toString());
                    movie.setTitle(eachMovie.get("movieNm").toString());
                    movie.setRateInfo(eachMovie.get("boxoBokdRt").toString());
                    movie.setOpeningDate(eachMovie.get("rfilmDe").toString());
                    break;
                }
            }
        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
        return getMovieInfo(movie);
    }

    private Movie getMovieInfo(Movie movie){
        try {
            Document doc = Jsoup.connect("https://www.megabox.co.kr/on/oh/oha/Movie/selectMovieInfo.do")
                .data("rpstMovieNo",movie.getSeq()).post();
            String movieStory = doc.select("div.inner-wrap div.movie-summary div.txt").text();
            System.out.println("movieStory = " + movieStory);
            String detailInfo = doc.select("div.inner-wrap div.movie-info div.line").text();
            String su = doc.select("div.inner-wrap div.movie-graph div:nth-child(3) dd.font-roboto").text();
            movie.setStory(movieStory);
            movie.setCumulativeUser(su);
            movie.setDetailInfo(detailInfo);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return movie;
    }
}
