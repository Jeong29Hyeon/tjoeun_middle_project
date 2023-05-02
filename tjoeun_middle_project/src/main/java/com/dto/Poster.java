package com.dto;

public class Poster {

    private int seq; //포스터 seq
    private String img; //크롤링 포스터 이미지
    private String rank; // 1~10위까지 영화
    private String title; //영화 제목
    private String rateInfo; //예매율
    private String openingDate; //개봉일
    private String story;       //잠시 테스트로 줄거리좀 넣음

    private String detailUrl;     //디ㅔ일뷰

    public Poster() {
    }

    public Poster(int seq,String img, String rank, String title, String rateInfo, String openingDate, String story,String detailUrl) {
        this.seq = seq;
        this.img = img;
        this.rank = rank;
        this.title = title;
        this.rateInfo = rateInfo;
        this.openingDate = openingDate;
        this.story = story;
        this.detailUrl = detailUrl;
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

    public String getStory() {
        return story;
    }

    public void setStory(String story) {
        this.story = story;
    }

    public String getDetailUrl() {
        return detailUrl;
    }

    public void setDetailUrl(String detailUrl) {
        this.detailUrl = detailUrl;
    }

    public int getSeq() {
        return seq;
    }

    public void setSeq(int seq) {
        this.seq = seq;
    }
}
