package com.dto;

import java.util.Date;

public class Review {                // 영화 넘버링에 pk fk 해서 리뷰작성
    private int movie_num;           // 영화 테이블 참조 
    private String movie_name;       // 영화 이름
    private String id;               // User id
    private String review;           // 리뷰 본문
    private Date reg_day;            // 리뷰 등록시간 now()
        
    private int like_hit;            // 리뷰 기능 자체에 좋아요 싫어요
    private int hate_hit;
    public Review(){}

    public Review(int movie_num, String movie_name, String id, String review, Date reg_day, int like_hit, int hate_hit) {
        this.movie_num = movie_num;
        this.movie_name = movie_name;
        this.id = id;
        this.review = review;
        this.reg_day = reg_day;
        this.like_hit = like_hit;
        this.hate_hit = hate_hit;
    }

    public int getMovie_num() {
        return movie_num;
    }

    public void setMovie_num(int movie_num) {
        this.movie_num = movie_num;
    }

    public String getMovie_name() {
        return movie_name;
    }

    public void setMovie_name(String movie_name) {
        this.movie_name = movie_name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    }

    public Date getReg_day() {
        return reg_day;
    }

    public void setReg_day(Date reg_day) {
        this.reg_day = reg_day;
    }

    public int getLike_hit() {
        return like_hit;
    }

    public void setLike_hit(int like_hit) {
        this.like_hit = like_hit;
    }

    public int getHate_hit() {
        return hate_hit;
    }

    public void setHate_hit(int hate_hit) {
        this.hate_hit = hate_hit;
    }
}