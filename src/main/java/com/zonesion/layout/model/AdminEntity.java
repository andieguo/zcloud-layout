package com.zonesion.layout.model;

import java.util.Date;
/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: 管理员 
 * @date 2016年4月21日 上午11:04:46  
 * @version V1.0    
 */
public class AdminEntity {

	private Integer id;
	private String nickname;
	private String password;
	private String phoneNumber;
	private String email;
	private int sex;//0表示女，1表示男
	private int role;//0表示管理员，1表示普通用户
	private Date createTime;
	private Date modifyTime;
	private int visible;//0表示已删除
	
	public AdminEntity() {
		super();
	}
	
	public AdminEntity(String nickname, String password, String phoneNumber, String email, int sex, int role, Date createTime, Date modifyTime) {
		super();
		this.nickname = nickname;
		this.password = password;
		this.phoneNumber = phoneNumber;
		this.email = email;
		this.sex = sex;
		this.role = role;
		this.createTime = createTime;
		this.modifyTime = modifyTime;
	}

	public AdminEntity(Integer id, String nickname, String password, String phoneNumber, String email, int sex, int role, Date createTime, Date modifyTime, int visible) {
		super();
		this.id = id;
		this.nickname = nickname;
		this.password = password;
		this.phoneNumber = phoneNumber;
		this.email = email;
		this.sex = sex;
		this.role = role;
		this.createTime = createTime;
		this.modifyTime = modifyTime;
		this.visible = visible;
	}
	public AdminEntity(String nickname, String password, String phoneNumber, String email, int sex, int role, Date createTime, Date modifyTime, int visible) {
		super();
		this.nickname = nickname;
		this.password = password;
		this.phoneNumber = phoneNumber;
		this.email = email;
		this.sex = sex;
		this.role = role;
		this.createTime = createTime;
		this.modifyTime = modifyTime;
		this.visible = visible;
	}
	/**
	 * @return the id
	 */
	public Integer getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(Integer id) {
		this.id = id;
	}
	/**
	 * @return the nickname
	 */
	public String getNickname() {
		return nickname;
	}
	/**
	 * @param nickname the nickname to set
	 */
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * @return the phoneNumber
	 */
	public String getPhoneNumber() {
		return phoneNumber;
	}
	/**
	 * @param phoneNumber the phoneNumber to set
	 */
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the sex
	 */
	public int getSex() {
		return sex;
	}
	/**
	 * @param sex the sex to set
	 */
	public void setSex(int sex) {
		this.sex = sex;
	}
	/**
	 * @return the role
	 */
	public int getRole() {
		return role;
	}
	/**
	 * @param role the role to set
	 */
	public void setRole(int role) {
		this.role = role;
	}
	/**
	 * @return the createTime
	 */
	public Date getCreateTime() {
		return createTime;
	}
	/**
	 * @param createTime the createTime to set
	 */
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	/**
	 * @return the modifyTime
	 */
	public Date getModifyTime() {
		return modifyTime;
	}
	/**
	 * @param modifyTime the modifyTime to set
	 */
	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}
	/**
	 * @return the visible
	 */
	public int getVisible() {
		return visible;
	}
	/**
	 * @param visible the visible to set
	 */
	public void setVisible(int visible) {
		this.visible = visible;
	}
	
	@Override
	public String toString() {
		return "AdminEntity [id=" + id + ", nickname=" + nickname + ", password=" + password + ", phoneNumber=" + phoneNumber + ", email=" + email + ", sex=" + sex + ", role=" + role
				+ ", createTime=" + createTime + ", modifyTime=" + modifyTime + ", visible=" + visible + "]";
	}
	
}
