package com.controller;

import com.dto.User;
import com.service.TicketService;
import com.service.UserService;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/user")
public class UserController {
    UserService userService;
    TicketService ticketService;
    @Autowired
    public UserController(UserService userService, TicketService ticketService) {
        this.userService = userService;
        this.ticketService = ticketService;
    }

    @GetMapping("/join")
    public String register(){
        return "join";
    }

    @PostMapping("/join")
    public String register(User user, HttpServletRequest request, Model model){
        String birth = request.getParameter("year")+"-"+request.getParameter("month")+"-"+request.getParameter("day");
        String email = request.getParameter("email1")+"@"+request.getParameter("email2");
        user.setBirth(birth);
        user.setEmail(email);
        try{
            userService.register(user);
        }catch (Exception e){
            model.addAttribute("msg","가입 에러, 재시도");
            return "join";
        }
        model.addAttribute("msg","환영합니다 회원가입이 완료 되었습니다!");
        return "redirect:/";
    }

    @PostMapping("/duplicateCheck")
    @ResponseBody
    public String duplicateIdCheck(String id){
        return userService.idCheck(id);
    }

    @GetMapping("/login")
    public String login(){
        return "login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session){
        if(session.getAttribute("accessToken") != null){
            return "redirect:https://kauth.kakao.com/oauth/logout?client_id=e765b37b419e417d6a4d99f777b7eac2&logout_redirect_uri=http://localhost:8080/user/kakaoLogout";
        }
        session.invalidate();
        return "redirect:/";
    }

    @PostMapping("/login")
    public String login(String id, String password, String toUrl,boolean saveId, HttpServletRequest request,
        HttpServletResponse response, RedirectAttributes ra){
        try {
            User user = userService.login(id,password);
            request.getSession().setAttribute("user",user);
            ra.addFlashAttribute("msg",user.getName()+"님 환영합니다!");
        } catch (Exception e) {
            ra.addFlashAttribute("msg","ID/PW가 일치하지 않습니다.");
            return "redirect:/user/login";
        }
        Cookie cookie = new Cookie("id", id);
        if(saveId) {
            response.addCookie(cookie);
        }else{
            cookie.setMaxAge(0);
            response.addCookie(cookie);
        }

        return "redirect:"+(toUrl == null || toUrl.equals("") ? '/' : toUrl.replace("-","&"));
    }

    @PostMapping("/loginModal")
    @ResponseBody
    public String loginModal(String id, String password,boolean saveId,HttpServletRequest request,HttpServletResponse response){
        System.out.println("로그인 모달 요청값: " + id + password + saveId);
        try {
            User user = userService.login(id,password);
            request.getSession().setAttribute("user",user);
            Cookie cookie = new Cookie("id", id);
            if(saveId) {
                response.addCookie(cookie);
            }else{
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
        } catch (Exception e) {
            return "fail";
        }
        return "success";
    }
    @GetMapping("/ticketHistory")
    public String ticketHistory(HttpSession session, Model model){
        String userId="";
        if(session.getAttribute("accessToken")!=null){
           Map<String,Object> user = (Map<String, Object>) session.getAttribute("user");
            userId = (String) user.get("id");
        }else{
            User user = (User)session.getAttribute("user");
            userId = user.getId();
        }
        model.addAttribute("pastTicketList", ticketService.pastTicketById(userId));
        model.addAttribute("currentTicketList",ticketService.currentTicketById(userId));
        model.addAttribute("futureTicketList",ticketService.futureTicketById(userId));
        return "movie/ticketHistory";
    }

    @GetMapping("/kakaoLogin")
    public String kakaoLogin(){
        return "redirect:https://kauth.kakao.com/oauth/authorize?client_id=e765b37b419e417d6a4d99f777b7eac2&redirect_uri=http://localhost:8080/user/kakaoAuth&response_type=code";
    }

    @GetMapping("/kakaoLogout")
    public String kakaoLogout(HttpSession session){
//        String accessToken = (String) session.getAttribute("accessToken");
//        userService.kakaoLogout(accessToken);
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/kakaoAuth")
    public String kakaoAuth(@RequestParam(value = "code",required = false)String code, HttpSession session,RedirectAttributes ra){
        if(code==null){
            ra.addFlashAttribute("msg","카카오 로그인을 취소하였습니다.");
            return "redirect:/";
        }
        System.out.println("code = " + code);
        String accessToken = userService.getAccessToken(code);
        System.out.println("accessToken = " + accessToken);
        session.setAttribute("accessToken",accessToken);
        HashMap<String, Object> user = userService.getUserInfo(accessToken);
        System.out.println("accessToken = " + accessToken);
        System.out.println("nickname : " + user.get("name"));
        System.out.println("mail : " + user.get("id"));
        session.setAttribute("user",user);
        return "redirect:/";
    }


}
