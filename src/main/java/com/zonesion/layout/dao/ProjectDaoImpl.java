package com.zonesion.layout.dao;

import java.util.List;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

import com.zonesion.layout.model.ProjectEntity;
import com.zonesion.layout.page.QueryResult;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月21日 上午11:48:35  
 * @version V1.0    
 */
public class ProjectDaoImpl extends JdbcDaoSupport implements ProjectDao {

	@Override
	public List<ProjectEntity> findAll() {
		// TODO Auto-generated method stub
		return getJdbcTemplate().query("select * from tb_project", 
				new Object[] {}, new BeanPropertyRowMapper<ProjectEntity>(ProjectEntity.class));
	}
	
	@Override
	public QueryResult<ProjectEntity> findAll(int firstindex, int maxresult) {
		// TODO Auto-generated method stub
		QueryResult<ProjectEntity> queryResult = new QueryResult<ProjectEntity>();
		List<ProjectEntity> projectList = getJdbcTemplate().query("select * from tb_project where id limit ?,?", 
					new Object[] {firstindex,maxresult}, new BeanPropertyRowMapper<ProjectEntity>(ProjectEntity.class));
		int count = getJdbcTemplate().queryForObject("select count(*) from tb_project", Integer.class);
		queryResult.setResultlist(projectList);
		queryResult.setTotalrecord(count);
		return queryResult;
	}

	@Override
	public ProjectEntity findByProjectId(int pid) {
		// TODO Auto-generated method stub
		return getJdbcTemplate().queryForObject("select * from tb_project where id=?",
				new BeanPropertyRowMapper<ProjectEntity>(ProjectEntity.class), new Object[]{pid});
	}
	
	@Override
	public List<ProjectEntity> findByAdminId(int aid) {
		// TODO Auto-generated method stub
		return getJdbcTemplate().query("select * from tb_project where aid=?", 
				new Object[] {aid}, new BeanPropertyRowMapper<ProjectEntity>(ProjectEntity.class));
	}

	@Override
	public QueryResult<ProjectEntity> findByAdminId(int aid, int firstindex, int maxresult) {
		// TODO Auto-generated method stub
		QueryResult<ProjectEntity> queryResult = new QueryResult<ProjectEntity>();
		List<ProjectEntity> projectList = getJdbcTemplate().query("select * from tb_project where aid=? and id limit ?,?", 
					new Object[] {aid,firstindex,maxresult}, new BeanPropertyRowMapper<ProjectEntity>(ProjectEntity.class));
		int count = getJdbcTemplate().queryForObject("select count(*) from tb_project where aid=?",new Object[] {aid}, Integer.class);
		queryResult.setResultlist(projectList);
		queryResult.setTotalrecord(count);
		return queryResult;
	}
	
	@Override
	public int save(ProjectEntity projectEntity) {
		// TODO Auto-generated method stub
		return getJdbcTemplate().update(
				"insert into tb_project(name, imageUrl, tid, aid, zcloudID, zcloudKEY, serverAddr, macList, createTime, modifyTime) values (?,?,?,?,?,?,?,?,?,?)",
				new Object[] {projectEntity.getName(),projectEntity.getImageUrl(),projectEntity.getTid(),projectEntity.getAid()
						,projectEntity.getZcloudID(),projectEntity.getZcloudKEY(),projectEntity.getServerAddr(),projectEntity.getMacList()
						,projectEntity.getCreateTime(),projectEntity.getModifyTime()});
	}

	@Override
	public int delete(int id) {
		// TODO Auto-generated method stub
		return getJdbcTemplate().update("update tb_project set visible=0 where id=?",new Object[] {id});	
	}

	@Override
	public int update(ProjectEntity projectEntity) {
		// TODO Auto-generated method stub
		return getJdbcTemplate().update(
				"update tb_project set name=?, imageUrl=?, tid=?, aid=?, zcloudID=?, zcloudKEY=?, serverAddr=?, macList=?, createTime=?, modifyTime=? where id=?",
				new Object[] {projectEntity.getName(),projectEntity.getImageUrl(),projectEntity.getTid(),projectEntity.getAid()
						,projectEntity.getZcloudID(),projectEntity.getZcloudKEY(),projectEntity.getServerAddr(),projectEntity.getMacList()
						,projectEntity.getCreateTime(),projectEntity.getModifyTime(),projectEntity.getId()});
	}

}
