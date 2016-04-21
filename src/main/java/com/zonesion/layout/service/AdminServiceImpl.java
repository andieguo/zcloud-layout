package com.zonesion.layout.service;

import java.util.List;

import com.zonesion.layout.model.AdminEntity;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月21日 下午2:46:36  
 * @version V1.0    
 */
public class AdminServiceImpl implements AdminService {

	@Override
	public List<AdminEntity> findAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public AdminEntity findById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean login(String nickname, String password) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public int register(AdminEntity admin) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(int id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(AdminEntity admin) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean existAdminName(String nickname) {
		// TODO Auto-generated method stub
		return false;
	}

}
