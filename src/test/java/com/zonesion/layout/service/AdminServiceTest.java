package com.zonesion.layout.service;

import java.util.Date;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zonesion.layout.model.AdminEntity;
import com.zonesion.layout.page.QueryResult;

import junit.framework.TestCase;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月21日 下午2:27:42  
 * @version V1.0    
 */
public class AdminServiceTest extends TestCase{

	private AdminService adminService;

	@Override
	protected void setUp() throws Exception {
		// TODO Auto-generated method stub
		@SuppressWarnings("resource")
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		adminService = (AdminService)context.getBean("adminService");
	}
	
	public void testRegister(){
		for(int i=0;i<100;i++){
			adminService.register(new AdminEntity("andy"+i, "andy"+i, "123456","123456@qq.com", 0, 0, new Date(), new Date()));
		}
	}
	
	public void testFindById(){
		System.out.println(adminService.findById(2));
	}
	
	public void testFindByAdminName(){
		System.out.println(adminService.existAdminName("andy"));
		System.out.println(adminService.existAdminName("adndy"));
	}
	
	public void testLogin(){
		System.out.println(adminService.login("adny", "andy"));
		System.out.println(adminService.login("andy","andy"));
	}
	
	public void testFindAll(){
		for(AdminEntity admin: adminService.findAll()){
			System.out.println(admin);
		}
	}
	//第0页
	public void testFindAllPage0(){
		QueryResult<AdminEntity> queryResult = adminService.findAll(0, 10);
		System.out.println(queryResult.getTotalrecord());
		for(AdminEntity admin:queryResult.getResultlist()){
			System.out.println(admin);
		}
	}
	
	//第0页
	public void testFindAllPage1(){
		QueryResult<AdminEntity> queryResult = adminService.findAll(0+10, 10);
		System.out.println(queryResult.getTotalrecord());
		for(AdminEntity admin:queryResult.getResultlist()){
			System.out.println(admin);
		}
	}
	
	public void testUpdate(){
		AdminEntity admin = adminService.findById(2);
		admin.setEmail("andy@qq.com");
		System.out.println(adminService.update(admin));
	}
	
	public void testDelete(){
		System.out.println(adminService.delete(2));
	}
}
