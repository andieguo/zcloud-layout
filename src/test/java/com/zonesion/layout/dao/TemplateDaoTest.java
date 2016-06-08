package com.zonesion.layout.dao;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.Date;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONStringer;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zonesion.layout.dao.TemplateDao;
import com.zonesion.layout.model.ProjectEntity;
import com.zonesion.layout.model.TemplateEntity;
import com.zonesion.layout.model.TemplateVO;
import com.zonesion.layout.page.QueryResult;
import com.zonesion.layout.util.JsonFormatter;
import com.zonesion.layout.util.JsonFormatterTool;

import junit.framework.TestCase;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月21日 下午3:17:20  
 * @version V1.0    
 */
public class TemplateDaoTest extends TestCase {

	private TemplateDao templateDao;
	private ProjectDao projectDao;
	@Override
	protected void setUp() throws Exception {
		// TODO Auto-generated method stub
		super.setUp();
		@SuppressWarnings("resource")
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		templateDao = (TemplateDao)context.getBean("templateDao");
		projectDao = (ProjectDao) context.getBean("projectDao");
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
		for(TemplateEntity t:templateDao.findByAdminId(1,1)){
			System.out.println(t);
		}
	}
	
	public void testFindByAdminId2(){
		for(Integer t:templateDao.findByAdminId(2)){
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
		for(TemplateEntity t : templateDao.findByAdminAndType(1, 0,1)){
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
	
	/**
	 * 测试生成模板文件
	 */
	public void testExport(){
		TemplateEntity templateEntity = templateDao.findByTemplateId(37);
		JSONObject result = new JSONObject();// 构建一个JSONObject
		result.accumulate("name", templateEntity.getName());
		result.accumulate("content", templateEntity.getLayoutContent());
		JSONObject layoutJSON = new JSONObject(templateEntity.getLayoutJSON());
		result.accumulate("layout",layoutJSON);
		  // 写字符换转成字节流（使用GBK编码进行写）
        FileOutputStream outputStream;
		try {
			outputStream = new FileOutputStream(new File("E:\\export1"));
			OutputStreamWriter writer = new OutputStreamWriter(outputStream,"UTF-8");
			writer.write(result.toString());
			writer.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 测试导入模板文件
	 */
	public void testImport() throws IOException{
		//读文件,使用本地环境中的默认字符集，例如在中文环境中将使用 GBK编码
        BufferedReader in = new BufferedReader(new InputStreamReader(new FileInputStream("E:\\export1"),"UTF-8"));
        StringBuffer content = new StringBuffer();
        String line = null;
        while((line = in.readLine()) != null){
        	content.append(line);
        }
        in.close();
        //解析上传文件内容
        JSONObject jsonObject = new JSONObject(content.toString());
        String layoutContent = jsonObject.getString("content");
        String name = jsonObject.getString("name");
        JSONObject layoutJSON = jsonObject.getJSONObject("layout");
		templateDao.save(new TemplateEntity(name, layoutJSON.toString(), layoutContent, 1, 1, new Date(), new Date()));
	}
	
	/**
	 * 测试JSON转义
	 */
	public void testJSON(){
		String content = "{\"content\":\"<div class=\"lyrow ui-draggable\" style=\"display: block;\"><a href=\"#close\" class=\"remove label label-important\"><i class=\"icon-remove icon-white\"></i>删除</a><span class=\"drag label\"><i class=\"icon-move\"></i>拖动</span><div class=\"preview\"><input value=\"6 6\" type=\"text\"></div><div class=\"view\"><div class=\"row-fluid clearfix\"><div class=\"span6 column ui-sortable\"></div><div class=\"span6 column ui-sortable\"></div></div></div></div>\",\"layout\":\"\",\"name\":\"湖南师范模板\"}";
		content = "{\"content\":\"<div class=\"lyrow ui-draggable\"\",\"layout\":\"{}\",\"name\":\"湖南师范模板\"}";
		JSONObject jsonObject = new JSONObject(content);
        String name = jsonObject.getString("name");
        String layoutContent = jsonObject.getString("content");
        String layoutJSON = jsonObject.getString("layout");
        templateDao.save(new TemplateEntity(name, layoutJSON, layoutContent, 1, 1, new Date(), new Date()));
	}
	
	/**
	 * 测试导出工程文件(不保存JSON元素顺序+格式化输出)
	 */
	public void testExportProject() throws Exception{
		ProjectEntity projectEntity = projectDao.findByProjectId(34);
		JSONObject result = new JSONObject();// 构建一个JSONObject
		result.put("name", projectEntity.getName());
		result.put("tid", projectEntity.getTid());
		result.put("imageUrl", projectEntity.getImageUrl());
		result.put("zcloudID", projectEntity.getZcloudID());
		result.put("zcloudKEY", projectEntity.getZcloudKEY());
		result.put("serverAddr", projectEntity.getServerAddr());
		JSONArray macListArray = new JSONArray(projectEntity.getMacList());
		result.put("macList",macListArray);
		 // 写字符换转成字节流（使用GBK编码进行写）
        FileOutputStream outputStream;
		try {
			outputStream = new FileOutputStream(new File("E:\\export2"));
			OutputStreamWriter writer = new OutputStreamWriter(outputStream,"UTF-8");
			writer.write(JsonFormatter.to(result));//格式化输出
			writer.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//无序输出
	public void testJSON2(){
		JSONObject obj = new JSONObject();
		obj.append("name", "hello");
		obj.append("name2", "asdfa");
		obj.append("name3", "adsfaf");
		System.out.println(obj.toString());
	}
	//有序输出
	public void testJSON3(){
		JSONStringer jsonStringer = new JSONStringer();  
        try {  
		   jsonStringer.object();  
           jsonStringer.key("name").value("Jason");  
           jsonStringer.key("id").value(20130001);  
           jsonStringer.key("phone").value("13579246810");  
           jsonStringer.endObject();  
       } catch (JSONException e) {  
           e.printStackTrace();  
       }  
       System.out.println(jsonStringer.toString()); 
	}
	
	/**
	 * 测试导出工程文件(保持JSON元素顺序+格式化输出)
	 */
	public void testExportProject2() throws Exception{
		ProjectEntity projectEntity = projectDao.findByProjectId(42);
		JSONStringer result = new JSONStringer();  
		result.object();
		result.key("name").value(projectEntity.getName());
		result.key("tid").value(projectEntity.getTid());
		result.key("imageUrl").value(projectEntity.getImageUrl());
		result.key("zcloudID").value(projectEntity.getZcloudID());
		result.key("zcloudKEY").value(projectEntity.getZcloudKEY());
		result.key("serverAddr").value(projectEntity.getServerAddr());
		JSONArray macListArray = new JSONArray(projectEntity.getMacList());
		result.key("macList").value(macListArray);
		result.endObject(); 
		System.out.println(result.toString());
		 // 写字符换转成字节流（使用GBK编码进行写）
        FileOutputStream outputStream;
		try {
			outputStream = new FileOutputStream(new File("E:\\export2"));
			OutputStreamWriter writer = new OutputStreamWriter(outputStream,"UTF-8");
			writer.write(JsonFormatterTool.formatJson(result.toString()));//格式化输出
			writer.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
