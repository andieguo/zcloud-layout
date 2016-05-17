package com.zonesion.layout.validate;


import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.zonesion.layout.model.ProjectForm;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月22日 下午4:52:42  
 * @version V1.0    
 */
@Component("projectValidator")
public class ProjectValidator  implements Validator{
	
	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return ProjectForm.class.equals(clazz);
	}
	
	public boolean isNotNULL(String content){
		return content != null && !content.equals("");
	}

	@Override
	public void validate(Object target, Errors errors) {
		// TODO Auto-generated method stub
		//ProjectForm projectForm = (ProjectForm)target;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "NotEmpty.projectForm.name");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "zcloudID", "NotEmpty.projectForm.zcloudID");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "zcloudKEY", "NotEmpty.projectForm.zcloudKEY");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "serverAddr", "NotEmpty.projectForm.serverAddr");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "tid", "NotEmpty.projectForm.tid");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "macList", "NotEmpty.projectForm.macList");
	}

}
