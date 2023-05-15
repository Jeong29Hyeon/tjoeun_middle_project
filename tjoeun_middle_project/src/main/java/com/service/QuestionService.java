package com.service;

import com.dto.Question;
import com.mapper.QuestionMapper;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QuestionService {
    QuestionMapper questionMapper;

    @Autowired
    public QuestionService(QuestionMapper questionMapper) {
        this.questionMapper = questionMapper;
    }

    public List<Question> getAllQuestion(int page) {
        int offset = (page-1)*10;
        return questionMapper.selectAll(offset);
    }

    public int getTotalCnt() {
        return questionMapper.getTotalCount();
    }

    public void insertQuestion(Question question) throws Exception {
        int result = questionMapper.insertQuestion(question);
        if(result < 1){
            throw new Exception("문의 인서트 실패");
        }
    }


    public Question getQuestionByQnoPw(Integer qno, Integer password) throws Exception {
        Map<String,Object> map = new HashMap<>();
        map.put("qno",qno);
        map.put("password",password);
        Question question =questionMapper.selectByQnoPw(map);
        if(question == null){
            throw new Exception("qno 혹은 비밀번호가 일치하지 않음");
        }
        return question;
    }
}
