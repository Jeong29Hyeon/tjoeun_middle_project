package com.dto;

import java.sql.Timestamp;

public class Answer {
    private int ano;
    private Integer qno;

    private String content;

    private Timestamp answerDate;

    public Answer() {
    }

    public int getAno() {
        return ano;
    }

    public void setAno(int ano) {
        this.ano = ano;
    }

    public Integer getQno() {
        return qno;
    }

    public void setQno(Integer qno) {
        this.qno = qno;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getAnswerDate() {
        return answerDate;
    }

    public void setAnswerDate(Timestamp answerDate) {
        this.answerDate = answerDate;
    }
}
