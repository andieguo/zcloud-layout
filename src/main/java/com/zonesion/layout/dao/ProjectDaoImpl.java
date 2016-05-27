package com.zonesion.layout.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

import com.google.common.collect.Lists;
import com.zonesion.layout.model.ProjectEntity;
import com.zonesion.layout.model.ProjectVO;
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
		return getJdbcTemplate().query("select * from tb_project where visible=1 and aid in ( select id from tb_admin where visible=1)", 
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
	public int delete(int[] ids) {
		// TODO Auto-generated method stub
		//delete from tb_project where id in (?,?,?,?);
		if(ids.length > 0){
			Object[] params = new Object[ids.length];
			StringBuffer sql = new StringBuffer("delete from tb_project where id in (");
			for(int i=0;i<ids.length;i++){
				params[i] = ids[i];
				sql.append("?,");
			}
			sql.delete(sql.length()-1, sql.length()).append(")");
			return getJdbcTemplate().update(sql.toString(),params);	
		}else{
			return -1;
		}
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

	@Override
	public QueryResult<ProjectVO> findByAdminIdAndTemplate(int aid, int tid, int visible, int firstindex, int maxresult) {
		// TODO Auto-generated method stub
		QueryResult<ProjectVO> queryResult = new QueryResult<ProjectVO>();
		StringBuffer sql  = new StringBuffer("select t1.*,t2.name as templatename,nickname from tb_project t1 inner join tb_template t2 on t1.tid=t2.id inner join tb_admin t3 on t1.aid=t3.id where 1=1");
		StringBuffer countSql = new StringBuffer("select count(*) from tb_project t1 inner join tb_template t2 on t1.tid=t2.id inner join tb_admin t3 on t1.aid=t3.id where 1=1");
		List<Integer> parmas = Lists.newArrayList();
		List<Integer> countParmas = Lists.newArrayList();
		if(aid != -1){//aid=-1表示所有存在的管理员
			sql.append(" and t1.aid=?");
			parmas.add(aid);
			countSql.append(" and t1.aid=?");
			countParmas.add(aid);
		}else{
			sql.append(" and t3.visible=1");
			countSql.append(" and t3.visible=1");
		}
		if(tid != -1){//type=-1表示存在模板的ID
			sql.append(" and t1.tid=?");
			parmas.add(tid);
			countSql.append(" and t1.tid=?");
			countParmas.add(tid);
		}else{
			sql.append(" and t2.visible=1");
			countSql.append(" and t2.visible=1");
		}
		if(visible != -1){//visibel=-1包括删除、未删除模板
			sql.append(" and t1.visible=?");
			parmas.add(visible);
			countSql.append(" and t1.visible=?");
			countParmas.add(visible);
		}
		sql.append(" and t1.id limit ?,?");
		parmas.add(firstindex);
		parmas.add(maxresult);
		List<ProjectVO> projectList = getJdbcTemplate().query(sql.toString(), parmas.toArray(),
				new RowMapper<ProjectVO>(){
					@Override
					public ProjectVO mapRow(ResultSet rs, int rowNum) throws SQLException {
						// TODO Auto-generated method stub
						ProjectVO projectVO = new ProjectVO();
						projectVO.setId(rs.getInt("id"));
						projectVO.setName(rs.getString("name"));
						projectVO.setImageUrl(rs.getString("imageUrl"));
						projectVO.setAid(rs.getInt("aid"));
						projectVO.setTid(rs.getInt("tid"));
						projectVO.setTemplatename(rs.getString("templatename"));
						projectVO.setNickname(rs.getString("nickname"));
						projectVO.setZcloudID(rs.getString("zcloudID"));
						projectVO.setZcloudKEY(rs.getString("zcloudKEY"));
						projectVO.setServerAddr(rs.getString("serverAddr"));
						projectVO.setMacList(rs.getString("macList"));
						projectVO.setCreateTime(rs.getDate("createTime"));
						projectVO.setModifyTime(rs.getDate("modifyTime"));
						projectVO.setVisible(rs.getInt("visible"));
						return projectVO;
					}
		});	
		//查询记录
		queryResult.setResultlist(projectList);
		int count = getJdbcTemplate().queryForObject(countSql.toString(), countParmas.toArray(), Integer.class);
		//查询总记录数
		queryResult.setTotalrecord(count);
		return queryResult;
	}

	@Override
	public int enable(int id, int visible) {
		// TODO Auto-generated method stub
		return getJdbcTemplate().update("update tb_project set visible=? where id=?",new Object[] {visible,id});	
	}

	@Override
	public QueryResult<ProjectVO> findByAdminIdAndTemplate(String nickname, String templatename, String name,int visible, int firstindex, int maxresult) {
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
		QueryResult<ProjectVO> queryResult = new QueryResult<ProjectVO>();
		StringBuffer sql  = new StringBuffer("select t1.*,t2.name as templatename,nickname from tb_project t1 inner join tb_template t2 on t1.tid=t2.id inner join tb_admin t3 on t1.aid=t3.id where 1=1");
		StringBuffer countSql = new StringBuffer("select count(*) from tb_project t1 inner join tb_template t2 on t1.tid=t2.id inner join tb_admin t3 on t1.aid=t3.id where 1=1");
		List<Object> parmas = Lists.newArrayList();
		List<Object> countParmas = Lists.newArrayList();
		if(nickname != null && !nickname.equals("")){//nickname==null表示所有存在的管理员
			sql.append(" and t3.nickname=?");
			parmas.add(nickname);
			countSql.append(" and t3.nickname=?");
			countParmas.add(nickname);
		}else{
			sql.append(" and t3.visible=1");
			countSql.append(" and t3.visible=1");
		}
		if(templatename != null && !templatename.equals("")){//templatename==null表示所有存在模板的ID
			sql.append(" and t2.name=?");
			parmas.add(templatename);
			countSql.append(" and t2.name=?");
			countParmas.add(templatename);
		}else{
			sql.append(" and t2.visible=1");
			countSql.append(" and t2.visible=1");
		}
		if(name != null && !name.equals("")){//templatename==null表示所有存在模板的ID
			sql.append(" and t1.name=?");
			parmas.add(name);
			countSql.append(" and t1.name=?");
			countParmas.add(name);
		}
		if(visible != -1){//visibel=-1包括删除、未删除模板
			sql.append(" and t1.visible=?");
			parmas.add(visible);
			countSql.append(" and t1.visible=?");
			countParmas.add(visible);
		}
		sql.append(" and t1.id limit ?,?");
		parmas.add(firstindex);
		parmas.add(maxresult);
		List<ProjectVO> projectList = getJdbcTemplate().query(sql.toString(), parmas.toArray(),
				new RowMapper<ProjectVO>(){
					@Override
					public ProjectVO mapRow(ResultSet rs, int rowNum) throws SQLException {
						// TODO Auto-generated method stub
						ProjectVO projectVO = new ProjectVO();
						projectVO.setId(rs.getInt("id"));
						projectVO.setName(rs.getString("name"));
						projectVO.setImageUrl(rs.getString("imageUrl"));
						projectVO.setAid(rs.getInt("aid"));
						projectVO.setTid(rs.getInt("tid"));
						projectVO.setTemplatename(rs.getString("templatename"));
						projectVO.setNickname(rs.getString("nickname"));
						projectVO.setZcloudID(rs.getString("zcloudID"));
						projectVO.setZcloudKEY(rs.getString("zcloudKEY"));
						projectVO.setServerAddr(rs.getString("serverAddr"));
						projectVO.setMacList(rs.getString("macList"));
						projectVO.setCreateTime(rs.getDate("createTime"));
						projectVO.setModifyTime(rs.getDate("modifyTime"));
						projectVO.setVisible(rs.getInt("visible"));
						return projectVO;
					}
		});	
		//查询记录
		queryResult.setResultlist(projectList);
		int count = getJdbcTemplate().queryForObject(countSql.toString(), countParmas.toArray(), Integer.class);
		//查询总记录数
		queryResult.setTotalrecord(count);
		return queryResult;
	}
	
	public static void main(String[] args) {
		int[] ids = {1,1,1,1,1};
		StringBuffer sql = new StringBuffer("delete from tb_project where id in (");
		for(int i=0;i<ids.length;i++){
			sql.append("?,");
		}
		sql.delete(sql.length()-1, sql.length()).append(")");
		System.out.println(sql.toString());
	}

}
