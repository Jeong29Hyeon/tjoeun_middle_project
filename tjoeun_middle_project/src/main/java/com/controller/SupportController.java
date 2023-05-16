package com.controller;

import com.aop.AjaxUserIdCheck;
import com.aop.UserIdCheck;
import com.dto.Answer;
import com.dto.Question;
import com.dto.User;
import com.service.AnswerService;
import com.service.PageHandler;
import com.service.QuestionService;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/support")
public class SupportController {

    QuestionService questionService;
    AnswerService answerService;
    @Autowired
    public SupportController(QuestionService questionService, AnswerService answerService) {
        this.questionService = questionService;
        this.answerService = answerService;
    }

    @GetMapping("/list")
    @UserIdCheck
    public String supportList(Model model, PageHandler ph) {
        try {
            if(ph.getWriter().isEmpty()){
                int totalCnt = questionService.getTotalCnt();
                List<Question> questionList = questionService.getAllQuestion(ph.getPage());
                PageHandler newPh = new PageHandler(ph.getPage(),totalCnt);
                model.addAttribute("ph", newPh);
                model.addAttribute("list", questionList);
            }else{
                int myQuestionTotalCnt = questionService.getTotalCntById(ph.getWriter());
                List<Question> myQuestionList = questionService.getQuestionById(ph.getWriter(),ph.getPage());
                PageHandler newPh = new PageHandler(ph.getPage(),myQuestionTotalCnt,ph.getWriter());
                model.addAttribute("ph", newPh);
                model.addAttribute("list", myQuestionList);
                model.addAttribute("myQuestion","응애");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "support/list";
    }

    @GetMapping("/write")
    @UserIdCheck
    public String writeForm() {
        return "support/write";
    }

    @PostMapping("/write")
    @ResponseBody
    @AjaxUserIdCheck
    public String supportWrite(Question question) {
        try {
            questionService.insertQuestion(question);
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
        return "success";
    }


    @GetMapping("/view")
    @UserIdCheck
    public String view(Integer qno, PageHandler ph, HttpSession session, Model model,
        RedirectAttributes ra) {
        try {
            Question question = questionService.getQuestionByQno(qno);
            if(writerCheck(session,question)){
                model.addAttribute("question", question);
                model.addAttribute("ph", ph);
            }else{
                ra.addFlashAttribute("msg", "해당 게시글은 작성자만 볼 수 있습니다.");
                return "redirect:/support/list"+ph.getQueryString(ph.getPage());
            }
            Answer answer = answerService.getAnswerByQno(qno);
            if(answer != null){
                model.addAttribute("answer",answer);
            }
        } catch (Exception e) {
            e.printStackTrace();
            ra.addFlashAttribute("msg", "해당 게시글은 존재하지 않습니다.");
            return "redirect:/support/list"+ph.getQueryString(ph.getPage());
        }
        return "support/view";
    }

    @PostMapping("/edit")
    public String editQuestion(Question question,PageHandler ph,RedirectAttributes ra){
        try {
            questionService.updateQuestion(question);
            ra.addFlashAttribute("msg","수정완료");
        } catch (Exception e) {
            ra.addFlashAttribute("msg","질문 수정 실패");
            return "redirect:/support/list"+ph.getQueryString(ph.getPage());
        }
        return "redirect:/support/view"+ph.getQueryString(ph.getPage())+"&qno="+question.getQno();
    }

    @PostMapping("remove")
    public String removeQuestion(Question question,PageHandler ph,RedirectAttributes ra){
        try{
            questionService.deleteQuestionById(question.getQno());
            ra.addFlashAttribute("msg","질문 삭제 완료");
        }catch (Exception e){
            e.printStackTrace();
            ra.addFlashAttribute("msg","질문 삭제 실패");
            return "redirect:/support/list"+ph.getQueryString(ph.getPage());

        }
        return "redirect:/support/list"+ph.getQueryString(ph.getPage());
    }

    @PostMapping("/answer-write")
    @ResponseBody
    public String answerWrite(Answer answer){
        try {
            answerService.insertAnswer(answer);
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
        return "success";
    }

//    @GetMapping("/my-question")
//    @UserIdCheck
//    public String myQuestion(HttpSession session,Model model){
//        User user = (User) session.getAttribute("user");
//        try {
//            List<Question> questionList = questionService.getQuestionById(user.getId());
//            model.addAttribute("list",questionList);
//        } catch (Exception e) {
//            throw new RuntimeException(e);
//        }
//
//    }

    private boolean writerCheck(HttpSession session, Question question){
        User user = (User) session.getAttribute("user");
        return user.getId().equals("admin") || question.getWriter().equals(user.getId());
    }

}
