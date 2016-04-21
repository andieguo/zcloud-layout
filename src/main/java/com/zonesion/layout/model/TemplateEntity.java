package com.zonesion.layout.model;

import java.util.Date;

/**    
* @author andieguo andieguo@foxmail.com
* @Description: 模板 
* @date 2016年4月21日 上午11:00:34  
* @version V1.0    
*/
public class TemplateEntity {

	private Integer id;
	private String name;
	private String layoutJSON;
	private String layoutContent;
	private Integer aid;//管理员id
	private Integer type;//0表示系统模板，1表示用户模板
	private Date createTime;
	private Date modifyTime;
	private int visible;
	
	public TemplateEntity() {
		super();
	}
	
	public TemplateEntity(String name, String layoutJSON, String layoutContent, Integer aid, Integer type, Date createTime, Date modifyTime) {
		super();
		this.name = name;
		this.layoutJSON = layoutJSON;
		this.layoutContent = layoutContent;
		this.aid = aid;
		this.type = type;
		this.createTime = createTime;
		this.modifyTime = modifyTime;
	}

	public TemplateEntity(String name, String layoutJSON, String layoutContent, Integer aid, Integer type, Date createTime, Date modifyTime,int visible) {
		super();
		this.name = name;
		this.layoutJSON = layoutJSON;
		this.layoutContent = layoutContent;
		this.aid = aid;
		this.type = type;
		this.createTime = createTime;
		this.modifyTime = modifyTime;
		this.visible = visible;
	}
	public TemplateEntity(Integer id, String name, String layoutJSON, String layoutContent, Integer aid, Integer type, Date createTime, Date modifyTime,int visible) {
		super();
		this.id = id;
		this.name = name;
		this.layoutJSON = layoutJSON;
		this.layoutContent = layoutContent;
		this.aid = aid;
		this.type = type;
		this.createTime = createTime;
		this.modifyTime = modifyTime;
		this.visible = visible;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLayoutJSON() {
		return layoutJSON;
	}
	public void setLayoutJSON(String layoutJSON) {
		this.layoutJSON = layoutJSON;
	}
	public String getLayoutContent() {
		return layoutContent;
	}
	public void setLayoutContent(String layoutContent) {
		this.layoutContent = layoutContent;
	}
	public Integer getAid() {
		return aid;
	}
	public void setAid(Integer aid) {
		this.aid = aid;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getModifyTime() {
		return modifyTime;
	}
	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}
	public int getVisible() {
		return visible;
	}
	public void setVisible(int visible) {
		this.visible = visible;
	}
	@Override
	public String toString() {
		return "TemplateEntity [id=" + id + ", name=" + name + ", layoutJSON=" + layoutJSON + ", layoutContent=" + layoutContent + ", aid=" + aid + ", type=" + type + "]";
	}
	
}
