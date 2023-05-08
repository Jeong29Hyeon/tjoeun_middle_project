package com.dto;

import java.util.Date;

public class Review {                // 영화 넘버링에 pk fk 해서 리뷰작성
    private String seq;           // 영화 테이블 참조
    private int rno;                //리뷰 번호
    private String content;           // 리뷰 본문
    private String id;               // User id
    private Date reg_date;            // 리뷰 등록시간 now()
    private int likeCount;            // 리뷰 기능 자체에 좋아요 싫어요
    private int hate_hit;
    public Review(){}

    public Review(String seq, int rno, String content, String id, Date reg_date, int like_hit,
        int hate_hit) {
        this.seq = seq;
        this.rno = rno;
        this.content = content;
        this.id = id;
        this.reg_date = reg_date;
        this.likeCount = likeCount;
        this.hate_hit = hate_hit;
    }

    public int getRno() {
        return rno;
    }

    public void setRno(int rno) {
        this.rno = rno;
    }

    public String getSeq() {
        return seq;
    }

    public void setSeq(String seq) {
        this.seq = seq;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getReg_date() {
        return reg_date;
    }

    public void setReg_date(Date reg_date) {
        this.reg_date = reg_date;
    }

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }

    public int getHate_hit() {
        return hate_hit;
    }

    public void setHate_hit(int hate_hit) {
        this.hate_hit = hate_hit;
    }
}
