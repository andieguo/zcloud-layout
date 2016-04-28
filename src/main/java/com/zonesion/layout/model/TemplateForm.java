package com.zonesion.layout.model;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月28日 下午3:02:44  
 * @version V1.0    
 */
public class TemplateForm extends TemplateEntity{
	
	private int page = 1;
	
	public TemplateForm() {
		super();
		setAid(-1);
		setType(-1);
		setVisible(-1);
	}

	public TemplateForm(int page) {
		super();
		this.page = page;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	
	
}
