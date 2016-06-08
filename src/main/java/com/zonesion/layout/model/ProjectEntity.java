package com.zonesion.layout.model;

import java.util.Date;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: 项目 
 * @date 2016年4月21日 上午11:04:46  
 * @version V1.0    
 */
public class ProjectEntity {

	private Integer id;
	private String name;
	private String titleContent;
	private String footContent;
	private String imageUrl;
	private Integer tid;//模板id
	private Integer aid;//管理员id
	private String zcloudID;
	private String zcloudKEY;
	private String serverAddr;
	private String macList;//mac配置地址列表
	private Date createTime;
	private Date modifyTime;
	private int visible;//0表示已删除
	
	public ProjectEntity() {
		super();
	}
	
	public ProjectEntity(String name,String titleContent,String footContent, String imageUrl, Integer tid, Integer aid, String zcloudID, String zcloudKEY, String serverAddr, String macList, Date createTime, Date modifyTime) {
		super();
		this.name = name;
		this.titleContent = titleContent;
		this.footContent = footContent;
		this.imageUrl = imageUrl;
		this.tid = tid;
		this.aid = aid;
		this.zcloudID = zcloudID;
		this.zcloudKEY = zcloudKEY;
		this.serverAddr = serverAddr;
		this.macList = macList;
		this.createTime = createTime;
		this.modifyTime = modifyTime;
	}

	public ProjectEntity(String name,String titleContent,String footContent, String imageUrl, Integer tid, Integer aid, String zcloudID, String zcloudKEY, String serverAddr, String macList,Date createTime,Date modifyTime,int visible) {
		super();
		this.name = name;
		this.titleContent = titleContent;
		this.footContent = footContent;
		this.imageUrl = imageUrl;
		this.tid = tid;
		this.aid = aid;
		this.zcloudID = zcloudID;
		this.zcloudKEY = zcloudKEY;
		this.serverAddr = serverAddr;
		this.macList = macList;
		this.createTime = createTime;
		this.modifyTime = modifyTime;
		this.visible = visible;
	}
	public ProjectEntity(Integer id, String name,String titleContent,String footContent, String imageUrl, Integer tid, Integer aid,String zcloudID, String zcloudKEY, String serverAddr, String macList,Date createTime,Date modifyTime,int visible) {
		super();
		this.id = id;
		this.name = name;
		this.titleContent = titleContent;
		this.footContent = footContent;
		this.imageUrl = imageUrl;
		this.tid = tid;
		this.aid = aid;
		this.zcloudID = zcloudID;
		this.zcloudKEY = zcloudKEY;
		this.serverAddr = serverAddr;
		this.macList = macList;
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
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public Integer getTid() {
		return tid;
	}
	public void setTid(Integer tid) {
		this.tid = tid;
	}
	public Integer getAid() {
		return aid;
	}
	public void setAid(Integer aid) {
		this.aid = aid;
	}
	public String getZcloudID() {
		return zcloudID;
	}
	public void setZcloudID(String zcloudID) {
		this.zcloudID = zcloudID;
	}
	public String getZcloudKEY() {
		return zcloudKEY;
	}
	public void setZcloudKEY(String zcloudKEY) {
		this.zcloudKEY = zcloudKEY;
	}
	public String getServerAddr() {
		return serverAddr;
	}
	public void setServerAddr(String serverAddr) {
		this.serverAddr = serverAddr;
	}
	public String getMacList() {
		return macList;
	}
	public void setMacList(String macList) {
		this.macList = macList;
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
	public String getTitleContent() {
		return titleContent;
	}
	public void setTitleContent(String titleContent) {
		this.titleContent = titleContent;
	}
	public String getFootContent() {
		return footContent;
	}
	public void setFootContent(String footContent) {
		this.footContent = footContent;
	}
	@Override
	public String toString() {
		return "ProjectEntity [id=" + id + ", name=" + name + ", imageUrl=" + imageUrl + ", tid=" + tid + ", aid=" + aid +", zcloudID=" + zcloudID + ", zcloudKEY=" + zcloudKEY + ", serverAddr=" + serverAddr
				+ ", macList=" + macList + "]";
	}
	
}
