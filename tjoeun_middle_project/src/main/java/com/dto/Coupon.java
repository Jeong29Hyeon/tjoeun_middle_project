package com.dto;

import java.util.Date;

public class Coupon {
    private int cno;
    private String id;
    private Date purchaseDate;
    private Date expireDate;
    private Goods goods;
    private String imp_uid;

    public Coupon() {
    }

    public int getCno() {
        return cno;
    }

    public void setCno(int cno) {
        this.cno = cno;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(Date purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public Date getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(Date expireDate) {
        this.expireDate = expireDate;
    }

    public Goods getGoods() {
        return goods;
    }

    public void setGoods(Goods goods) {
        this.goods = goods;
    }

    public String getImp_uid() {
        return imp_uid;
    }

    public void setImp_uid(String imp_uid) {
        this.imp_uid = imp_uid;
    }

    @Override
    public String toString() {
        return "Coupon{" +
                "cno=" + cno +
                ", id='" + id + '\'' +
                ", purchaseDate=" + purchaseDate +
                ", expireDate=" + expireDate +
                ", goods=" + goods +
                '}';
    }
}
