package com.zonesion.layout.dao;

import java.util.List;

import com.zonesion.layout.model.TemplateEntity;
import com.zonesion.layout.model.TemplateVO;
import com.zonesion.layout.page.QueryResult;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月21日 上午11:38:19  
 * @version V1.0    
 */
public interface TemplateDao {

	/**
	 * 查找所有管理员存在的TemplateEntity集合
	 */
	public List<TemplateEntity> findAll();
	
	/**
	 * 分页查找所有管理员存在的TemplateEntity集合
	 */
	public QueryResult<TemplateEntity> findAll(int firstindex, int maxresult);
	
	/**
	 * 根据ID查找管理员存在的TemplateEntity
	 */
	public TemplateEntity findByTemplateId(int tid);
	
	/**
	 * 根据管理员ID查找TemplateEntity
	 */
	public List<TemplateEntity> findByAdminId(int aid,int visible);
	
	public List<Integer> findByAdminId(int aid);
	
	/**
	 * 分页根据管理员ID查找TemplateEntity集合
	 */
	public QueryResult<TemplateEntity> findByAdminId(int aid,int firstindex, int maxresult);
	
	/**
	 * 根据管理员id和模板类型获取模板TemplateEntity集合
	 */
	public List<TemplateEntity> findByAdminAndType(int aid,int type);
	
	/**
	 * 根据模板类型获取模板TemplateEntity集合
	 */
	public List<TemplateEntity> findByType(int type);
	
	/**
	 * 分页根据管理员id和模板类型获取模板TemplateEntity集合
	 */
	public QueryResult<TemplateEntity> findByAdminAndType(int aid,int type,int firstindex, int maxresult);
	
	/**
	 * 分页根据管理员id、模板类型、visible获取模板TemplateEntity集合
	 */
	public QueryResult<TemplateVO> findByAdminAndType(int aid, int type, int visible,int firstindex, int maxresult);
	
	public QueryResult<TemplateVO> findByAdminAndType(String nickname,String templatename, int type, int visible,int firstindex, int maxresult);
	
	public int save(TemplateEntity templateEntity);
	
	public int delete(int id);
	
	public int delete(int[] ids,int aid);
	
	public int delete(int[] ids);
	
	public int enable(int id,int visible);
	
	public int update(TemplateEntity templateEntity);
}
