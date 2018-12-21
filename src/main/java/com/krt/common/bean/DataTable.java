package com.krt.common.bean;

import java.io.Serializable;
import java.util.List;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: DataTable数据返回
 * @date 2016年8月1日
 */
public class DataTable<T> implements Serializable {

    /**
     * 每页显示数据
     */
    private Integer length = 10;
    /**
     * 页数
     */
    private Integer pageNum = 1;
    /**
     * 总数
     */
    private Long recordsFiltered;
    /**
     * 数据
     */
    private List<T> data;


    public Long getRecordsFiltered() {
        return recordsFiltered;
    }

    public void setRecordsFiltered(Long recordsFiltered) {
        this.recordsFiltered = recordsFiltered;
    }

    public List getData() {
        return data;
    }

    public void setData(List data) {
        this.data = data;
    }

    public Integer getLength() {
        return length;
    }

    public void setLength(Integer length) {
        this.length = length;
    }

    public Integer getPageNum() {
        return pageNum;
    }

    public void setPageNum(Integer start) {
        Integer page = start / this.getLength();
        this.pageNum = page + 1;
    }

}
