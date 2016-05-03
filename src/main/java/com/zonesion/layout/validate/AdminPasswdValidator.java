package com.zonesion.layout.validate;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.zonesion.layout.model.AdminForm;
import com.zonesion.layout.service.AdminService;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月22日 下午4:52:42  
 * @version V1.0    
 */
@Component("adminPasswdValidator")
public class AdminPasswdValidator  implements Validator{
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private  HttpSession httpSession;
	
	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return AdminForm.class.equals(clazz);
	}
	
	public boolean isNotNULL(String content){
		return content != null && !content.equals("");
	}

	@Override
	public void validate(Object target, Errors errors) {
		// TODO Auto-generated method stub
		AdminForm adminForm = (AdminForm)target;
		//校验输入是否为空
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "NotEmpty.adminForm.password");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "newPassword", "NotEmpty.adminForm.newPassword");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "confirmPassword", "NotEmpty.adminForm.confirmPassword");
		//校验输入长度
		if(isNotNULL(adminForm.getPassword()) && adminForm.getPassword().length() > 20){
			errors.rejectValue("password", "Size.adminForm.password");
		}
		if(isNotNULL(adminForm.getNewPassword()) && adminForm.getNewPassword().length() > 20){
			errors.rejectValue("newPassword", "Size.adminForm.newPassword");
		}
		if(isNotNULL(adminForm.getConfirmPassword()) && adminForm.getConfirmPassword().length() > 20){
			errors.rejectValue("confirmPassword", "Size.adminForm.confirmPassword");
		}
		//校验当前密码输入是否正确
		if(isNotNULL(adminForm.getPassword())){
			boolean status = adminService.confirmPasswd(adminForm.getPassword(), adminForm.getId());
			if(!status){
				errors.rejectValue("password","Fail.adminForm.password");
			}
		}
		//校验验证码
		String authcode = (String) httpSession.getAttribute("authcode");
		if(isNotNULL(adminForm.getAuthcode()) && !adminForm.getAuthcode().equalsIgnoreCase(authcode)){
			errors.rejectValue("authcode","Fail.adminForm.authcode");
		}
		//两次输入密码一致
		if (isNotNULL(adminForm.getNewPassword()) && isNotNULL(adminForm.getConfirmPassword()) && !adminForm.getNewPassword().equals(adminForm.getConfirmPassword())) {
			errors.rejectValue("confirmPassword", "Diff.userform.confirmPassword");
		}
		
	}

}
