package com.zonesion.layout.page;

import java.util.List;

public class PageView<T> {
	private List<T> records;//分页数据
	private PageIndex pageindex;//页码开始索引 和 结束索引
	private long totalpage = 1;//总页数
	private int maxresult = 12;//每页显示记录数
	private int currentpage = 1;//当前页码
	private long totalrecord;//总记录数
	private int pagecode = 10 ;//页码数量
	
	public int getFirstResult(){
		return (currentpage-1)*maxresult;
	}
	
	public void setQueryResult(QueryResult<T> qr){
		setRecords(qr.getResultlist());
		setTotalrecord(qr.getTotalrecord());
	}
	
	public PageView(int maxresult, int currentpage) {
		super();
		this.maxresult = maxresult;
		this.currentpage = currentpage;
	}
	
	public int getPagecode() {
		return pagecode;
	}
	public void setPagecode(int pagecode) {
		this.pagecode = pagecode;
	}
	public long getTotalrecord() {
		return totalrecord;
	}
	public void setTotalrecord(long totalrecord) {
		this.totalrecord = totalrecord;
		setTotalpage(totalrecord%maxresult==0?totalrecord/maxresult:totalrecord/maxresult+1);
	}
	public List<T> getRecords() {
		return records;
	}
	public void setRecords(List<T> records) {
		this.records = records;
	}

	public PageIndex getPageindex() {
		return pageindex;
	}

	public long getTotalpage() {
		return totalpage;
	}
	public void setTotalpage(long totalpage) {
		this.totalpage = totalpage;
		this.pageindex = PageIndex.getPageIndex(pagecode, currentpage, totalpage);
		
	}
	public int getMaxresult() {
		return maxresult;
	}
	public void setMaxresult(int maxresult) {
		this.maxresult = maxresult;
	}
	public int getCurrentpage() {
		return currentpage;
	}
	public void setCurrentpage(int currentpage) {
		this.currentpage = currentpage;
	}
	
	
}
