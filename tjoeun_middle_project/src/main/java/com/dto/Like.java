package com.dto;

public class Like {
    //https://coie117.tistory.com/67 참조
        private String seq;
        private int rno;   //댓글 번호
        private String id;  //유저 아이디
    public Like() {
    }

    public Like(String seq, int rno, String id) {
        this.seq = seq;
        this.rno = rno;
        this.id = id;
    }

    public int getRno() {
        return rno;
    }

    public void setRno(int rno) {
        this.rno = rno;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSeq() {
        return seq;
    }

    public void setSeq(String seq) {
        this.seq = seq;
    }
}
