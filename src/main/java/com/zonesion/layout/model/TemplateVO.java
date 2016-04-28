package com.zonesion.layout.model;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月28日 下午6:16:28  
 * @version V1.0    
 */
public class TemplateVO extends TemplateEntity{

	private String nickname;

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	@Override
	public String toString() {
		return "TemplateVO [nickname=" + nickname + ", getId()=" + getId() + ", getName()=" + getName() + ", getLayoutJSON()=" + getLayoutJSON() + ", getLayoutContent()=" + getLayoutContent()
				+ ", getAid()=" + getAid() + ", getType()=" + getType() + ", getCreateTime()=" + getCreateTime() + ", getModifyTime()=" + getModifyTime() + ", getVisible()=" + getVisible()
				+ ", toString()=" + super.toString() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + "]";
	}
	
	
	
	
}
