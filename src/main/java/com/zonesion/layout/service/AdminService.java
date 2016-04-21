package com.zonesion.layout.service;

import java.util.List;

import com.zonesion.layout.model.AdminEntity;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月21日 上午11:47:26  
 * @version V1.0    
 */
public interface AdminService {
	
	public List<AdminEntity> findAll();
	
	public AdminEntity findById(int id);
	
	public boolean login(String nickname,String password);
	
	public int register(AdminEntity admin);
	
	public int delete(int id);
	
	public int update(AdminEntity admin);
	
	public boolean existAdminName(String nickname);
}
