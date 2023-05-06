package com.dto;

public class Ticket {

    private int tno;
    private String id;
    private String titleInfo;
    private String hallInfo;
    private String dayInfo;
    private String timeInfo;

    private Integer numberOfAdult;

    private Integer numberOfTeen;

    private String seats;

    private int price;

    public Ticket() {
    }

    public Ticket(int tno, String id, String titleInfo, String hallInfo, String dayInfo,
        String timeInfo, Integer numberOfAdult, Integer numberOfTeen, String seats, int price) {
        this.tno = tno;
        this.id = id;
        this.titleInfo = titleInfo;
        this.hallInfo = hallInfo;
        this.dayInfo = dayInfo;
        this.timeInfo = timeInfo;
        this.numberOfAdult = numberOfAdult;
        this.numberOfTeen = numberOfTeen;
        this.seats = seats;
        this.price = price;
    }

    public int getTno() {
        return tno;
    }

    public void setTno(int tno) {
        this.tno = tno;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitleInfo() {
        return titleInfo;
    }

    public void setTitleInfo(String titleInfo) {
        this.titleInfo = titleInfo;
    }

    public String getHallInfo() {
        return hallInfo;
    }

    public void setHallInfo(String hallInfo) {
        this.hallInfo = hallInfo;
    }

    public String getDayInfo() {
        return dayInfo;
    }

    public void setDayInfo(String dayInfo) {
        this.dayInfo = dayInfo;
    }

    public String getTimeInfo() {
        return timeInfo;
    }

    public void setTimeInfo(String timeInfo) {
        this.timeInfo = timeInfo;
    }

    public Integer getNumberOfAdult() {
        return numberOfAdult;
    }

    public void setNumberOfAdult(Integer numberOfAdult) {
        this.numberOfAdult = numberOfAdult;
    }

    public Integer getNumberOfTeen() {
        return numberOfTeen;
    }

    public void setNumberOfTeen(Integer numberOfTeen) {
        this.numberOfTeen = numberOfTeen;
    }

    public String getSeats() {
        return seats;
    }

    public void setSeats(String seats) {
        this.seats = seats;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Ticket{" +
            "tno=" + tno +
            ", id='" + id + '\'' +
            ", titleInfo='" + titleInfo + '\'' +
            ", hallInfo='" + hallInfo + '\'' +
            ", dayInfo='" + dayInfo + '\'' +
            ", timeInfo='" + timeInfo + '\'' +
            ", numberOfAdult=" + numberOfAdult +
            ", numberOfTeen=" + numberOfTeen +
            ", seats='" + seats + '\'' +
            ", price=" + price +
            '}';
    }
}
