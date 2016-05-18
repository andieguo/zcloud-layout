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
	private String nickname;
	private String templatename;
	
	public ProjectForm(ProjectEntity entity){
		super(entity.getId(), entity.getName(), entity.getImageUrl(), entity.getTid(), entity.getAid(), entity.getZcloudID(), entity.getZcloudKEY(), entity.getServerAddr(), entity.getMacList(), entity.getCreateTime(), entity.getModifyTime(), entity.getVisible());
	}
	
	public ProjectForm() {
		super();
//		setAid(-1);
//		setTid(-1);
		setVisible(-1);
	}
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
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getTemplatename() {
		return templatename;
	}
	public void setTemplatename(String templatename) {
		this.templatename = templatename;
	}
	
}
