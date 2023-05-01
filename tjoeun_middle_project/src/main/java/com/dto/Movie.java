package com.dto;

import java.util.Date;

public class Movie {    
    private int num;                        // 영화 넘버링 (오토인크)
//    private String movie_img;               // 제희 왈 이미지 스트링으로 가져온다
    private String movie_Name;              // 영화이름
    private String category;                // 카테고리 스릴러 코믹 섹스
    private String actor;                   // 배우 및 감독 ( 이제희 감독 정민규 조연 이정현 조연)   이미지 삽입시 고민 해야댐
    private int cumulative_User;            // 누적 관객수
    private String age_rating;              // 영화 관람 등급 12세 15세 청불
    private String running_time;            // 상영시간
    private String nation;                  // 국가
    private String story;                   // 짧은 한줄 스토리
    private Date reg_day;                   // 개봉일자
    private String star;                    // 리뷰 -> 평점기능

    public Movie(){}

    public Movie(int num, String movie_Name, String category, String actor, int cumulative_User, String age_rating,
                 String running_time, String nation, String story, Date reg_day, String star) {
        this.num = num;
        this.movie_Name = movie_Name;
        this.category = category;
        this.actor = actor;
        this.cumulative_User = cumulative_User;
        this.age_rating = age_rating;
        this.running_time = running_time;
        this.nation = nation;
        this.story = story;
        this.reg_day = reg_day;
        this.star = star;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public String getMovie_Name() {
        return movie_Name;
    }

    public void setMovie_Name(String movie_Name) {
        this.movie_Name = movie_Name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getActor() {
        return actor;
    }

    public void setActor(String actor) {
        this.actor = actor;
    }

    public int getCumulative_User() {
        return cumulative_User;
    }

    public void setCumulative_User(int cumulative_User) {
        this.cumulative_User = cumulative_User;
    }

    public String getAge_rating() {
        return age_rating;
    }

    public void setAge_rating(String age_rating) {
        this.age_rating = age_rating;
    }

    public String getRunning_time() {
        return running_time;
    }

    public void setRunning_time(String running_time) {
        this.running_time = running_time;
    }

    public String getNation() {
        return nation;
    }

    public void setNation(String nation) {
        this.nation = nation;
    }

    public String getStory() {
        return story;
    }

    public void setStory(String story) {
        this.story = story;
    }

    public Date getReg_day() {
        return reg_day;
    }

    public void setReg_day(Date reg_day) {
        this.reg_day = reg_day;
    }

    public String getStar() {
        return star;
    }

    public void setStar(String star) {
        this.star = star;
    }
}
