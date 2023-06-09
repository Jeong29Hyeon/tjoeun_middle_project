package com.controller;

import com.aop.UserIdCheck;
import com.dto.Movie;
//import com.dto.Ticket;
import com.dto.Payment;
import com.dto.Ticket;
import com.dto.User;
import com.service.MovieService;
import com.service.PaymentService;
import com.service.TicketService;
import java.util.Collections;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import com.service.UserService;
import java.util.TimeZone;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class ReserveController {

    TicketService ticketService;
    MovieService movieService;
    UserService userService;
    PaymentService paymentService;
    @Autowired
    public ReserveController(TicketService ticketService, MovieService movieService,UserService userService,
        PaymentService paymentService) {
        this.ticketService = ticketService;
        this.movieService = movieService;
        this.userService = userService;
        this.paymentService = paymentService;
    }



    @PostMapping("/movieRoom")
    public String movieRoom(Model model, Ticket ticket, String userId, RedirectAttributes ra, String movieSeq) {
        System.out.println("movieRoom ticket: "+ticket.toString());
        model.addAttribute("ticket", ticket);
        model.addAttribute("userId",userId);
        System.out.println(movieSeq);
        model.addAttribute("movie",movieService.getMovie(movieSeq));
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
    public Map<String,Object> ticketing(Ticket ticket, String imp_uid, Integer paid_amount, HttpSession session){
        System.out.println("ticketing controller : "+ticket.toString());
        System.out.println("imp_uid = " + imp_uid);
        Map<String,Object> map = new HashMap<>();
        try {
            if(paid_amount == null) {
                paid_amount = ticket.getPrice();
            }
            ticketService.insertTicket(ticket, imp_uid, paid_amount);
            //예매후 금액에 따른 등급 뉴 유저 업데이트
            User user = (User) session.getAttribute("user");
            int sumPrice = ticketService.sumPrice(user.getId());
            User updateUser = new User(user.getId(),user.getPassword(),user.getName(), user.getBirth(), user.getGender(), user.getEmail(), user.getPhone(), userService.updateRank(user.getId(),sumPrice), user.getReg_day());
            session.setAttribute("user",updateUser);
            map.put("msg","success");
        } catch (Exception e) {
            e.printStackTrace();
            String accessToken = paymentService.getAccessToken();
            paymentService.payCancel(accessToken,imp_uid);
            map.put("msg","SEATS_DUPLICATE_ERR");
            return map;
        }
        return map;
    }

    @GetMapping("/mobile-ticketing")
    public String mobileTicketing(Ticket ticket, String imp_uid,boolean imp_success, HttpSession session,
        RedirectAttributes ra){
        System.out.println("Mobile ticketing controller : "+ticket.toString());
        System.out.println("imp_uid = " + imp_uid);
        try {
            if(imp_success){
                ticketService.insertTicket(ticket, imp_uid, ticket.getPrice());
                //예매후 금액에 따른 등급 뉴 유저 업데이트
                User user = (User) session.getAttribute("user");
                int sumPrice = ticketService.sumPrice(user.getId());
                User updateUser = new User(user.getId(),user.getPassword(),user.getName(), user.getBirth(), user.getGender(), user.getEmail(), user.getPhone(), userService.updateRank(user.getId(),sumPrice), user.getReg_day());
                session.setAttribute("user",updateUser);
                ra.addFlashAttribute("msg","영화 예매가 완료되었습니다. 티켓정보는 내정보에서 확인하세요");
            }else{
                ra.addFlashAttribute("msg","결제를 취소하셨습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            String accessToken = paymentService.getAccessToken();
            paymentService.payCancel(accessToken,imp_uid);
            ra.addFlashAttribute("msg","이미 결제된 좌석입니다, 처음부터 다시 예약을 진행해주세요.");
            return "redirect:/";
        }
        return "redirect:/";
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
            "d일 E요일",Locale.KOREA);      // 원래 d일(E)로 표현했으나 jquery에서 ()특수문자 못받아드림
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
    public String deleteTicket(Integer tno, HttpSession session){
        int sumPrice = 0;
        try {
            String accessToken = paymentService.getAccessToken();
            String imp_uid = paymentService.getImpUidByTno(tno);
            paymentService.payCancel(accessToken,imp_uid);
            ticketService.deleteTicket(tno);
            //삭제후 금액에 따른 등급 뉴 유저 업데이트
            User user = (User) session.getAttribute("user");
            sumPrice = ticketService.sumPrice(user.getId());
            userService.updateRank(user.getId(),sumPrice);
            User updateUser = new User(user.getId(),user.getPassword(),user.getName(), user.getBirth(), user.getGender(), user.getEmail(), user.getPhone(), userService.updateRank(user.getId(),sumPrice), user.getReg_day());
            session.setAttribute("user",updateUser);
        }catch (Exception e){
            e.printStackTrace();
            return "fail";
        }
        return "success";
    }


}
