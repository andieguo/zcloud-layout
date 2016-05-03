package com.zonesion.layout.validate;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.zonesion.layout.model.AdminEntity;
import com.zonesion.layout.model.AdminForm;
import com.zonesion.layout.service.AdminService;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月22日 下午4:52:42  
 * @version V1.0    
 */
@Component("adminLoginValidator")
public class AdminLoginValidator  implements Validator{
	
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
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "nickname", "NotEmpty.adminForm.nickname");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "NotEmpty.adminForm.password");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "authcode", "NotEmpty.adminForm.authcode");

		AdminEntity adminEntity = adminService.login(adminForm.getNickname(), adminForm.getPassword(),adminForm.getRole());
		httpSession.setAttribute("admin", adminEntity);
		String authcode = (String) httpSession.getAttribute("authcode");
		if(isNotNULL(adminForm.getAuthcode()) && !adminForm.getAuthcode().equalsIgnoreCase(authcode)){
			errors.rejectValue("authcode","Fail.adminForm.authcode");
		}else if(isNotNULL(adminForm.getNickname()) && isNotNULL(adminForm.getPassword()) && adminEntity==null){
			errors.rejectValue("nickname","LoginFail.adminForm.nickname");
		}
		
	}

}
