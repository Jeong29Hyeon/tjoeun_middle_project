package com.dto;

public class Like {
    //https://coie117.tistory.com/67 참조
        private int reviewno;   //댓글 번호
        private String userid;  //유저 아이디
        private int itlike; 
        private int count;  //좋아요 눌린 상태인가 아닌가
    public Like() {
    }

    public Like(int reviewno, String userid, int itlike, int count) {
        this.reviewno = reviewno;
        this.userid = userid;
        this.itlike = itlike;
        this.count = count;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getReviewno() {
        return reviewno;
    }

    public void setReviewno(int reviewno) {
        this.reviewno = reviewno;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public int getItlike() {
        return itlike;
    }

    public void setItlike(int itlike) {
        this.itlike = itlike;
    }
}
