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

    Question selectByQnoPw(Map<String, Object> map);
}
