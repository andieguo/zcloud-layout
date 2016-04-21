package com.zonesion.layout.service;

import java.util.List;

import com.zonesion.layout.model.ProjectEntity;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月21日 上午11:47:39  
 * @version V1.0    
 */
public interface ProjectService {

	public List<ProjectEntity> findAll();
	
	public ProjectEntity findByProjectId(int pid);
	
	public List<ProjectEntity> findByAdminId(int aid);
	
	public int save(ProjectEntity projectEntity);
	
	public int delete(int id);
	
	public int update(ProjectEntity projectEntity);
	
}
