package com.letvcloud.uc.pojo;

import java.io.Serializable;
import java.util.List;

public class PaginationSupport implements Serializable{
    
    public final static int PAGESIZE = 10;
    
    private int pageSize = PAGESIZE;
    
    private int pageIndex = 1;
    
    private List list;
    
    private long totalCount;
    
    private int[] indexes = new int[0];
    
    private int startIndex = 0;
    
    public PaginationSupport(List items, long totalCount) {
    
        setPageSize(PAGESIZE);
        setTotalCount(totalCount);
        setList(items);
        setStartIndex(0);
    }
    
    public PaginationSupport(List items, long totalCount, int startIndex) {
    
        setPageSize(PAGESIZE);
        setTotalCount(totalCount);
        setList(items);
        setStartIndex(startIndex);
    }
    
    public PaginationSupport(List items, long totalCount, int pageSize, int startIndex) {
    
        setPageSize(pageSize);
        setTotalCount(totalCount);
        setList(items);
        setStartIndex(startIndex);
    }
    
    public List getList() {
    
        return list;
    }
    
    public void setList(List items) {
    
        this.list = items;
    }
    
    public int getPageSize() {
    
        return pageSize;
    }
    
    public void setPageSize(int pageSize) {
    
        this.pageSize = pageSize;
    }
    
    public long getTotalCount() {
    
        return totalCount;
    }
    
    public void setTotalCount(long totalCount) {
    
        if (totalCount > 0) {
            this.totalCount = totalCount;
            int count = (int) (totalCount / pageSize);
            if (totalCount % pageSize > 0)
                count++;
            indexes = new int[count];
            for (int i = 0; i < count; i++) {
                indexes[i] = pageSize * i;
            }
        } else {
            this.totalCount = 0;
        }
    }
    
    public int[] getIndexes() {
    
        return indexes;
    }
    
    public void setIndexes(int[] indexes) {
    
        this.indexes = indexes;
    }
    
    public int getStartIndex() {
    
        return startIndex;
    }
    
    public void setStartIndex(int startIndex) {
    
        if (totalCount <= 0) {
            this.startIndex = 0;
            pageIndex = 1;
        } else if (startIndex >= totalCount) {
            this.startIndex = indexes[indexes.length - 1];
            pageIndex = indexes.length;
        } else if (startIndex < 0) {
            this.startIndex = 0;
            pageIndex = 0;
        } else {
            this.startIndex = indexes[startIndex / pageSize];
            pageIndex = startIndex / pageSize + 1;
        }
    }
    
    public int getNextIndex() {
    
        int nextIndex = getStartIndex() + pageSize;
        if (nextIndex >= totalCount)
            return getStartIndex();
        else
            return nextIndex;
    }
    
    public int getPreviousIndex() {
    
        int previousIndex = getStartIndex() - pageSize;
        if (previousIndex < 0)
            return 0;
        else
            return previousIndex;
    }
    
    public int getPageIndex() {
    
        return pageIndex;
    }
    
    public void setPageIndex(int pageIndex) {
    
        this.pageIndex = pageIndex;
    }
}