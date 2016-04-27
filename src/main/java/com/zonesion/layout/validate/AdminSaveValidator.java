package com.zonesion.layout.validate;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.zonesion.layout.model.AdminForm;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月22日 下午4:52:42  
 * @version V1.0    
 */
@Component("adminSaveValidator")
public class AdminSaveValidator  implements Validator{
	
	@Autowired
	@Qualifier("emailValidator")
	EmailValidator emailValidator;
	
	@Autowired
	@Qualifier("phoneValidator")
	PhonelValidator phoneValidator;
	
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
		AdminForm admin = (AdminForm)target;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "nickname", "NotEmpty.adminForm.nickname");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "NotEmpty.adminForm.password");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "confirmPassword", "NotEmpty.adminForm.confirmPassword");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "phoneNumber", "NotEmpty.adminForm.phoneNumber");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "NotEmpty.adminForm.email");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "sex", "NotEmpty.adminForm.sex");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "authcode", "NotEmpty.adminForm.authcode");
		
		if(isNotNULL(admin.getNickname()) && admin.getNickname().length() > 20){
			errors.rejectValue("nickname", "Size.adminForm.nickname");
		}
		if(isNotNULL(admin.getPassword()) && admin.getPassword().length() > 20){
			errors.rejectValue("password", "Size.adminForm.password");
		}
		if(isNotNULL(admin.getConfirmPassword()) && admin.getConfirmPassword().length() > 20){
			errors.rejectValue("confirmPassword", "Size.adminForm.confirmPassword");
		}
		if(isNotNULL(admin.getPhoneNumber()) && admin.getPhoneNumber().length() > 20){
			errors.rejectValue("phoneNumber", "Size.adminForm.phoneNumber");
		}
		if(isNotNULL(admin.getEmail()) && admin.getEmail().length() > 20){
			errors.rejectValue("email", "Size.adminForm.email");
		}
		if(isNotNULL(admin.getEmail()) && !emailValidator.valid(admin.getEmail())){
			errors.rejectValue("email", "Pattern.adminForm.email");
		}
		if(isNotNULL(admin.getPhoneNumber())&& !phoneValidator.valid(admin.getPhoneNumber())){
			errors.rejectValue("phoneNumber", "Pattern.adminForm.phoneNumber");
		}
		if (isNotNULL(admin.getPassword()) && isNotNULL(admin.getConfirmPassword()) && !admin.getPassword().equals(admin.getConfirmPassword())) {
			errors.rejectValue("confirmPassword", "Diff.userform.confirmPassword");
		}
		String authcode = (String) httpSession.getAttribute("authcode");
		if(isNotNULL(admin.getAuthcode()) && !admin.getAuthcode().equalsIgnoreCase(authcode)){
			errors.rejectValue("authcode","Fail.adminForm.authcode");
		}
	}

}
