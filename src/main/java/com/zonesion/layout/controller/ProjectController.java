package com.zonesion.layout.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zonesion.layout.model.AdminEntity;
import com.zonesion.layout.model.AdminForm;
import com.zonesion.layout.model.ProjectEntity;
import com.zonesion.layout.model.ProjectForm;
import com.zonesion.layout.model.ProjectVO;
import com.zonesion.layout.model.TemplateEntity;
import com.zonesion.layout.page.PageView;
import com.zonesion.layout.page.QueryResult;
import com.zonesion.layout.service.AdminService;
import com.zonesion.layout.service.ProjectService;
import com.zonesion.layout.service.TemplateService;

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
	
	@Autowired
	private TemplateService templateService;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private HttpSession httpSession;
	
//	@ModelAttribute("adminList")
	public Map<Integer,String> userList(){
		Map<Integer, String> adminMap = new LinkedHashMap<Integer, String>();
		List<AdminEntity> adminList = adminService.findAll(1);//所有存在的用户
		adminMap.put(-1, "全部");
		for(AdminEntity admin:adminList){
			adminMap.put(admin.getId(), admin.getNickname());
		}
		return adminMap;
	}
	
//	@ModelAttribute("templateList")
	public Map<Integer,String> typeList(){
		Map<Integer, String> templateMap = new LinkedHashMap<Integer, String>();
		List<TemplateEntity> templateList = templateService.findAll();
		templateMap.put(-1, "全部");
		for(TemplateEntity template:templateList){
			templateMap.put(template.getId(),template.getName());
		}
		return templateMap;
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
	 * 根据模板类型获取模板列表
	 */
	@RequestMapping(value="/project/templateList",method=RequestMethod.POST)
	public void templateList(Integer type,HttpServletResponse response,HttpServletRequest request) throws IOException{
		JSONObject result = new JSONObject();// 构建一个JSONObject
		if(type!=null){
			AdminEntity admin = (AdminEntity)httpSession.getAttribute("admin");
			List<TemplateEntity> templateList = new ArrayList<TemplateEntity>();
			if(type.equals(0)){//系统模板
				templateList = templateService.findByType(0);
			}else if(type.equals(1)){//用户模板
				templateList = templateService.findByAdminAndType(admin.getId(),1);
			}
			if(templateList.size() > 0){
				result.accumulate("status", 1);
				result.accumulate("message", "success");
				JSONArray array = new JSONArray();
				for(TemplateEntity t : templateList){
					JSONObject obj = new JSONObject();
					obj.put("tid", t.getId());
					obj.put("name", t.getName());
					array.put(obj);
				}
				result.accumulate("data", array);
			}else{
				result.accumulate("status", 0);
				result.accumulate("message", "fail");
			}
		}
		response.setContentType("application/x-json");// 需要设置ContentType
		// 为"application/x-json"
		PrintWriter out = response.getWriter();
		out.println(result.toString());// 向客户端输出JSONObject字符串
		out.flush();
		out.close();
	}
	
	/**
	 * 后台展示项目管理列表
	 */
	@RequestMapping(value = "/project/list", method = {RequestMethod.POST, RequestMethod.GET})
	public String list(@ModelAttribute("projectForm") ProjectForm projectForm,Model model) {
		logger.debug("listProject()");
		int page = projectForm.getPage();
		PageView<ProjectVO> pageView = new PageView<ProjectVO>(10, page);
		int firstindex = (pageView.getCurrentpage()-1)*pageView.getMaxresult();
		String nickname = projectForm.getNickname();
		String templatename = projectForm.getTemplatename();
		String name = projectForm.getName();
		int visible = projectForm.getVisible();
		QueryResult<ProjectVO> queryResult = projectService.findByAdminIdAndTemplate(nickname, templatename, name,visible, firstindex, 10);
		pageView.setQueryResult(queryResult);
		model.addAttribute("pageView",pageView);
		return "manager/listProject";//跳转到manager/listProject.jsp页面
	}
	
	/**
	 * 项目发布页面
	 */
	@RequestMapping(value = "/project/publish", method = {RequestMethod.POST, RequestMethod.GET})
	public String publish(ProjectForm projectForm,Model model){
		ProjectEntity projectEntity = projectService.findByProjectId(projectForm.getId());
		TemplateEntity templateEntity = templateService.findByTemplateId(projectEntity.getTid());
		model.addAttribute("projectEntity", projectEntity);
		model.addAttribute("templateEntity",templateEntity);
		return "manager/projectUI";
	}
	
	/**
	 * 跳转到添加项目页面
	 */
	@RequestMapping(value = "/project/addUI", method = RequestMethod.GET)
	public String addUI(Model model){
		model.addAttribute("projectForm", new ProjectForm());
		return "manager/addProject";
	}
	
	/**
	 * 跳转到编辑项目页面
	 */
	@RequestMapping(value = "/project/editUI", method = RequestMethod.GET)
	public String editUI(ProjectForm editForm,Model model){
		ProjectEntity projectEntity = projectService.findByProjectId(editForm.getId());
		//只需要将表单中有的字段添加到form表单即可（安全）
		//ProjectForm projectForm = new ProjectForm();
		model.addAttribute("editForm", projectEntity);
		return "manager/editProject";
	}

	/**
	 * 添加项目
	 */
	@RequestMapping(value = "/project/add", method = RequestMethod.POST)
	public String add(@ModelAttribute("editForm") @Validated ProjectForm editForm,
			BindingResult result, Model model, 
			final RedirectAttributes redirectAttributes){
		logger.debug("addProject()");
		if (result.hasErrors()) {
			return "manager/addProject";//跳转到manager/editProject.jsp页面
		} else {
			editForm.setModifyTime(new Date());
			editForm.setCreateTime(new Date());
			AdminForm admin = (AdminForm)httpSession.getAttribute("admin");
			editForm.setAid(admin.getId());
			editForm.setVisible(1);
			int status = projectService.save(editForm);
			if(status > 0){
				redirectAttributes.addFlashAttribute("css", "success");
				redirectAttributes.addFlashAttribute("msg", "保存项目信息成功");
			}else{
				redirectAttributes.addFlashAttribute("css", "failed");
				redirectAttributes.addFlashAttribute("msg", "保存项目信息失败");
			}
			return "redirect:/project/list";//跳转到/admin/list,正确做法是跳转到用户详细信息视图界面
		}
	}
	
	/**
	 * 编辑项目
	 */
	@RequestMapping(value = "/project/edit", method = RequestMethod.POST)
	public String edit(@ModelAttribute("editForm") @Validated ProjectForm editForm,
			BindingResult result, Model model, 
			final RedirectAttributes redirectAttributes){
		logger.debug("editProject()");
		if (result.hasErrors()) {
			return "manager/editProject";//跳转到manager/editProject.jsp页面
		} else {
			ProjectEntity projectEntity = projectService.findByProjectId(editForm.getId());
			projectEntity.setModifyTime(new Date());
			projectEntity.setImageUrl(editForm.getImageUrl());
			projectEntity.setMacList(editForm.getImageUrl());
			projectEntity.setServerAddr(editForm.getServerAddr());
			projectEntity.setZcloudID(editForm.getZcloudID());
			projectEntity.setZcloudKEY(editForm.getZcloudKEY());
			projectEntity.setTid(editForm.getTid());
			int status = projectService.update(projectEntity);
			if(status > 0){
				redirectAttributes.addFlashAttribute("css", "success");
				redirectAttributes.addFlashAttribute("msg", "更新项目信息成功");
			}else{
				redirectAttributes.addFlashAttribute("css", "failed");
				redirectAttributes.addFlashAttribute("msg", "更新项目信息失败");
			}
			return "redirect:/project/list";//跳转到/admin/list,正确做法是跳转到用户详细信息视图界面
		}
	}
	
	/**
	 * 删除项目
	 */
	@RequestMapping(value = "/project/delete", method = {RequestMethod.POST, RequestMethod.GET})
	public String delete(ProjectForm projectForm,final RedirectAttributes redirectAttributes){
		logger.debug("deleteProject()");
		int result = projectService.enable(projectForm.getId(),projectForm.getDeleted());
		if(result > 0){
			//addFlashAttribute表示如果F5的时候，会发现参数丢失
			redirectAttributes.addFlashAttribute("css", "success");
			redirectAttributes.addFlashAttribute("msg", "删除用户成功!");
		}else{
			//addFlashAttribute表示如果F5的时候，会发现参数丢失
			redirectAttributes.addFlashAttribute("css", "failed");
			redirectAttributes.addFlashAttribute("msg", "删除用户失败!");
		}
		//重定向传递GET参数有两种方式，方式二（addAttribute表示GET方式提交）
		redirectAttributes.addAttribute("page", projectForm.getPage());//重定向传递参数，删除后跳转到page页
		redirectAttributes.addAttribute("visible", projectForm.getVisible());
		redirectAttributes.addAttribute("nickname", projectForm.getNickname());
		redirectAttributes.addAttribute("templatename", projectForm.getTemplatename());
		redirectAttributes.addAttribute("name",projectForm.getName());
		return "redirect:/project/list";
	}
}
