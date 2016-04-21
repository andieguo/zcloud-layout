package com.zonesion.layout;

import java.util.Date;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zonesion.layout.dao.TemplateDao;
import com.zonesion.layout.model.TemplateEntity;

import junit.framework.TestCase;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月21日 下午3:17:20  
 * @version V1.0    
 */
public class TemplateDaoTest extends TestCase {

	private TemplateDao templateDao;
	@Override
	protected void setUp() throws Exception {
		// TODO Auto-generated method stub
		super.setUp();
		@SuppressWarnings("resource")
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		templateDao = (TemplateDao)context.getBean("templateDao");
	}

	public void testSave(){
		int sum = templateDao.save(new TemplateEntity("template2", "JSON", "CONTENT", 1, 1, new Date(), new Date()));
		System.out.println(sum);
	}
	
	public void testFindAll(){
		for(TemplateEntity t : templateDao.findAll()){
			System.out.println(t);
		}
	}
	
	public void testFindByTemplateId(){
		System.out.println(templateDao.findByTemplateId(1));
	}
	
	public void testFindByAdminId(){
		for(TemplateEntity t:templateDao.findByAdminId(1)){
			System.out.println(t);
		}
	}
	
	public void testFindByAdminAndType(){
		for(TemplateEntity t : templateDao.findByAdminAndType(1, 0)){
			System.out.println(t);
		}
	}
	
	public void testUpdate(){
		TemplateEntity t = templateDao.findByTemplateId(1);
		t.setName("templateNew");
		templateDao.update(t);
	}
	
	public void testDelete(){
		templateDao.delete(1);
	}
}
