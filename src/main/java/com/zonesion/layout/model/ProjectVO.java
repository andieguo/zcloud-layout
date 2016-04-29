package com.zonesion.layout.model;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月29日 上午10:41:51  
 * @version V1.0    
 */
public class ProjectVO extends ProjectEntity{

	private String nickname;
	private String templatename;
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
	@Override
	public String toString() {
		return "ProjectVO [nickname=" + nickname + ", templatename=" + templatename + ", getId()=" + getId() + ", getName()=" + getName() + ", getImageUrl()=" + getImageUrl() + ", getTid()="
				+ getTid() + ", getAid()=" + getAid() + ", getZcloudID()=" + getZcloudID() + ", getZcloudKEY()=" + getZcloudKEY() + ", getServerAddr()=" + getServerAddr() + ", getMacList()="
				+ getMacList() + ", getCreateTime()=" + getCreateTime() + ", getModifyTime()=" + getModifyTime() + ", getVisible()=" + getVisible() + "]";
	}
	
	
}
