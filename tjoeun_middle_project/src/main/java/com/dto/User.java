package com.dto;

import java.util.Date;

public class User {
    private String id;
    private String password;
    private String name;
    private String birth;  //영화 예매 기준 나이 되는지 확인

    private String gender;

    private String email;
    private String phone;
    private String rank;         // 등급 디폴트 bronze -> silver -> gold -> vip
    private Date reg_day;        // 가입일자 insert 시 now
    public User(){}

    public User(String id, String password, String name, String birth, String gender, String email,
        String phone, String rank, Date reg_day) {
        this.id = id;
        this.password = password;
        this.name = name;
        this.birth = birth;
        this.gender = gender;
        this.email = email;
        this.phone = phone;
        this.rank = rank;
        this.reg_day = reg_day;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBirth() {
        return birth;
    }

    public void setBirth(String birth) {
        this.birth = birth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRank() {
        return rank;
    }

    public void setRank(String rank) {
        this.rank = rank;
    }

    public Date getReg_day() {
        return reg_day;
    }

    public void setReg_day(Date reg_day) {
        this.reg_day = reg_day;
    }
}
