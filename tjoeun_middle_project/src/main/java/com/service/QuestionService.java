package com.service;

import com.dto.Answer;
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


    public Question getQuestionByQno(Integer qno) throws Exception {
        Question question =questionMapper.selectByQno(qno);
        if(question == null){
            throw new Exception("해당하는 글이 없음");
        }
        return question;
    }

    public void updateQuestion(Question question) throws Exception {
        int result = questionMapper.updateQuestion(question);
        if(result < 1){
            throw new Exception("게시글 수정 실패");
        }
    }

    public void deleteQuestionById(int qno) throws Exception {
        int result = questionMapper.deleteQuestionById(qno);
        if(result < 1){
            throw new Exception("게시글 삭제 실패");
        }
    }

    public List<Question> getQuestionById(String id,int page) {
        Map<String,Object> map = new HashMap<>();
        map.put("writer",id);
        map.put("offset",(page-1)*10);
        return questionMapper.selectById(map);
    }

    public int getTotalCntById(String writer) {
        return questionMapper.getTotalCntById(writer);
    }

}
