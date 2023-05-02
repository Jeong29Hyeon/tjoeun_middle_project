package com.dto;

public class Hall {
    private int hall_num;          // 몇관 몇관
    private String hall_name;      // 프라임관 일반관
    private int seats;               // 좌석수 fk 테이블 만들어서 a10열 b10열 등 만들어야댐
    private int hall_money;        // 각 관마다의 가격

    public Hall(){}

    public Hall(int hall_num, String hall_name, int seats, int hall_money) {
        this.hall_num = hall_num;
        this.hall_name = hall_name;
        this.seats = seats;
        this.hall_money = hall_money;
    }

    public int getHall_num() {
        return hall_num;
    }

    public void setHall_num(int hall_num) {
        this.hall_num = hall_num;
    }

    public String getHall_name() {
        return hall_name;
    }

    public void setHall_name(String hall_name) {
        this.hall_name = hall_name;
    }

    public int getSeats() {
        return seats;
    }

    public void setSeats(int seats) {
        this.seats = seats;
    }

    public int getHall_money() {
        return hall_money;
    }

    public void setHall_money(int hall_money) {
        this.hall_money = hall_money;
    }
}
