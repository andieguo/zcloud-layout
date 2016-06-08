package com.zonesion.layout.dao;

import java.util.Date;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zonesion.layout.dao.ProjectDao;
import com.zonesion.layout.model.ProjectEntity;
import com.zonesion.layout.model.ProjectVO;
import com.zonesion.layout.model.TemplateEntity;
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
	private TemplateDao templateDao;
	@Override
	protected void setUp() throws Exception {
		// TODO Auto-generated method stub
		super.setUp();
		@SuppressWarnings("resource")
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		projectDao = (ProjectDao)context.getBean("projectDao");
		templateDao = (TemplateDao)context.getBean("templateDao");
	}
	
	public void testSave(){
		for(int i=0;i<100;i++){
			int sum = projectDao.save(new ProjectEntity("project"+i,"","", "/image/hello", 1, i%2, "111", "2", "128.9.0.0:0000", "文本", new Date(), new Date()));
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
	
	public void testFindByAdminIdPage1(){
		QueryResult<ProjectVO> queryResult = projectDao.findByAdminIdAndTemplate(-1, -1, -1, 0, 10);
		System.out.println(queryResult.getTotalrecord());
		for(ProjectVO p : queryResult.getResultlist()){
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
	
	public void testDeleteAll(){
		int[] ids = {28,29};
		System.out.println(projectDao.delete(ids));
	}
	
	public void testBuildContent(){
		ProjectEntity projectEntity = projectDao.findByProjectId(75);
		TemplateEntity templateEntity = templateDao.findByTemplateId(projectEntity.getTid());
		String layoutJSON = templateEntity.getLayoutJSON();
		JSONObject layoutObj = new JSONObject(layoutJSON);
//		System.out.println(entity.getMacList());
		String macList = projectEntity.getMacList();
		JSONArray array = new JSONArray(macList);
		for(int i=0;i<array.length();i++){
			JSONObject obj = array.getJSONObject(i);
			String tid = obj.getString("tid");
			JSONObject uiObj = layoutObj.getJSONObject(tid);
			obj.put("title", uiObj.getString("title"));
		}
//		System.out.println(array.toString());
		System.out.println(projectEntity);
	}
}

