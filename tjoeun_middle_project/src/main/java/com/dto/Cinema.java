package com.dto;

public class Cinema {
    private int cinema_num;          // 몇관 몇관
    private String cinema_name;      // 프라임관 일반관
    private int seats;               // 좌석수 fk 테이블 만들어서 a10열 b10열 등 만들어야댐
    private int cinema_money;        // 각 관마다의 가격

    public Cinema(){}

    public Cinema(int cinema_num, String cinema_name, int seats, int cinema_money) {
        this.cinema_num = cinema_num;
        this.cinema_name = cinema_name;
        this.seats = seats;
        this.cinema_money = cinema_money;
    }
}
