package com.zonesion.layout.model;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月29日 上午10:38:58  
 * @version V1.0    
 */
public class ProjectForm extends ProjectEntity{

	private int page = 1;
	private int deleted;
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getDeleted() {
		return deleted;
	}
	public void setDeleted(int deleted) {
		this.deleted = deleted;
	}
	
}
