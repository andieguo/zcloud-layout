package com.zonesion.layout.service;

import java.util.List;

import com.zonesion.layout.model.AdminEntity;
import com.zonesion.layout.page.QueryResult;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月21日 上午11:47:26  
 * @version V1.0    
 */
public interface AdminService {
	
	public List<AdminEntity> findAll();
	
	public List<AdminEntity> findAll(int visible);
	
	public QueryResult<AdminEntity> findAll(int firstindex,int maxresult);
	
	public QueryResult<AdminEntity> findAll(int firstindex,int maxresult,int visible,int role,String nickname);
	
	public AdminEntity findById(int id);
	
	public AdminEntity login(String nickname,String password,int role);
	
	public boolean confirmPasswd(String password,int id);
	
	public int register(AdminEntity admin);
	
	public int delete(int id);
	
	public int update(AdminEntity admin);
	
	public boolean existAdminName(String nickname);

	public int enable(int id, int visible);
}
