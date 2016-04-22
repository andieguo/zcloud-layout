package com.zonesion.layout.validate;

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
@Component("adminFormValidator")
public class AdminFormValidator  implements Validator{
	
	@Autowired
	@Qualifier("emailValidator")
	EmailValidator emailValidator;
	
	@Autowired
	@Qualifier("phoneValidator")
	PhonelValidator phoneValidator;

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return AdminForm.class.equals(clazz);
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
		
		if(admin.getNickname()==null || admin.getNickname().length() > 20){
			errors.rejectValue("name", "Size.adminForm.nickname");
		}
		if(admin.getPassword()==null || admin.getPassword().length() > 20){
			errors.rejectValue("name", "Size.adminForm.password");
		}
		if(admin.getConfirmPassword()==null || admin.getConfirmPassword().length() > 20){
			errors.rejectValue("name", "Size.adminForm.confirmPassword");
		}
		if(admin.getPhoneNumber()==null || admin.getPhoneNumber().length() > 20){
			errors.rejectValue("name", "Size.adminForm.phoneNumber");
		}
		if(admin.getEmail()==null || admin.getEmail().length() > 20){
			errors.rejectValue("name", "Size.adminForm.email");
		}
		if(!emailValidator.valid(admin.getEmail())){
			errors.rejectValue("email", "Pattern.adminForm.email");
		}
		if(!phoneValidator.valid(admin.getPhoneNumber())){
			errors.rejectValue("phoneNumber", "Pattern.adminForm.phoneNumber");
		}
		if (!admin.getPassword().equals(admin.getConfirmPassword())) {
			errors.rejectValue("confirmPassword", "Diff.userform.confirmPassword");
		}
	}

}
