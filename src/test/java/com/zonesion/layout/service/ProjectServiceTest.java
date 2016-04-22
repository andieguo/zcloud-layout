package com.zonesion.layout.service;

import java.util.Date;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zonesion.layout.model.ProjectEntity;
import com.zonesion.layout.page.QueryResult;

import junit.framework.TestCase;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月21日 下午2:58:37  
 * @version V1.0    
 */
public class ProjectServiceTest extends TestCase {

	private ProjectService projectService;
	@Override
	protected void setUp() throws Exception {
		// TODO Auto-generated method stub
		super.setUp();
		@SuppressWarnings("resource")
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		projectService = (ProjectService)context.getBean("projectService");
	}
	
	public void testSave(){
		for(int i=0;i<100;i++){
			int sum = projectService.save(new ProjectEntity("project"+i, "/image/hello", 1, i%2, "111", "2", "128.9.0.0:0000", "文本", new Date(), new Date()));
			System.out.println(sum);
		}
	}

	public void testFindAll(){
		for(ProjectEntity project:projectService.findAll()){
			System.out.println(project);
		}
	}
	
	public void testFindAllPage(){
		QueryResult<ProjectEntity> queryResult = projectService.findAll(10, 10);
		System.out.println(queryResult.getTotalrecord());
		for(ProjectEntity p : queryResult.getResultlist()){
			System.out.println(p);
		}
	}
	
	public void testFindByProjectId(){
		System.out.println(projectService.findByProjectId(1));
	}
	
	public void testFindByAdminId(){
		for(ProjectEntity project:projectService.findByAdminId(0)){
			System.out.println(project);
		}
	}
	
	public void testFindByAdminIdPage(){
		QueryResult<ProjectEntity> queryResult = projectService.findByAdminId(0,10, 10);
		System.out.println(queryResult.getTotalrecord());
		for(ProjectEntity p : queryResult.getResultlist()){
			System.out.println(p);
		}
	}
	
	public void testUpdate(){
		ProjectEntity p = projectService.findByProjectId(1);
		p.setImageUrl("hello");
		int sum = projectService.update(p);
		System.out.println(sum);
	}
	
	public void testDelete(){
		System.out.println(projectService.delete(1));
	}
}

