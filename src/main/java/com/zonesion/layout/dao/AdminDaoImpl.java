package com.zonesion.layout.dao;

import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

import com.zonesion.layout.model.AdminEntity;

/**
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO
 * @date 2016年4月21日 上午11:48:19
 * @version V1.0
 */
public class AdminDaoImpl extends JdbcDaoSupport implements AdminDao {

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<AdminEntity> findAll() {
		// TODO Auto-generated method stub
		return getJdbcTemplate().query("select * from tb_admin", 
				new Object[] {}, new BeanPropertyRowMapper(AdminEntity.class));
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public AdminEntity findById(int id) {
		// TODO Auto-generated method stub
		return getJdbcTemplate().queryForObject("select * from tb_admin where id=?",
				new BeanPropertyRowMapper(AdminEntity.class), new Object[]{id});
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public boolean login(String nickname,String password) {
		// TODO Auto-generated method stub
		try{
			getJdbcTemplate().queryForObject("select * from tb_admin where nickname=? and password=?", 
					new BeanPropertyRowMapper(AdminEntity.class), new Object[]{nickname,password});
		}catch(Exception e){
			if(e instanceof EmptyResultDataAccessException){
				return false;
			}
		}
		return true;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public boolean existAdminName(String nickname) {
		// TODO Auto-generated method stub
		try{
			getJdbcTemplate().queryForObject("select * from tb_admin where nickname=?", 
					new BeanPropertyRowMapper(AdminEntity.class), new Object[]{nickname});
		}catch(Exception e){
			if(e instanceof EmptyResultDataAccessException){
				return false;
			}
		}
		return true;
	}

	@Override
	public int register(AdminEntity admin) {
		// TODO Auto-generated method stub
		return getJdbcTemplate().update(
				"insert into tb_admin(nickname,password,phoneNumber,email,sex,role,landingTime,exitTime) values (?,?,?,?,?,?,?,?)",
				new Object[] {admin.getNickname(),admin.getPassword(),admin.getPhoneNumber(),admin.getEmail(),admin.getSex(),admin.getRole(),admin.getLandingTime(),admin.getExitTime()});
	}

	@Override
	public int delete(int id) {
		// TODO Auto-generated method stub
		return getJdbcTemplate().update("update tb_admin set visible=0 where id=?",new Object[] {id});	
	}

	@Override
	public int update(AdminEntity admin) {
		// TODO Auto-generated method stub
		return getJdbcTemplate().update(
				"update tb_admin set nickname=?,password=?,phoneNumber=?,email=?,sex=?,role=?,landingTime=?,exitTime=? where id=?",
				new Object[] {admin.getNickname(),admin.getPassword(),admin.getPhoneNumber(),admin.getEmail(),admin.getSex(),admin.getRole(),admin.getLandingTime(),admin.getExitTime(),admin.getId()});	
	}

}
