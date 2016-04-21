package com.zonesion.layout;

import java.util.Date;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zonesion.layout.dao.AdminDao;
import com.zonesion.layout.model.AdminEntity;

import junit.framework.TestCase;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月21日 下午2:27:42  
 * @version V1.0    
 */
public class AdminDaoTest extends TestCase{

	private AdminDao adminDao;

	@Override
	protected void setUp() throws Exception {
		// TODO Auto-generated method stub
		@SuppressWarnings("resource")
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		adminDao = (AdminDao)context.getBean("adminDao");
	}
	
	public void testRegister(){
		int sum = adminDao.register(new AdminEntity("andy", "andy", "123456","123456@qq.com", 0, 0, new Date(), new Date()));
		System.out.println("sum:"+sum);
	}
	
	public void testFindById(){
		System.out.println(adminDao.findById(2));
	}
	
	public void testFindByAdminName(){
		System.out.println(adminDao.existAdminName("andy"));
		System.out.println(adminDao.existAdminName("adndy"));
	}
	
	public void testLogin(){
		System.out.println(adminDao.login("adny", "andy"));
		System.out.println(adminDao.login("andy","andy"));
	}
	
	public void testFindAll(){
		for(AdminEntity admin: adminDao.findAll()){
			System.out.println(admin);
		}
	}
	
	public void testUpdate(){
		AdminEntity admin = adminDao.findById(2);
		admin.setEmail("andy@qq.com");
		System.out.println(adminDao.update(admin));
	}
	
	public void testDelete(){
		System.out.println(adminDao.delete(2));
	}
}
