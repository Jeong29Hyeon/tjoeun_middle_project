package com.controller;

import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class adminController {
    UserService userService;

    @Autowired
    public adminController(UserService userService) {
        this.userService = userService;
    }
    @GetMapping("/user-management")
    public String adminView(){
        return "adminView/userManagement";
    }
}
