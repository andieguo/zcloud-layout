package com.zonesion.layout.controller;

import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zonesion.layout.model.AdminEntity;
import com.zonesion.layout.model.AdminForm;
import com.zonesion.layout.page.PageView;
import com.zonesion.layout.page.QueryResult;
import com.zonesion.layout.service.AdminService;
import com.zonesion.layout.validate.AdminEditValidator;
import com.zonesion.layout.validate.AdminSaveValidator;

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
	private AdminSaveValidator adminSaveValidator;
	
	@Autowired
	private AdminEditValidator adminEditValidator;
	
	//绑定用户注册表单验证
	@InitBinder("adminForm")
	protected void initBinder1(WebDataBinder binder) {
		binder.setValidator(adminSaveValidator);
	}
	//绑定用户修改信息表单验证
	@InitBinder("editForm")
	protected void initBinder2(WebDataBinder binder) {
		binder.setValidator(adminEditValidator);
	}
	
	@ModelAttribute("roleList")
	public Map<Integer,String> roleList(){
		Map<Integer, String> roleList = new LinkedHashMap<Integer, String>();
		roleList.put(-1, "全部");
		roleList.put(0, "管理员");
		roleList.put(1, "普通用户");
		return roleList;
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
	 * 分页显示Admin（无需校验）
	 * @ModelAttribute("listForm") 必不可少:表单的属性通过GET请求传递给后台，填充到listForm对象中。
	 * Model model 必不可少：数据处理后，通过model将数据返回给前端显示。
	 */
	@RequestMapping(value = "/admin/list", method = {RequestMethod.POST, RequestMethod.GET})
	public String list(@ModelAttribute("listForm") AdminForm listForm,Model model) {
		logger.debug("listAdmins()");
		int page = listForm.getPage();
		PageView<AdminEntity> pageView = new PageView<>(10,page);
		int firstindex = (pageView.getCurrentpage()-1)*pageView.getMaxresult();
		QueryResult<AdminEntity> queryResult = adminService.findAll(firstindex,10,listForm.getVisible(),listForm.getRole());
		pageView.setQueryResult(queryResult);
		model.addAttribute("pageView",pageView);
		return "manager/listAdmin";//跳转到manager/listAdmin.jsp页面
	}
	
	/**
	 * 跳转到更新用户界面
	 */
	@RequestMapping(value = "/admin/registerUI", method = RequestMethod.GET)
	public String registerUI(Model model) {
		logger.debug("registerUI() ");
		model.addAttribute("adminForm", new AdminForm());
		return "manager/register";//跳转到manager/updateAdmin.jsp页面
	}
	
	/**
	 * 用户注册（校验）
	 */
	@RequestMapping(value = "/admin/register", method = RequestMethod.POST)
	public String register(@ModelAttribute("adminForm") @Validated AdminForm adminForm,BindingResult result, Model model, 
			final RedirectAttributes redirectAttributes) {
		logger.debug("register() : "+adminForm);
		if (result.hasErrors()) {
			return "manager/register";//跳转到/register.jsp页面
		} else {
			redirectAttributes.addFlashAttribute("css", "success");
			redirectAttributes.addFlashAttribute("msg", "注册用户成功!");
			redirectAttributes.addAttribute("page", 1);//重定向传递参数,注册后跳转到第1页
			adminForm.setRole(1);//普通用户
			adminService.register(adminForm);
			return "redirect:/admin/list";//跳转到/admin/list
		}
	}
	
	/**
	 * 用户更新(校验)
	 */
	@RequestMapping(value = "/admin/edit", method = RequestMethod.POST)
	public String edit(@ModelAttribute("editForm") @Validated AdminForm editForm,
			BindingResult result, Model model, 
			final RedirectAttributes redirectAttributes) {
		logger.debug("updateAdmin() : "+editForm);
		if (result.hasErrors()) {
			return "manager/editAdmin";//跳转到manager/updateAdmin.jsp页面
		} else {
			redirectAttributes.addFlashAttribute("css", "success");
			redirectAttributes.addFlashAttribute("msg", "更新用户信息成功");
			redirectAttributes.addAttribute("page", editForm.getPage());
			redirectAttributes.addAttribute("visible", editForm.getVisible());
			redirectAttributes.addAttribute("role", editForm.getRole());
			AdminEntity adminEntity = adminService.findById(editForm.getId());//只需要将到form表单需要更新的字段更新到数据库即可（安全）
			adminEntity.setEmail(editForm.getEmail());
			adminEntity.setNickname(editForm.getNickname());
			adminEntity.setPhoneNumber(editForm.getPhoneNumber());
			adminEntity.setSex(editForm.getSex());
			adminService.update(adminEntity);
			//重定向传递GET参数有两种方式，方式一
			return "redirect:/admin/list";//跳转到/admin/list,正确做法是跳转到用户详细信息视图界面
		}
	}
	
	/**
	 * 跳转到更新用户界面
	 */
	@RequestMapping(value = "/admin/editUI", method = {RequestMethod.POST, RequestMethod.GET})
	public String editUI(AdminForm listForm, Model model) {
		logger.debug("showUpdateAdminForm() : "+listForm.getId());
		AdminEntity adminEntity = adminService.findById(listForm.getId());
		AdminForm admin = new AdminForm();//只需要将表单中有的字段添加到form表单即可（安全）
		admin.setEmail(adminEntity.getEmail());
		admin.setNickname(adminEntity.getNickname());
		admin.setPhoneNumber(adminEntity.getPhoneNumber());
		admin.setSex(adminEntity.getSex());
		admin.setId(listForm.getId());
		admin.setPage(listForm.getPage());
		admin.setVisible(listForm.getVisible());
		admin.setRole(listForm.getRole());
		model.addAttribute("editForm", admin);
		return "manager/editAdmin";//跳转到manager/editAdmin.jsp页面
	}
	
	/**
	 * 管理员删除用户
	 */
	@RequestMapping(value = "/admin/delete", method = {RequestMethod.POST, RequestMethod.GET})
	public String delete(AdminForm listForm,
			final RedirectAttributes redirectAttributes) {
		logger.debug("deleteAdmin() : "+listForm.getId());
		adminService.enable(listForm.getId(),listForm.getDeleted());
		//addFlashAttribute表示如果F5的时候，会发现参数丢失
		redirectAttributes.addFlashAttribute("css", "success");
		redirectAttributes.addFlashAttribute("msg", "删除用户成功!");
		//重定向传递GET参数有两种方式，方式二（addAttribute表示GET方式提交）
		redirectAttributes.addAttribute("page", listForm.getPage());//重定向传递参数，删除后跳转到page页
		redirectAttributes.addAttribute("visible", listForm.getVisible());
		redirectAttributes.addAttribute("role", listForm.getRole());
		return "redirect:/admin/list";
	}
}
