package com.zonesion.layout.dao;

import java.util.Date;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zonesion.layout.dao.TemplateDao;
import com.zonesion.layout.model.TemplateEntity;
import com.zonesion.layout.model.TemplateVO;
import com.zonesion.layout.page.QueryResult;

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
		for(int i=0;i<100;i++){
			int sum = templateDao.save(new TemplateEntity("template"+i, "JSON", "CONTENT", i%2, i%2, new Date(), new Date()));
			System.out.println(sum);
		}
	}
	
	public void testFindAll(){
		for(TemplateEntity t : templateDao.findAll()){
			System.out.println(t);
		}
	}
	
	public void testFindAllPage(){
		QueryResult<TemplateEntity> q = templateDao.findAll(0,10);
		for(TemplateEntity t : q.getResultlist()){
			System.out.println(t);
		}
		System.out.println(q.getTotalrecord());
	}
	
	public void testFindByTemplateId(){
		System.out.println(templateDao.findByTemplateId(1));
	}
	
	public void testFindByAdminId(){
		for(TemplateEntity t:templateDao.findByAdminId(1)){
			System.out.println(t);
		}
	}
	
	public void testFindByAdminIdPage(){
		QueryResult<TemplateEntity> q = templateDao.findByAdminId(1,10,10);
		for(TemplateEntity t : q.getResultlist()){
			System.out.println(t);
		}
		System.out.println(q.getTotalrecord());
		QueryResult<TemplateEntity> q1 = templateDao.findByAdminId(1,20,10);
		for(TemplateEntity t : q1.getResultlist()){
			System.out.println(t);
		}
		System.out.println(q1.getTotalrecord());
	}
	
	public void testFindByAdminAndType(){
		for(TemplateEntity t : templateDao.findByAdminAndType(1, 0)){
			System.out.println(t);
		}
	}
	
	public void testFindByAdminAndTypePage(){
		QueryResult<TemplateEntity> q = templateDao.findByAdminAndType(1,0,0,10);
		for(TemplateEntity t : q.getResultlist()){
			System.out.println(t);
		}
		System.out.println(q.getTotalrecord());
		QueryResult<TemplateEntity> q1 = templateDao.findByAdminAndType(1,0,0,10);
		for(TemplateEntity t : q1.getResultlist()){
			System.out.println(t);
		}
		System.out.println(q1.getTotalrecord());
	}
	
	public void testFindByAdminAndTypePage2(){
		//所有管理员、所有类型、删除+未删除
		QueryResult<TemplateVO> q = templateDao.findByAdminAndType(-1,-1,-1,0,10);
		for(TemplateVO t : q.getResultlist()){
			System.out.println(t);
		}
		System.out.println(q.getTotalrecord());
		//所有管理员、所有类型、已删除
		QueryResult<TemplateVO> q1 = templateDao.findByAdminAndType(-1,-1,1,0,10);
		for(TemplateVO t : q1.getResultlist()){
			System.out.println(t);
		}
		System.out.println(q1.getTotalrecord());
	}
	
	public void testFindByAdminAndTypePage3(){
		//所有管理员、所有类型、删除+未删除
		QueryResult<TemplateVO> q = templateDao.findByAdminAndType(-1,0,-1,0,10);
		for(TemplateVO t : q.getResultlist()){
			System.out.println(t);
		}
		System.out.println(q.getTotalrecord());
		//所有管理员、所有类型、已删除
		QueryResult<TemplateVO> q1 = templateDao.findByAdminAndType(-1,1,1,0,10);
		for(TemplateVO t : q1.getResultlist()){
			System.out.println(t);
		}
		System.out.println(q1.getTotalrecord());
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
