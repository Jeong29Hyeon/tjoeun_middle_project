package com.controller;

import com.dto.Coupon;
import com.dto.User;
import com.service.CouponService;
import com.service.TicketService;
import com.service.UserService;

import java.util.*;
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

    CouponService couponService;

    @Autowired
    public UserController(UserService userService, TicketService ticketService, CouponService couponService) {
        this.userService = userService;
        this.ticketService = ticketService;
        this.couponService = couponService;
    }


    @GetMapping("/join")
    public String register() {
        return "join";
    }

    @PostMapping("/join")
    public String register(User user, HttpServletRequest request, Model model) {
        String birth = request.getParameter("year") + "-" + request.getParameter("month") + "-" + request.getParameter("day");
        String email = request.getParameter("email1") + "@" + request.getParameter("email2");
        user.setBirth(birth);
        user.setEmail(email);
        try {
            userService.register(user);
        } catch (Exception e) {
            model.addAttribute("msg", "가입 에러, 재시도");
            return "join";
        }
        model.addAttribute("msg", "환영합니다 회원가입이 완료 되었습니다!");
        return "redirect:/";
    }

    @PostMapping("/duplicateCheck")
    @ResponseBody
    public String duplicateIdCheck(String id) {
        return userService.idCheck(id);
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        if (session.getAttribute("accessToken") != null) {
            return "redirect:https://kauth.kakao.com/oauth/logout?client_id=e765b37b419e417d6a4d99f777b7eac2&logout_redirect_uri=http://localhost:8080/user/kakaoLogout";
        }
        session.invalidate();
        return "redirect:/";
    }

    @PostMapping("/login")
    public String login(String id, String password, String toUrl, boolean saveId, HttpServletRequest request,
                        HttpServletResponse response, RedirectAttributes ra) {
        try {
            User user = userService.login(id, password);
            request.getSession().setAttribute("user", user);
            ra.addFlashAttribute("msg", user.getName() + "님 환영합니다!");
        } catch (Exception e) {
            ra.addFlashAttribute("msg", "ID/PW가 일치하지 않습니다.");
            return "redirect:/user/login?toUrl=" + toUrl;
        }
        Cookie cookie = new Cookie("id", id);
        if (saveId) {
            response.addCookie(cookie);
        } else {
            cookie.setMaxAge(0);
            response.addCookie(cookie);
        }

        return "redirect:" + (toUrl == null || toUrl.equals("") ? '/' : toUrl.replace("-", "&"));
    }

    @PostMapping("/loginModal")
    @ResponseBody
    public String loginModal(String id, String password, boolean saveId, HttpServletRequest request, HttpServletResponse response) {
        System.out.println("로그인 모달 요청값: " + id + password + saveId);
        try {
            User user = userService.login(id, password);
            request.getSession().setAttribute("user", user);
            Cookie cookie = new Cookie("id", id);
            if (saveId) {
                response.addCookie(cookie);
            } else {
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
        } catch (Exception e) {
            return "fail";
        }
        return "success";
    }

    @GetMapping("/ticketHistory")
    public String ticketHistory(HttpSession session, Model model) {
        String userId = "";
        if (session.getAttribute("accessToken") != null) {
            Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
            userId = (String) user.get("id");
        } else {
            User user = (User) session.getAttribute("user");
            userId = user.getId();
        }
        model.addAttribute("pastTicketList", ticketService.pastTicketById(userId));
        model.addAttribute("currentTicketList", ticketService.currentTicketById(userId));
        model.addAttribute("futureTicketList", ticketService.futureTicketById(userId));
        return "movie/ticketHistory";
    }

    @GetMapping("/kakaoLogin")
    public String kakaoLogin() {
        return "redirect:https://kauth.kakao.com/oauth/authorize?client_id=e765b37b419e417d6a4d99f777b7eac2&redirect_uri=http://localhost:8080/user/kakaoAuth&response_type=code";
    }

    @GetMapping("/kakaoLogout")
    public String kakaoLogout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/kakaoAuth")
    public String kakaoAuth(@RequestParam(value = "code", required = false) String code, HttpSession session, RedirectAttributes ra) {
        if (code == null) {
            ra.addFlashAttribute("msg", "카카오 로그인을 취소하였습니다.");
            return "redirect:/";
        }
        System.out.println("code = " + code);
        String accessToken = userService.getAccessToken(code);
        System.out.println("accessToken = " + accessToken);
        session.setAttribute("accessToken", accessToken);
        HashMap<String, Object> user = userService.getUserInfo(accessToken);
        System.out.println("accessToken = " + accessToken);
        System.out.println("nickname : " + user.get("name"));
        System.out.println("mail : " + user.get("id"));
        session.setAttribute("user", user);
        return "redirect:/";
    }

    @GetMapping("/searchIdPw")
    public String searchIdPw() {
        return "/searchIdPw";
    }

    @PostMapping("/searchIdPw")
    public String searchIdPw(User user, Model model, RedirectAttributes ra, HttpServletRequest request) {
        if (userService.searchIdPw(user) == null) {
            ra.addFlashAttribute("msg", "정보가 불일치 합니다.");
            return "redirect:/user/searchIdPw";
        }
        User searchUser = userService.searchIdPw(user);
        model.addAttribute("user", searchUser);
        return "/searchIdPw";
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        String id = "";
        if (session.getAttribute("accessToken") != null) {
            Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
            id = (String) user.get("id");
        } else {
            User user = (User) session.getAttribute("user");
            id = user.getId();
            System.out.println("couponService.selectAllById(id).get(0).getGoods().getPrice() = " + couponService.selectAllById(id).get(0).getGoods().getPrice());
            model.addAttribute("couponList", couponService.selectAllById(id));
        }

        model.addAttribute("ticketHistory", ticketService.selectById(id));

        int price = ticketService.sumPrice(id);
        if (price < 100000) {
            model.addAttribute("sumPrice", ticketService.sumPrice(id));
            model.addAttribute("rank", "BRONZE");
            model.addAttribute("nextRank", 100000 - price);
            model.addAttribute("gage", "20%");
            return "/profile";
        } else if (price < 200000) {
            model.addAttribute("sumPrice", ticketService.sumPrice(id));
            model.addAttribute("rank", "SILVER");
            model.addAttribute("nextRank", 200000 - price);
            model.addAttribute("gage", "40%");
            return "/profile";
        } else if (price < 300000) {
            model.addAttribute("sumPrice", ticketService.sumPrice(id));
            model.addAttribute("rank", "GOLD");
            model.addAttribute("nextRank", 300000 - price);
            model.addAttribute("gage", "60%");
            return "/profile";
        } else if (price < 400000) {
            model.addAttribute("sumPrice", ticketService.sumPrice(id));
            model.addAttribute("rank", "VIP");
            model.addAttribute("nextRank", 400000 - price);
            model.addAttribute("gage", "80%");
            return "/profile";
        } else {
            model.addAttribute("sumPrice", ticketService.sumPrice(id));
            model.addAttribute("rank", "VVIP");
            model.addAttribute("nextRank", -1);
            model.addAttribute("gage", "100%");
            return "/profile";
        }
    }

    @PostMapping("/updateInfo")
    @ResponseBody
    public String updateInfo(User newUser, HttpSession session) {
        try {
            userService.updateInfo(newUser);
            session.setAttribute("user", newUser);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return "fail";
        }
        return "success";
    }

    @GetMapping("/couponRoom")
    public String couponRoom(Model model, HttpSession session) {
        Date now = new Date();
        Date coupon;
        User user = (User) session.getAttribute("user");
        List<Coupon> list = couponService.selectAllById(user.getId());
        List<Coupon> useCoupon = new ArrayList<>();
        List<Coupon> ableCoupon = new ArrayList<>();
        try {
            for (int i = 0; i < list.size(); i++) {
                coupon = list.get(i).getExpireDate();
                if (coupon.after(now)) {
                    System.out.println(i + " after: " + coupon);
                    useCoupon.add(list.get(i));
                } else {
                    System.out.println(i + " before: " + coupon);
                    ableCoupon.add(list.get(i));
                }
            }
            model.addAttribute("falseCoupon", useCoupon);
            model.addAttribute("trueCoupon", ableCoupon);
            return "store/couponRoom";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "store/couponRoom";
    }
}
