package com.dto;

import java.util.Date;

public class Movie {
    private int seq; //포스터 seq
    private String category;                // 카테고리 스릴러 코믹 섹스
    private String actor;                   // 배우 및 감독 ( 이제희 감독 정민규 조연 이정현 조연)   이미지 삽입시 고민 해야댐
    private int cumulativeUser;            // 누적 관객수
    private String ageRating;              // 영화 관람 등급 12세 15세 청불
    private String runningTime;            // 상영시간
    private String nation;                  // 국가
    private String story;                   // 짧은 한줄 스토리
    private Date regDay;                   // 개봉일자
    private String star;                    // 리뷰 -> 평점기능

    private String img; //크롤링 포스터 이미지
    private String rank; // 1~10위까지 영화
    private String title; //영화 제목
    private String rateInfo; //예매율
    private String openingDate; //개봉일
    private String[] stillCut;

    public String[] getStillCut() {
        return stillCut;
    }

    public void setStillCut(String[] stillCut) {
        this.stillCut = stillCut;
    }

    public Movie() {
    }

    public int getSeq() {
        return seq;
    }

    public void setSeq(int seq) {
        this.seq = seq;
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

    public int getCumulativeUser() {
        return cumulativeUser;
    }

    public void setCumulativeUser(int cumulativeUser) {
        this.cumulativeUser = cumulativeUser;
    }

    public String getAgeRating() {
        return ageRating;
    }

    public void setAgeRating(String ageRating) {
        this.ageRating = ageRating;
    }

    public String getRunningTime() {
        return runningTime;
    }

    public void setRunningTime(String runningTime) {
        this.runningTime = runningTime;
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

    public Date getRegDay() {
        return regDay;
    }

    public void setRegDay(Date regDay) {
        this.regDay = regDay;
    }

    public String getStar() {
        return star;
    }

    public void setStar(String star) {
        this.star = star;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getRank() {
        return rank;
    }

    public void setRank(String rank) {
        this.rank = rank;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getRateInfo() {
        return rateInfo;
    }

    public void setRateInfo(String rateInfo) {
        this.rateInfo = rateInfo;
    }

    public String getOpeningDate() {
        return openingDate;
    }

    public void setOpeningDate(String openingDate) {
        this.openingDate = openingDate;
    }
}
