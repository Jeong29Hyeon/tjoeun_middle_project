package com.service;

import com.dto.Answer;
import com.mapper.AnswerMapper;
import com.mapper.QuestionMapper;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

@Service
public class AnswerService {
    AnswerMapper answerMapper;
    QuestionMapper questionMapper;
    DataSourceTransactionManager transactionManager;

    @Autowired
    public AnswerService(AnswerMapper answerMapper, QuestionMapper questionMapper,
        DataSourceTransactionManager transactionManager) {
        this.answerMapper = answerMapper;
        this.questionMapper = questionMapper;
        this.transactionManager = transactionManager;
    }

    public void insertAnswer(Answer answer) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = transactionManager.getTransaction(def);
        try {
            int result = answerMapper.insertAnswer(answer);
            Map<String,Object> map = new HashMap<>();
            map.put("qno",answer.getQno());
            map.put("state","답변완료");
            int result2 = questionMapper.updateStatus(map);
            transactionManager.commit(status);
        } catch (Exception e) {
            transactionManager.rollback(status);
            throw new RuntimeException(e);
        }

    }

    public Answer getAnswerByQno(Integer qno) {
        return answerMapper.selectByQno(qno);
    }
}
