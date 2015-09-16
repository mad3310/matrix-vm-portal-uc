package com.letv.uc.response;

import java.util.Collection;

public class QueryDataResponse extends DataResponse{
    private int startIndex;
    private int pageSize;
    private long total;
    private Collection rows;
    private int pageIndex;
    
    public int getStartIndex() {
    
        return startIndex;
    }
    
    public void setStartIndex(int startIndex) {
    
        this.startIndex = startIndex;
    }
    
    public int getPageSize() {
    
        return pageSize;
    }
    
    public void setPageSize(int pageSize) {
    
        this.pageSize = pageSize;
    }
    
    public long getTotal() {
    
        return total;
    }
    
    public void setTotal(long total) {
    
        this.total = total;
    }
    
    public Collection getRows() {
    
        return rows;
    }
    
    public void setRows(Collection rows) {
    
        this.rows = rows;
    }
    
    public int getPageIndex() {
    
        return pageIndex;
    }
    
    public void setPageIndex(int pageIndex) {
    
        this.pageIndex = pageIndex;
    }
}
