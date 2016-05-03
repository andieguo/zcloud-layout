package com.zonesion.layout.model;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月22日 下午5:05:37  
 * @version V1.0    
 */
public class AdminForm extends AdminEntity {

	private String newPassword;
	private String confirmPassword;
	private int page = 1;
	private String authcode;
	private int deleted;

	public AdminForm() {
		super();
		setVisible(-1);
		setRole(-1);
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
	
	public String getAuthcode() {
		return authcode;
	}

	public void setAuthcode(String authcode) {
		this.authcode = authcode;
	}

	public AdminForm(String confirmPassword) {
		super();
		this.confirmPassword = confirmPassword;
	}
	
	public int getDeleted() {
		return deleted;
	}

	public void setDeleted(int deleted) {
		this.deleted = deleted;
	}

	public AdminForm(int page) {
		super();
		this.page = page;
	}
	
	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public AdminForm(AdminEntity adminEntity){
		super(adminEntity.getId(), adminEntity.getNickname(), adminEntity.getPassword(), adminEntity.getPhoneNumber(),
				adminEntity.getEmail(), adminEntity.getSex(), adminEntity.getRole(), adminEntity.getCreateTime(), adminEntity.getModifyTime(), 
				adminEntity.getVisible());
	}

	@Override
	public String toString() {
		return "AdminForm [confirmPassword=" + confirmPassword + ", page=" + page + ", authcode=" + authcode + ", getId()=" + getId() + ", getNickname()=" + getNickname() + ", getPassword()="
				+ getPassword() + ", getPhoneNumber()=" + getPhoneNumber() + ", getEmail()=" + getEmail() + ", getSex()=" + getSex() + ", getRole()=" + getRole() + ", getLandingTime()="
				+ getModifyTime() + ", getCreateTime()=" + getCreateTime()+ "]";
	}
	
}
