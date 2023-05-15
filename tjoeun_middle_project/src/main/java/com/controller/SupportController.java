package com.controller;

import com.aop.AjaxUserIdCheck;
import com.aop.UserIdCheck;
import com.dto.Question;
import com.service.PageHandler;
import com.service.QuestionService;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/support")
public class SupportController {
    QuestionService questionService;

    @Autowired
    public SupportController(QuestionService questionService) {
        this.questionService = questionService;
    }

    @GetMapping("/list")
    public String supportList(Model model,Integer page){
        if(page==null) page = 1;
        try {
            int totalCnt = questionService.getTotalCnt();
            PageHandler pageHandler = new PageHandler(page,totalCnt);
            List<Question> questionList = questionService.getAllQuestion(page);
            model.addAttribute("ph",pageHandler);
            model.addAttribute("list",questionList);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "support/list";
    }

    @GetMapping("/write")
    @UserIdCheck
    public String writeForm(){
        return "support/write";
    }

    @PostMapping("/write")
    @ResponseBody
    @AjaxUserIdCheck
    public String supportWrite(Question question){
        try {
            questionService.insertQuestion(question);
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
        return "success";
    }
    @PostMapping("/password-check")
    @ResponseBody
    public Map<String,Object> passwordCheck(Integer password, Integer qno){
        Map<String,Object> map = new HashMap<>();
        try {
            Question question = questionService.getQuestionByQnoPw(qno,password);
            map.put("pw",question.getPassword());
            map.put("msg","success");
        } catch (Exception e) {
            e.printStackTrace();
            map.put("msg","fail");
            return map;
        }
        return map;
    }

    @GetMapping("/view")
    @UserIdCheck
    public String view(Integer qno, Integer page,Integer password,Model model){
        if(page==null){
            page = 1;
        }
        try {
            Question question = questionService.getQuestionByQnoPw(qno,password);
            model.addAttribute("question",question);
            model.addAttribute("page",page);
            model.addAttribute("password",password);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg","비밀번호가 일치하지 않습니다.");
            return "/support/list";
        }
        return "support/view";
    }


}
