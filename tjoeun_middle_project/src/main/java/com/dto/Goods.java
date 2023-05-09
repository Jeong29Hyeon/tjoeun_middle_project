package com.dto;

public class Goods {
    private int gno;
    private String category;
    private String name;
    private String goodsInfo;
    private String components;
    private int price;
    private String fileRealName;
    private String fileName;
    private String uploadPath;

    public Goods() {
    }

    public Goods(String category, String name, String goodsInfo,String components ,int price, String fileRealName,
        String fileName, String uploadPath) {
        this.category = category;
        this.name = name;
        this.goodsInfo = goodsInfo;
        this.components = components;
        this.price = price;
        this.fileRealName = fileRealName;
        this.fileName = fileName;
        this.uploadPath = uploadPath;
    }

    public String getComponents() {
        return components;
    }

    public void setComponents(String components) {
        this.components = components;
    }

    public int getGno() {
        return gno;
    }

    public void setGno(int gno) {
        this.gno = gno;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGoodsInfo() {
        return goodsInfo;
    }

    public void setGoodsInfo(String goodsInfo) {
        this.goodsInfo = goodsInfo;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getFileRealName() {
        return fileRealName;
    }

    public void setFileRealName(String fileRealName) {
        this.fileRealName = fileRealName;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getUploadPath() {
        return uploadPath;
    }

    public void setUploadPath(String uploadPath) {
        this.uploadPath = uploadPath;
    }
}
