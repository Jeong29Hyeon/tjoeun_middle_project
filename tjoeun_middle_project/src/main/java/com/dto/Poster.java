package com.dto;

public class Poster {
    private String img; //크롤링 포스터 이미지
    private String rank; // 1~10위까지 영화
    private String title; //영화 제목
    private String rateInfo; //예매율

    private String openingDate; //개봉일
    public Poster() {
    }

    public Poster(String img, String rank, String title, String rateInfo, String openingDate) {
        this.img = img;
        this.rank = rank;
        this.title = title;
        this.rateInfo = rateInfo;
        this.openingDate = openingDate;
    }

    public String getOpeningDate() {
        return openingDate;
    }

    public void setOpeningDate(String openingDate) {
        this.openingDate = openingDate;
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

}