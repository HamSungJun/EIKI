package com.hsjprime.eiki.member.dto;

public class PageVO {

    private int itemPerPage = 20;
    private int pageRangeSize = 10;
    private int currentPageIdx;
    private int startPageIdx;
    private int endPageIdx;
    private int totalObjectCount;
    private int maxPageIdx;
    private int offsetByPage;
    private boolean canPrev;
    private boolean canNext;

    public PageVO(int currentPageIdx, int totalObjectCount) {

        this.currentPageIdx = currentPageIdx;
        this.totalObjectCount = totalObjectCount;
        this.maxPageIdx = (int) Math.ceil((double) totalObjectCount / this.itemPerPage) == 0 ? 1 : (int) Math.ceil((double) totalObjectCount / this.itemPerPage);
        this.startPageIdx = (int) ((Math.ceil((double) currentPageIdx / this.pageRangeSize) - 1) * this.pageRangeSize + 1);
        this.endPageIdx = Math.min((this.startPageIdx + pageRangeSize - 1), this.maxPageIdx);
        this.offsetByPage = (this.currentPageIdx - 1) * this.itemPerPage;
        this.canNext = (this.currentPageIdx + 1 <= this.maxPageIdx);
        this.canPrev = (this.currentPageIdx - 1 >= 1);

    }

    public int getCurrentPageIdx() {
        return currentPageIdx;
    }

    public int getEndPageIdx() {
        return endPageIdx;
    }

    public int getItemPerPage() {
        return itemPerPage;
    }

    public int getMaxPageIdx() {
        return maxPageIdx;
    }

    public int getTotalObjectCount() {
        return totalObjectCount;
    }

    public int getPageRangeSize() {
        return pageRangeSize;
    }

    public int getOffsetByPage() {
        return offsetByPage;
    }

    public int getStartPageIdx() {
        return startPageIdx;
    }

    public boolean isNext() {
        return canNext;
    }

    public boolean isPrev() {
        return canPrev;
    }

}
