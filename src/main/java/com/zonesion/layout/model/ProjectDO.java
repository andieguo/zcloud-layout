package com.zonesion.layout.model;

import java.util.List;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年5月28日 上午11:33:40  
 * @version V1.0    
 */
public class ProjectDO {
	private Integer id;
	private String name;
	private String imageUrl;
	private Integer tid;//模板id
	private Integer aid;//管理员id
	private String zcloudID;
	private String zcloudKEY;
	private String serverAddr;
	private List<SensorDO> macList;
	
	public ProjectDO(ProjectEntity entity){
		super();
		this.id = entity.getId();
		this.name = entity.getName();
		this.imageUrl = entity.getImageUrl();
		this.tid = entity.getTid();
		this.aid = entity.getAid();
		this.zcloudID = entity.getZcloudID();
		this.zcloudKEY = entity.getZcloudKEY();
		this.serverAddr = entity.getServerAddr();
		Gson gs = new Gson();
		List<SensorDO> macList = gs.fromJson(entity.getMacList(), new TypeToken<List<SensorDO>>(){}.getType());//把JSON格式的字符串转为List  
        for (SensorDO p : macList) {  
            System.out.println("把JSON格式的字符串转为List///  "+p.toString());  
        }  
		this.macList = macList;
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
	public List<SensorDO> getMacList() {
		return macList;
	}
	public void setMacList(List<SensorDO> macList) {
		this.macList = macList;
	}
	
}
