package com.controller;

import com.dto.User;
import com.service.UserService;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/user")
public class UserController {
    UserService userService;
    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
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
    public String logout(HttpServletRequest request){
        request.getSession().invalidate();
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
            return "redirect:/";
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



}
