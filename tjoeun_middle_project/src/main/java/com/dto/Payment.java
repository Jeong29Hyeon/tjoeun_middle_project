package com.dto;

public class Payment {
    private int pno;
    private String imp_uid;
    private int tno;
    private int gno;
    private int paid_amount;

    public Payment() {
    }

    public int getPno() {
        return pno;
    }

    public void setPno(int pno) {
        this.pno = pno;
    }

    public String getImp_uid() {
        return imp_uid;
    }

    public void setImp_uid(String imp_uid) {
        this.imp_uid = imp_uid;
    }

    public int getTno() {
        return tno;
    }

    public void setTno(int tno) {
        this.tno = tno;
    }

    public int getGno() {
        return gno;
    }

    public void setGno(int gno) {
        this.gno = gno;
    }

    public int getPaid_amount() {
        return paid_amount;
    }

    public void setPaid_amount(int paid_amount) {
        this.paid_amount = paid_amount;
    }

    @Override
    public String toString() {
        return "Payment{" +
            "pno=" + pno +
            ", imp_uid=" + imp_uid +
            ", tno=" + tno +
            ", gno=" + gno +
            ", paid_amount=" + paid_amount +
            '}';
    }
}
