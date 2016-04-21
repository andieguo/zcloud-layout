package com.zonesion.layout.dao;

import java.util.List;

import com.zonesion.layout.model.TemplateEntity;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月21日 上午11:38:19  
 * @version V1.0    
 */
public interface TemplateDao {

	public List<TemplateEntity> findAll();
	
	public TemplateEntity findByTemplateId(int tid);
	
	public List<TemplateEntity> findByAdminId(int aid);
	
	/**
	 * 根据管理员id和模板类型获取模板
	 */
	public List<TemplateEntity> findByAdminAndType(int aid,int type);
	
	public int save(TemplateEntity templateEntity);
	
	public int delete(int id);
	
	public int update(TemplateEntity templateEntity);
}
