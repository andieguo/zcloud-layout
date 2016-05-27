package com.zonesion.layout.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zonesion.layout.dao.ProjectDao;
import com.zonesion.layout.model.ProjectEntity;
import com.zonesion.layout.model.ProjectVO;
import com.zonesion.layout.page.QueryResult;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月21日 下午3:07:35  
 * @version V1.0    
 */
@Service("projectService")
public class ProjectServiceImpl implements ProjectService {

	@Resource
	private ProjectDao projectDao;
	
	@Override
	public List<ProjectEntity> findAll() {
		// TODO Auto-generated method stub
		return projectDao.findAll();
	}

	@Override
	public ProjectEntity findByProjectId(int pid) {
		// TODO Auto-generated method stub
		return projectDao.findByProjectId(pid);
	}

	@Override
	public List<ProjectEntity> findByAdminId(int aid) {
		// TODO Auto-generated method stub
		return projectDao.findByAdminId(aid);
	}

	@Override
	public int save(ProjectEntity projectEntity) {
		// TODO Auto-generated method stub
		return projectDao.save(projectEntity);
	}

	@Override
	public int delete(int id) {
		// TODO Auto-generated method stub
		return projectDao.delete(id);
	}
	
	@Override
	public int delete(int[] ids) {
		// TODO Auto-generated method stub
		return projectDao.delete(ids);
	}

	@Override
	public int update(ProjectEntity projectEntity) {
		// TODO Auto-generated method stub
		return projectDao.update(projectEntity);
	}

	@Override
	public QueryResult<ProjectEntity> findAll(int firstindex, int maxresult) {
		// TODO Auto-generated method stub
		return projectDao.findAll(firstindex, maxresult);
	}

	@Override
	public QueryResult<ProjectEntity> findByAdminId(int aid, int firstindex, int maxresult) {
		// TODO Auto-generated method stub
		return projectDao.findByAdminId(aid, firstindex, maxresult);
	}

	@Override
	public QueryResult<ProjectVO> findByAdminIdAndTemplate(int aid, int tid, int visible, int firstindex, int maxresult) {
		// TODO Auto-generated method stub
		return projectDao.findByAdminIdAndTemplate(aid, tid, visible, firstindex, maxresult);
	}

	@Override
	public int enable(int id, int visible) {
		// TODO Auto-generated method stub
		return projectDao.enable(id, visible);
	}

	@Override
	public QueryResult<ProjectVO> findByAdminIdAndTemplate(String nickname, String templatename, String name,int visible, int firstindex, int maxresult) {
		// TODO Auto-generated method stub
		return projectDao.findByAdminIdAndTemplate(nickname, templatename,name, visible, firstindex, maxresult);
	}

}
