package com.dto;

import java.util.Date;

public class User {
    private String id;
    private String password;
    private String name;
    private String birth;        //영화 예매 기준 나이 되는지 확인
    private String phone;
    private String rank;         // 등급 디폴트 bronze -> silver -> gold -> vip
    private Date cre_day;        // 가입일자 insert 시 now
    public User(){}

    public User(String id, String password, String name, String birth, String phone, String rank, Date cre_day) {
        this.id = id;
        this.password = password;
        this.name = name;
        this.birth = birth;
        this.phone = phone;
        this.rank = rank;
        this.cre_day = cre_day;
    }
}
