package com.zonesion.layout.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zonesion.layout.dao.AdminDao;
import com.zonesion.layout.model.AdminEntity;
import com.zonesion.layout.page.QueryResult;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月21日 下午2:46:36  
 * @version V1.0    
 */
@Service("adminService")
public class AdminServiceImpl implements AdminService {

	@Resource
	private AdminDao adminDao;
	
	@Override
	public List<AdminEntity> findAll() {
		// TODO Auto-generated method stub
		return adminDao.findAll();
	}
	
	@Override
	public List<AdminEntity> findAll(int visible) {
		// TODO Auto-generated method stub
		return adminDao.findAll(visible);
	}

	@Override
	public AdminEntity findById(int id) {
		// TODO Auto-generated method stub
		return adminDao.findById(id);
	}

	@Override
	public boolean login(String nickname, String password) {
		// TODO Auto-generated method stub
		return adminDao.login(nickname, password);
	}

	@Override
	public int register(AdminEntity admin) {
		// TODO Auto-generated method stub
		return adminDao.register(admin);
	}

	@Override
	public int delete(int id) {
		// TODO Auto-generated method stub
		return adminDao.delete(id);
	}
	
	@Override
	public int enable(int id,int visible) {
		// TODO Auto-generated method stub
		return adminDao.enable(id,visible);
	}

	@Override
	public int update(AdminEntity admin) {
		// TODO Auto-generated method stub
		return adminDao.update(admin);
	}

	@Override
	public boolean existAdminName(String nickname) {
		// TODO Auto-generated method stub
		return adminDao.existAdminName(nickname);
	}

	@Override
	public QueryResult<AdminEntity> findAll(int firstindex, int maxresult) {
		// TODO Auto-generated method stub
		return adminDao.findAll(firstindex, maxresult);
	}

	@Override
	public QueryResult<AdminEntity> findAll(int firstindex, int maxresult, int visible, int role) {
		// TODO Auto-generated method stub
		return adminDao.findAll(firstindex, maxresult, visible, role);
	}

}
