package com.dto;

import java.util.Arrays;
import java.util.Date;

public class Movie {
    private String seq; //포스터 seq
    private String category;                // 카테고리에 상영시간 포함됨
    private String actor;                   //  감독 ( 이제희 감독 정민규 조연 이정현 조연)   이미지 삽입시 고민 해야댐
    private String director;
    private String cumulativeUser;            // 누적 관객수
    private String ageRating;              // 영화 관람 등급 12세 15세 청불
    private String runningTime;            // 상영시간
    private String story;                   // 짧은 한줄 스토리
    private String star;                    // 리뷰 -> 평점기능

    private String img; //크롤링 포스터 이미지
    private String rank; // 1~10위까지 영화
    private String title; //영화 제목
    private String rateInfo; //예매율
    private String openingDate; //개봉일
    private String[] stillCut;

    public Movie() {
    }

    public String getSeq() {
        return seq;
    }

    public void setSeq(String seq) {
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

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getCumulativeUser() {
        return cumulativeUser;
    }

    public void setCumulativeUser(String cumulativeUser) {
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

    public String getStory() {
        return story;
    }

    public void setStory(String story) {
        this.story = story;
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

    public String[] getStillCut() {
        return stillCut;
    }

    public void setStillCut(String[] stillCut) {
        this.stillCut = stillCut;
    }

    @Override
    public String toString() {
        return "Movie{" +
            "seq='" + seq + '\'' +
            ", category='" + category + '\'' +
            ", actor='" + actor + '\'' +
            ", director='" + director + '\'' +
            ", cumulativeUser='" + cumulativeUser + '\'' +
            ", ageRating='" + ageRating + '\'' +
            ", runningTime='" + runningTime + '\'' +
            ", story='" + story + '\'' +
            ", star='" + star + '\'' +
            ", img='" + img + '\'' +
            ", rank='" + rank + '\'' +
            ", title='" + title + '\'' +
            ", rateInfo='" + rateInfo + '\'' +
            ", openingDate='" + openingDate + '\'' +
            ", stillCut=" + Arrays.toString(stillCut) +
            '}';
    }
}
