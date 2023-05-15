package com.service;

public class PageHandler {
    private int page = 1;
    private int pageSize=10;
    private int totalPage;
    private int totalCnt;
    private int beginPage;
    private int endPage;
    private int naviSize = 5;
    private boolean showPrev;

    private boolean showNext;

    public PageHandler() {
    }

    public PageHandler(int page, int totalCnt) {
        this.page = page;
        this.totalCnt = totalCnt;
        doPaging();
    }

    private void doPaging() {
        totalPage = (int) Math.ceil(totalCnt/(double)pageSize);
        beginPage = (page-1) / naviSize * naviSize +1;
        endPage = Math.min(totalPage,beginPage+naviSize-1);
        showPrev = beginPage != 1;
        showNext = endPage != totalPage;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getTotalCnt() {
        return totalCnt;
    }

    public void setTotalCnt(int totalCnt) {
        this.totalCnt = totalCnt;
    }

    public int getBeginPage() {
        return beginPage;
    }

    public void setBeginPage(int beginPage) {
        this.beginPage = beginPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public int getNaviSize() {
        return naviSize;
    }

    public void setNaviSize(int naviSize) {
        this.naviSize = naviSize;
    }

    public boolean isShowPrev() {
        return showPrev;
    }

    public void setShowPrev(boolean showPrev) {
        this.showPrev = showPrev;
    }

    public boolean isShowNext() {
        return showNext;
    }

    public void setShowNext(boolean showNext) {
        this.showNext = showNext;
    }
}
