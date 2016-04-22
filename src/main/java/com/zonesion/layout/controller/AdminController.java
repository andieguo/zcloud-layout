package com.zonesion.layout.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zonesion.layout.model.AdminEntity;
import com.zonesion.layout.model.AdminForm;
import com.zonesion.layout.page.PageView;
import com.zonesion.layout.page.QueryResult;
import com.zonesion.layout.service.AdminService;
import com.zonesion.layout.validate.AdminFormValidator;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月22日 下午4:50:15  
 * @version V1.0    
 */
@Controller
public class AdminController {

	private final Logger logger = Logger.getLogger(AdminController.class);
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private AdminFormValidator adminFormValidator;
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		binder.setValidator(adminFormValidator);
	}
	
	/**
	 * 分页显示Admin
	 */
	@RequestMapping(value = "/admin/list/", method = RequestMethod.GET)
	public String showAllUsers(Model model,@RequestParam(value="page",required=false) int page) {
		logger.debug("listAdmins()");
		PageView<AdminEntity> pageView = new PageView<>(10,page);
		int firstindex = (pageView.getCurrentpage()-1)*pageView.getMaxresult();
		QueryResult<AdminEntity> queryResult = adminService.findAll(firstindex,10);
		pageView.setQueryResult(queryResult);
		model.addAttribute("pageView",pageView);
		return "manager/listAdmin";//跳转到manager/listAdmin.jsp页面
	}
	
	/**
	 * 用户注册
	 */
	@RequestMapping(value = "/admin/register", method = RequestMethod.POST)
	public String register(@ModelAttribute("adminForm") @Validated AdminForm adminForm,
			BindingResult result, Model model, 
			final RedirectAttributes redirectAttributes) {
		logger.debug("register() : "+adminForm);
		if (result.hasErrors()) {
			return "/register";//跳转到/register.jsp页面
		} else {
			redirectAttributes.addFlashAttribute("css", "success");
			redirectAttributes.addFlashAttribute("msg", "注册用户成功!");
			redirectAttributes.addAttribute("page", 0);//重定向传递参数,注册后跳转到第0页
			adminForm.setRole(1);//普通用户
			adminService.register(adminForm);
			return "redirect:/admin/list";//跳转到/admin/list
		}
	}
	
	/**
	 * 用户更新
	 */
	@RequestMapping(value = "/admin/update", method = RequestMethod.POST)
	public String updateAdmin(@ModelAttribute("adminForm") @Validated AdminForm adminForm,
			BindingResult result, Model model, 
			final RedirectAttributes redirectAttributes) {
		logger.debug("updateAdmin() : "+adminForm);
		if (result.hasErrors()) {
			return "manager/updateAdmin";//跳转到manager/updateAdmin.jsp页面
		} else {
			redirectAttributes.addFlashAttribute("css", "success");
			redirectAttributes.addFlashAttribute("msg", "更新用户信息成功");
			redirectAttributes.addAttribute("page", adminForm.getPage());//重定向传递参数，更新后跳转到page页
			adminService.update(adminForm);
			return "redirect:/admin/list";//跳转到/admin/list
		}
	}
	
	/**
	 * 跳转到更新用户界面
	 */
	@RequestMapping(value = "/admin/{id}/updateUI", method = RequestMethod.GET)
	public String showUpdateUserForm(@PathVariable("id") int id, Model model) {
		logger.debug("showUpdateAdminForm() : "+id);
		AdminEntity admin = adminService.findById(id);
		model.addAttribute("adminForm", admin);
		return "manager/updateAdmin";//跳转到manager/updateAdmin.jsp页面
	}
	
	/**
	 * 管理员删除用户
	 */
	@RequestMapping(value = "/admin/{id}/delete", method = RequestMethod.GET)
	public String deleteUser(@PathVariable("id") int id,@RequestParam(value="page",required=false) int page, 
			final RedirectAttributes redirectAttributes) {
		logger.debug("deleteAdmin() : "+id);
		adminService.delete(id);
		redirectAttributes.addFlashAttribute("css", "success");
		redirectAttributes.addFlashAttribute("msg", "删除用户成功!");
		redirectAttributes.addAttribute("page", page);//重定向传递参数，删除后跳转到page页
		return "redirect:/admin/list";
	}
}
