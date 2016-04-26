package com.zonesion.layout.dao;

import java.util.List;

import com.zonesion.layout.model.AdminEntity;
import com.zonesion.layout.page.QueryResult;


/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月21日 上午11:37:26  
 * @version V1.0    
 */
public interface AdminDao {

	public List<AdminEntity> findAll();
	
	public QueryResult<AdminEntity> findAll(int firstindex,int maxresult);
	
	public QueryResult<AdminEntity> findAll(int firstindex,int maxresult,int visible,int role);
	
	public AdminEntity findById(int id);
	
	public boolean login(String nickname,String password);
	
	public int register(AdminEntity admin);
	
	public int delete(int id);
	
	public int update(AdminEntity admin);
	
	public boolean existAdminName(String nickname);

	public int enable(int id, int visible);
	
}
