package com.zonesion.layout.dao;

import java.util.Date;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zonesion.layout.dao.ProjectDao;
import com.zonesion.layout.model.ProjectEntity;
import com.zonesion.layout.page.QueryResult;

import junit.framework.TestCase;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月21日 下午2:58:37  
 * @version V1.0    
 */
public class ProjectDaoTest extends TestCase {

	private ProjectDao projectDao;
	@Override
	protected void setUp() throws Exception {
		// TODO Auto-generated method stub
		super.setUp();
		@SuppressWarnings("resource")
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		projectDao = (ProjectDao)context.getBean("projectDao");
	}
	
	public void testSave(){
		for(int i=0;i<100;i++){
			int sum = projectDao.save(new ProjectEntity("project"+i, "/image/hello", 1, i%2, "111", "2", "128.9.0.0:0000", "文本", new Date(), new Date()));
			System.out.println(sum);
		}
	}

	public void testFindAll(){
		for(ProjectEntity project:projectDao.findAll()){
			System.out.println(project);
		}
	}
	
	public void testFindAllPage(){
		QueryResult<ProjectEntity> queryResult = projectDao.findAll(10, 10);
		System.out.println(queryResult.getTotalrecord());
		for(ProjectEntity p : queryResult.getResultlist()){
			System.out.println(p);
		}
	}
	
	public void testFindByProjectId(){
		System.out.println(projectDao.findByProjectId(1));
	}
	
	public void testFindByAdminId(){
		for(ProjectEntity project:projectDao.findByAdminId(0)){
			System.out.println(project);
		}
	}
	
	public void testFindByAdminIdPage(){
		QueryResult<ProjectEntity> queryResult = projectDao.findByAdminId(0,10, 10);
		System.out.println(queryResult.getTotalrecord());
		for(ProjectEntity p : queryResult.getResultlist()){
			System.out.println(p);
		}
	}
	
	public void testUpdate(){
		ProjectEntity p = projectDao.findByProjectId(1);
		p.setImageUrl("hello");
		int sum = projectDao.update(p);
		System.out.println(sum);
	}
	
	public void testDelete(){
		System.out.println(projectDao.delete(1));
	}
}

