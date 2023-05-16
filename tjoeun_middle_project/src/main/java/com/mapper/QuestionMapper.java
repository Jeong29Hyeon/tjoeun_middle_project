package com.mapper;

import com.dto.Question;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QuestionMapper {

    List<Question> selectAll(int offset);

    int getTotalCount();

    int insertQuestion(Question question);

    Question selectByQno(Integer qno);

    int updateQuestion(Question question);

    int deleteQuestionById(int qno);

    int updateStatus(Map<String,Object>map);

    List<Question> selectById(Map<String,Object>map);

    int getTotalCntById(String writer);
}
