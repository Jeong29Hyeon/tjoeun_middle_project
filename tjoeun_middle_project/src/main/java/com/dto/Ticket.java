package com.dto;

public class Ticket {
    private String id;
    private String titleInfo;
    private String hallInfo;
    private String dayInfo;
    private String timeInfo;

    public Ticket() {
    }

    public Ticket(String id, String titleInfo, String hallInfo, String dayInfo, String timeInfo) {
        this.id = id;
        this.titleInfo = titleInfo;
        this.hallInfo = hallInfo;
        this.dayInfo = dayInfo;
        this.timeInfo = timeInfo;
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
}
