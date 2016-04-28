package com.zonesion.layout.controller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.zonesion.layout.model.AdminEntity;
import com.zonesion.layout.model.TemplateForm;
import com.zonesion.layout.model.TemplateVO;
import com.zonesion.layout.page.PageView;
import com.zonesion.layout.page.QueryResult;
import com.zonesion.layout.service.AdminService;
import com.zonesion.layout.service.TemplateService;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月28日 下午3:00:14  
 * @version V1.0    
 */
@Controller
public class TemplateController {

	private final Logger logger = Logger.getLogger(AdminController.class);
	
	@Autowired
	private TemplateService templateService;
	
	@Autowired
	private AdminService adminService;
	
	@ModelAttribute("adminList")
	public Map<Integer,String> userList(){
		Map<Integer, String> adminMap = new LinkedHashMap<Integer, String>();
		List<AdminEntity> adminList = adminService.findAll(1);//所有存在的用户
		adminMap.put(-1, "全部");
		for(AdminEntity admin:adminList){
			adminMap.put(admin.getId(), admin.getNickname());
		}
		return adminMap;
	}
	
	@ModelAttribute("typeList")
	public Map<Integer,String> typeList(){
		Map<Integer, String> typeList = new LinkedHashMap<Integer, String>();
		typeList.put(-1, "全部");
		typeList.put(0, "系统模板");
		typeList.put(1, "用户模板");
		return typeList;
	}
	
	@ModelAttribute("enableList")
	public Map<Integer,String> enableList(){
		Map<Integer, String> enableList = new LinkedHashMap<Integer, String>();
		enableList.put(-1,"全部");
		enableList.put(0, "停用");
		enableList.put(1, "启用");
		return enableList;
	}

	/**
	 * 后台展示模板管理列表(管理员模板管理、用户模板管理)
	 */
	@RequestMapping(value = "/template/list", method = {RequestMethod.POST, RequestMethod.GET})
	public String list(@ModelAttribute("templateForm") TemplateForm templateForm,Model model) {
		logger.debug("listTemplate()");
		int page = templateForm.getPage();
		PageView<TemplateVO> pageView = new PageView<TemplateVO>(10,page);
		int firstindex = (pageView.getCurrentpage()-1)*pageView.getMaxresult();
		int aid = templateForm.getAid();
		int type = templateForm.getType();
		int visible = templateForm.getVisible();
		QueryResult<TemplateVO> queryResult = templateService.findByAdminAndType(aid, type, visible, firstindex, 10);
		pageView.setQueryResult(queryResult);
		model.addAttribute("pageView",pageView);
		return "manager/listTemplate";//跳转到manager/listTemplate.jsp页面
	}
	
	/**
	 * 跳转到用户添加模板页面
	 */
	public String addUI(){
		return "";
	}
	
	/**
	 * 跳转到用户编辑模板页面
	 */
	public String editUI(){
		return "";
	}
	
	/**
	 * 删除模板
	 */
	public String delete(){
		return "";
	}
	
	/**
	 * 执行保存操作
	 */
	public String save(){
		return "";
	}
	
}
