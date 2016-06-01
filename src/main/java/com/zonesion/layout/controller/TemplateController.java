package com.zonesion.layout.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zonesion.layout.model.AdminEntity;
import com.zonesion.layout.model.TemplateEntity;
import com.zonesion.layout.model.TemplateForm;
import com.zonesion.layout.model.TemplateVO;
import com.zonesion.layout.page.PageView;
import com.zonesion.layout.page.QueryResult;
import com.zonesion.layout.service.AdminService;
import com.zonesion.layout.service.TemplateService;
import com.zonesion.layout.util.Constants;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月28日 下午3:00:14  
 * @version V1.0    
 */
@Controller
public class TemplateController {

	private final Logger logger = Logger.getLogger(TemplateController.class);
	
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
	 * 从模板编辑页面跳转到list页面
	 */
	@RequestMapping(value = "/template/tolist", method = {RequestMethod.POST, RequestMethod.GET})
	public String toList(int type,Model model){
		model.addAttribute("type", type);
		model.addAttribute("to", "templateList");
		return "manager/index";
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
		String templatename = templateForm.getName();
		String nickname = templateForm.getNickname();
		int type = templateForm.getType();
		int visible = templateForm.getVisible();
		QueryResult<TemplateVO> queryResult = templateService.findByAdminAndType(nickname, templatename, type, visible, firstindex, 10);
		pageView.setQueryResult(queryResult);
		model.addAttribute("pageView",pageView);
		return "manager/listTemplate";//跳转到manager/listTemplate.jsp页面
	}
	
	/**
	 * 跳转到用户添加模板页面
	 */
	@RequestMapping(value = "/template/addUI", method = {RequestMethod.POST, RequestMethod.GET})
	public String addUI(int type,Model model){
		model.addAttribute("method","save");
		model.addAttribute("type",type);
		return "manager/editTemplate";
	}
	
	/**
	 * 上传文件：读取模板编辑页面客户端上传的文件
	 */
	@RequestMapping(value = "/template/importUI", method = {RequestMethod.POST, RequestMethod.GET})
	public String importUI(int type,HttpServletRequest request,HttpServletResponse response,Model model) {
		try {
			File stoageHome = new File(Constants.LAYOUT_TEMPLATE_PATH);
			String content = UploadUtil.upload(stoageHome,request);
			if(content != null){
				//解析上传文件内容
				JSONObject jsonObject = new JSONObject(content);
				String name = jsonObject.getString("name");
				String layoutContent = jsonObject.getString("content");
				String layoutJSON = jsonObject.getString("layout");
				//AdminEntity admin = (AdminEntity)httpSession.getAttribute("admin");
				TemplateEntity templateEntity = new TemplateEntity();
				templateEntity.setName(name);
				templateEntity.setLayoutContent(layoutContent);
				templateEntity.setLayoutJSON(layoutJSON);
				templateEntity.setType(type);//获取/template/importUI?type=1请求
				model.addAttribute("templateEntity",templateEntity);
				model.addAttribute("method","save");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "manager/editTemplate";
	}
	
	/**
	 * 上传文件：读取客户端上传的文件，导入模板到数据库
	 */
	@RequestMapping(value = "/template/import", method = {RequestMethod.POST, RequestMethod.GET})
	public String importContent(HttpServletRequest request,HttpServletResponse response,final RedirectAttributes redirectAttributes) {
		try {
			File stoageHome = new File(Constants.LAYOUT_TEMPLATE_PATH);
			String content = UploadUtil.upload(stoageHome,request);
			if(content != null){
				//解析上传文件内容
				JSONObject jsonObject = new JSONObject(content);
				String name = jsonObject.getString("name");
				String layoutContent = jsonObject.getString("content");
				String layoutJSON = jsonObject.getString("layout");
				AdminEntity admin = (AdminEntity)httpSession.getAttribute("admin");
				templateService.save(new TemplateEntity(name, layoutJSON, layoutContent, admin.getId(), 1, new Date(), new Date()));
				redirectAttributes.addFlashAttribute("css", "success");
				redirectAttributes.addFlashAttribute("msg", "导入模板文件成功");
			}else{
				redirectAttributes.addFlashAttribute("css", "fail");
				redirectAttributes.addFlashAttribute("msg", "导入模板文件失败");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/template/list";//跳转到manager/listTemplate.jsp页面
	}
	
	/**
	 * 客户端下载文件：读取数据库内容，生成reponse响应
	 */
	@RequestMapping(value = "/template/export", method = {RequestMethod.POST, RequestMethod.GET})
	public void exportContent(Integer id,HttpServletResponse response) throws IOException{
		if(id != null){
			TemplateEntity templateEntity = templateService.findByTemplateId(id);
			if(templateEntity != null){
				JSONObject result = new JSONObject();// 构建一个JSONObject
				response.setContentType("application/x-json;charset=utf-8");// 需要设置ContentType为"application/x-json"
				String str = "attachment;filename=" + java.net.URLEncoder.encode(templateEntity.getName()+".template", "utf-8");
				response.setHeader("Content-Disposition", str);
				PrintWriter out = response.getWriter();
				result.accumulate("name", templateEntity.getName());
				result.accumulate("content", templateEntity.getLayoutContent());
				result.accumulate("layout", templateEntity.getLayoutJSON());
				out.println(result.toString());// 向客户端输出JSONObject字符串
				out.flush();
				out.close();
			}
		}
	}
	
	@RequestMapping(value = "/template/edit", method = {RequestMethod.POST, RequestMethod.GET})
	public void edit(TemplateForm templateForm,HttpServletResponse response) throws IOException{
		TemplateEntity templateEntity = templateService.findByTemplateId(templateForm.getId());
		if(templateEntity != null){
			templateEntity.setLayoutContent(templateForm.getLayoutContent());
			templateEntity.setLayoutJSON(templateForm.getLayoutJSON());
			templateEntity.setName(templateForm.getName());
			templateEntity.setModifyTime(new Date());
			int status = templateService.update(templateEntity);
			JSONObject result = new JSONObject();// 构建一个JSONObject
			response.setContentType("application/x-json;charset=utf-8");// 需要设置ContentType为"application/x-json"
			PrintWriter out = response.getWriter();
			if(status > 0){//更新成功
				result.accumulate("status", 1);
				result.accumulate("message", "success");
			}else{
				result.accumulate("status", 0);
				result.accumulate("message", "failed");
			}
			out.println(result.toString());// 向客户端输出JSONObject字符串
			out.flush();
			out.close();
		}
	}
	
	/**
	 * 跳转到用户编辑模板页面(返回JSON格式数据)
	 */
	@RequestMapping(value = "/template/editUI", method = {RequestMethod.POST, RequestMethod.GET})
	public String editUI(TemplateForm templateForm,Model model){
		logger.debug("editUI()");
		TemplateEntity templateEntity = templateService.findByTemplateId(templateForm.getId());
		model.addAttribute("templateEntity",templateEntity);
		model.addAttribute("method","edit");
		return "manager/editTemplate";
	}
	
	/**
	 * 批量删除模板
	 */
	@RequestMapping(value = "/template/delete", method = {RequestMethod.POST, RequestMethod.GET})
	public String delete(TemplateForm templateForm,final RedirectAttributes redirectAttributes){
		logger.debug("deleteTemplate()");
		int result = templateService.delete(templateForm.getKeyIds());
		if(result > 0){
			//addFlashAttribute表示如果F5的时候，会发现参数丢失
			redirectAttributes.addFlashAttribute("css", "success");
			redirectAttributes.addFlashAttribute("msg", "删除模板成功!");
		}else{
			//addFlashAttribute表示如果F5的时候，会发现参数丢失
			redirectAttributes.addFlashAttribute("css", "failed");
			redirectAttributes.addFlashAttribute("msg", "删除模板失败!");
		}
		//重定向传递GET参数有两种方式，方式二（addAttribute表示GET方式提交）
		redirectAttributes.addAttribute("page", templateForm.getPage());//重定向传递参数，删除后跳转到page页
		redirectAttributes.addAttribute("visible", templateForm.getVisible());
		redirectAttributes.addAttribute("nickname", templateForm.getNickname());
		redirectAttributes.addAttribute("name", templateForm.getName());
		redirectAttributes.addAttribute("type",templateForm.getType());
		return "redirect:/template/list";
	}
	
	/**
	 * 执行保存操作
	 */
	@RequestMapping(value = "/template/save", method = {RequestMethod.POST, RequestMethod.GET})
	public void save(TemplateForm templateForm,HttpServletResponse response) throws IOException{
		TemplateEntity templateEntity = new TemplateEntity();
		templateEntity.setLayoutContent(templateForm.getLayoutContent());
		templateEntity.setLayoutJSON(templateForm.getLayoutJSON());
		templateEntity.setName(templateForm.getName());
		templateEntity.setModifyTime(new Date());
		templateEntity.setCreateTime(new Date());
		templateEntity.setType(templateForm.getType());
		AdminEntity admin = (AdminEntity)httpSession.getAttribute("admin");
		templateEntity.setAid(admin.getId());
		int status = templateService.save(templateEntity);
		JSONObject result = new JSONObject();// 构建一个JSONObject
		response.setContentType("application/x-json;charset=utf-8");// 需要设置ContentType
		PrintWriter out = response.getWriter();
		if(status > 0){//更新成功
			result.accumulate("status", 1);
			result.accumulate("message", "success");
		}else{
			result.accumulate("status", 0);
			result.accumulate("message", "failed");
		}
		// 为"application/x-json"
		out.println(result.toString());// 向客户端输出JSONObject字符串
		out.flush();
		out.close();
	}
	
	/**
	 * 使能template
	 */
	@RequestMapping(value="/template/enable",method=RequestMethod.POST)
	public void enable(Integer id,Integer deleted,HttpServletResponse response,HttpServletRequest request) throws IOException{
		JSONObject result = new JSONObject();// 构建一个JSONObject
		int status = templateService.enable(id,deleted);
		if(status > 0){
			result.accumulate("status", 1);
			result.accumulate("message", "success");
		}else{
			result.accumulate("status", 0);
			result.accumulate("message", "fail");
		}
		response.setContentType("application/x-json;charset=utf-8");// 需要设置ContentType
		PrintWriter out = response.getWriter();
		out.println(result.toString());// 向客户端输出JSONObject字符串
		out.flush();
		out.close();
	}
	
}
