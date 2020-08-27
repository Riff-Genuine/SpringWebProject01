package com.carry.www.vo;

import org.springframework.stereotype.Repository;

@Repository
public class Criteria {
	private int page;
	private int perPageNum;
	private int start;
	private int end;
	private String id;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
	}
	public void setPage(int page) {
		if (page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}
	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}
	public int getPage() {
		return page;
	}
	public int getPageStart() {
		return (this.page - 1) * perPageNum;
	}
	public int getPerPageNum() {
		return this.perPageNum;
	}
	public int getStart() {
		start = ((page - 1) * perPageNum) + 1;
		return start;
	}
	public int getEnd() {
		end = start + perPageNum - 1;
		return end;
	}
	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", start=" + start + ", end=" + end
				+ "]";
	}
}
