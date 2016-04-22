package com.zonesion.layout.model;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月22日 下午5:05:37  
 * @version V1.0    
 */
public class AdminForm extends AdminEntity {

	private String confirmPassword;
	private int page;

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

	public AdminForm(String confirmPassword) {
		super();
		this.confirmPassword = confirmPassword;
	}

	public AdminForm() {
		super();
	}

	@Override
	public String toString() {
		return "AdminForm [confirmPassword=" + confirmPassword + ", getId()=" + getId() + ", getNickname()=" + getNickname() + ", getPassword()=" + getPassword() + ", getPhoneNumber()="
				+ getPhoneNumber() + ", getEmail()=" + getEmail() + ", getSex()=" + getSex() + ", getRole()=" + getRole() + ", getLandingTime()=" + getLandingTime() + ", getExitTime()="
				+ getExitTime() + ", getVisible()=" + getVisible() + ", toString()=" + super.toString() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + "]";
	}
	
}
