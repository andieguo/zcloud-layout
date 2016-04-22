package com.zonesion.layout.service;

import java.util.List;

import com.zonesion.layout.model.TemplateEntity;
import com.zonesion.layout.page.QueryResult;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月21日 上午11:47:50  
 * @version V1.0    
 */
public interface TemplateService {

public List<TemplateEntity> findAll();
	
	public QueryResult<TemplateEntity> findAll(int firstindex, int maxresult);
	
	public TemplateEntity findByTemplateId(int tid);
	
	public List<TemplateEntity> findByAdminId(int aid);
	
	public QueryResult<TemplateEntity> findByAdminId(int aid,int firstindex, int maxresult);
	
	/**
	 * 根据管理员id和模板类型获取模板
	 */
	public List<TemplateEntity> findByAdminAndType(int aid,int type);
	
	public QueryResult<TemplateEntity> findByAdminAndType(int aid,int type,int firstindex, int maxresult);
	
	public int save(TemplateEntity templateEntity);
	
	public int delete(int id);
	
	public int update(TemplateEntity templateEntity);
}
