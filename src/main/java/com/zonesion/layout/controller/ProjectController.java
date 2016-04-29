package com.zonesion.layout.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.zonesion.layout.model.ProjectEntity;
import com.zonesion.layout.model.ProjectForm;
import com.zonesion.layout.model.ProjectVO;
import com.zonesion.layout.model.TemplateForm;
import com.zonesion.layout.page.PageView;
import com.zonesion.layout.page.QueryResult;
import com.zonesion.layout.service.ProjectService;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月29日 上午10:34:38  
 * @version V1.0    
 */
@Controller
public class ProjectController {

	private final Logger logger = Logger.getLogger(ProjectController.class);
	
	@Autowired
	private ProjectService projectService;
	
	/**
	 * 后台展示项目管理列表
	 */
	@RequestMapping(value = "/project/list", method = {RequestMethod.POST, RequestMethod.GET})
	public String list(@ModelAttribute("projectForm") ProjectForm projectForm,Model model) {
		logger.debug("listProject()");
		int page = projectForm.getPage();
		PageView<ProjectVO> pageView = new PageView<ProjectVO>(10, page);
		int firstindex = (pageView.getCurrentpage()-1)*pageView.getMaxresult();
		QueryResult<ProjectVO> queryResult = null;
		pageView.setQueryResult(queryResult);
		model.addAttribute("pageView",pageView);
		return "manager/listProject";//跳转到manager/listProject.jsp页面
	}
	
	@RequestMapping(value = "/project/publish", method = {RequestMethod.POST, RequestMethod.GET})
	public String publish(ProjectForm projectForm,Model model){
		ProjectEntity projectEntity = projectService.findByProjectId(projectForm.getId());
		model.addAttribute("projectEntity", projectEntity);
		return "manager/projectUI";
	}

}
