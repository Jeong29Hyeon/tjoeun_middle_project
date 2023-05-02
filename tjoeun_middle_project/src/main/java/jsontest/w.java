package jsontest;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.JSONPObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;

public class w {
    public static void main(String[] args) throws IOException {
        // CGV 용산아이파크몰의 areaCode, theaterCode
        String areaCode = "01";
        String theaterCode = "0013";
        String date = "20230503";
        String crawlingURL = "https://ticket.cgv.co.kr/Reservation/Reservation.aspx?AREA_CD="
                + areaCode
                + "&THEATER_CD=" + theaterCode
                + "&PLAY_YMD=" + date;
//        Document document = Jsoup.connect("https://www.megabox.co.kr/on/oh/ohc/Brch/schedulePage.do").data("brchNo","0023")
//                                .data("brchNo1","0023").data("crtDe","20230502").data("detailType","area").data("firstAt","N").data("masterType","brch").data("playDe","20230503").post();
        String document = Jsoup.connect("https://www.megabox.co.kr/on/oh/ohc/Brch/schedulePage.do").data("brchNo","0023").data("brchNo1","0023").data("crtDe","20230502").data("detailType","area").data("firstAt","N").data("masterType","brch").data("playDe","20230503").ignoreContentType(true).execute().body();
//        String documentDecoore = URLDecoder.encod(document);
        ObjectMapper mapper = new ObjectMapper();

        JSONPObject json = new JSONPObject("JSON.parse", document);

        String jsonStr = mapper.writeValueAsString(json);
        System.out.println(document);
        System.out.println(jsonStr);
        System.out.println(json);

//        System.out.println(document);   //테슽

//        Elements showTimeTablesForMovies = document.getElementsByClass("col-times");
//        ArrayList<MovieTime> movieTimes= new ArrayList<MovieTime>();
//        for(Element showTimeTablesForMovie : showTimeTablesForMovies){
//
//            String movieTitle = showTimeTablesForMovie.select("#movie_list > ul > li.press.selected > a > span.text").text();
//
//            Elements showTimeTablesForHallTypes = showTimeTablesForMovie.getElementsByClass("type-hall");
//            // 상영관 별 영화 스케줄들 파싱
//            for(Element showTimeTablesForHallType : showTimeTablesForHallTypes){
//                // 상영관 정보
//                Elements infoHall = showTimeTablesForHallType.select(".info-hall li");
//                String hallType = infoHall.get(0).text();
//                String hallName = infoHall.get(1).text();
//
//                Elements infoTimeTables = showTimeTablesForHallType.select(".info-timetable li");
//                Integer a = 0;
//                for(Element availableTime : infoTimeTables){
//                    String time = availableTime.getElementsByTag("em").text();
//                    String availableSeats = availableTime.getElementsByTag("span").text();
//                    String href = availableTime.getElementsByTag("a").attr("abs:href");
//
//                    movieTimes.add(new MovieTime(movieTitle,hallType,hallName,time,availableSeats));
//                }
//            }
//        }
//        for(MovieTime movieTime:movieTimes){
//            System.out.println(movieTime.toString());
//        }
    }
}
