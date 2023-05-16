package com.mapper;

import com.dto.Answer;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AnswerMapper {

    int insertAnswer(Answer answer);

    Answer selectByQno(Integer qno);
}
