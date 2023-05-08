package com.controller;

import com.dto.Movie;
//import com.dto.Ticket;
import com.dto.Ticket;
import com.service.MovieService;
import com.service.TicketService;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
@Controller
public class ReserveController {

    TicketService ticketService;
    MovieService movieService;
    @Autowired
    public ReserveController(TicketService ticketService, MovieService movieService) {
        this.ticketService = ticketService;
        this.movieService = movieService;
    }

    @PostMapping("/movieRoom")
    public String movieRoom(Model model, Ticket ticket, RedirectAttributes ra) {
        System.out.println("movieRoom ticket: "+ticket.toString());
        model.addAttribute("ticket", ticket);
        try {
            List<String> choiceSeatList = ticketService.selectChoiceSeats(ticket.getHallInfo(),ticket.getDayInfo(),ticket.getTimeInfo());
            if(choiceSeatList.isEmpty()){
                return "/movie/movieRoom";
            }
            Collections.sort(choiceSeatList);
            StringBuilder temp = new StringBuilder();
            for(String s : choiceSeatList){
                temp.append(s);
            }
            String[] choiceSeats = temp.toString().split(",");
            model.addAttribute("choiceSeats",choiceSeats);
        } catch (Exception e) {
            ra.addFlashAttribute("msg","좌석 선택 에러가 발생했습니다. 잠시 후 다시 시도해주세요.");
            return "redirect:/"; //에러가 발생했을때 에러창을 보여줘야함
        }
        return "/movie/movieRoom";
    }


    @PostMapping("/ticketing")
    @ResponseBody
    public Map<String,Object> ticketing(Ticket ticket){
        System.out.println("ticketing controller : "+ticket.toString());
        Map<String,Object> map = new HashMap<>();
        if(ticket.getId() == null){
            map.put("msg","ID_NULL_ERR");
            return map;
        }
        try {
            ticketService.insertTicket(ticket);
            map.put("msg","success");
            map.put("tno",ticket.getTno());
        } catch (Exception e) {
            e.printStackTrace();
            map.put("msg","SEATS_DUPLICATE_ERR");
            return map;
        }
        return map;
    }


    @RequestMapping(value = "/movieSelect", method = RequestMethod.GET)
    public String selectTime(Model model, String seq,String title) throws IOException {
        List<Movie> movies = new ArrayList<>();
        if(seq == null || title == null){
            movies = movieService.getMovies();
            model.addAttribute("movies",movies);
        }else{ // INDEX 페이지에서 각 영화의 예매하기 버튼을 눌렀을 때의 동작
            Movie movie = new Movie();
            movie.setSeq(seq);
            movie.setTitle(title);
            movies.add(movie);
            model.addAttribute("movies",movies);
        }

        ArrayList<String> weekOfDays = new ArrayList<>();
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat(
            "d일_E요일");      // 원래 d일(E)로 표현했으나 jquery에서 ()특수문자 못받아드림
        weekOfDays.add(0, sdf.format(cal.getTime()));
        for (int i = 1; i < 7; i++) {
            cal.add(Calendar.DAY_OF_WEEK, 1);
            weekOfDays.add(sdf.format(cal.getTime()));
        }
        model.addAttribute("dayList", weekOfDays);

        return "/movie/movieSelect";
    }

    @PostMapping("/deleteTicket")
    @ResponseBody
    public String deleteTicket(Integer tno){
        try {
            ticketService.deleteTicket(tno);
        }catch (Exception e){
            e.printStackTrace();
            return "fail";
        }
//        return "redirect:/user/ticketHistory";
        return "success";
    }

    @PostMapping("/payFail")
    @ResponseBody
    public String payFail(Integer tno){
        ticketService.deleteTicket(tno);
        return "success";
    }
}
