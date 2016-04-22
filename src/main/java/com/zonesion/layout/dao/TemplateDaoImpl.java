package com.zonesion.layout.dao;

import java.util.List;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

import com.zonesion.layout.model.TemplateEntity;
import com.zonesion.layout.page.QueryResult;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月21日 上午11:48:55  
 * @version V1.0    
 */
public class TemplateDaoImpl extends JdbcDaoSupport implements TemplateDao {

	@Override
	public List<TemplateEntity> findAll() {
		// TODO Auto-generated method stub
		return getJdbcTemplate().query("select * from tb_template", new Object[] {}, 
				new BeanPropertyRowMapper<TemplateEntity>(TemplateEntity.class));
	}

	@Override
	public TemplateEntity findByTemplateId(int tid) {
		// TODO Auto-generated method stub
		return getJdbcTemplate().queryForObject("select * from tb_template where id=?", new Object[]{tid},
				new BeanPropertyRowMapper<TemplateEntity>(TemplateEntity.class));
	}

	@Override
	public List<TemplateEntity> findByAdminId(int aid) {
		// TODO Auto-generated method stub
		return getJdbcTemplate().query("select * from tb_template where aid=?", new Object[] {aid}, 
				new BeanPropertyRowMapper<TemplateEntity>(TemplateEntity.class));
	}

	@Override
	public List<TemplateEntity> findByAdminAndType(int aid, int type) {
		// TODO Auto-generated method stub
		return getJdbcTemplate().query("select * from tb_template where aid=? and type=?", new Object[] {aid,type}, 
				new BeanPropertyRowMapper<TemplateEntity>(TemplateEntity.class));
	}

	@Override
	public int save(TemplateEntity templateEntity) {
		// TODO Auto-generated method stub
		return getJdbcTemplate().update("insert into tb_template(name, layoutJSON, layoutContent, aid, type, createTime, modifyTime) values(?,?,?,?,?,?,?)", 
				new Object[] {templateEntity.getName(),templateEntity.getLayoutJSON(),templateEntity.getLayoutContent(),
				templateEntity.getAid(),templateEntity.getType(),templateEntity.getCreateTime(),templateEntity.getModifyTime()});
	}

	@Override
	public int delete(int id) {
		// TODO Auto-generated method stub
		return getJdbcTemplate().update("update tb_template set visible=0 where id=?",new Object[]{id});
	}

	@Override
	public int update(TemplateEntity templateEntity) {
		// TODO Auto-generated method stub
		return getJdbcTemplate().update("update tb_template set name=?, layoutJSON=?, layoutContent=?, aid=?, type=?, createTime=?, modifyTime=? where id=?", 
				new Object[] {templateEntity.getName(),templateEntity.getLayoutJSON(),templateEntity.getLayoutContent(),
				templateEntity.getAid(),templateEntity.getType(),templateEntity.getCreateTime(),templateEntity.getModifyTime(),templateEntity.getId()});
	}

	@Override
	public QueryResult<TemplateEntity> findAll(int firstindex, int maxresult) {
		// TODO Auto-generated method stub
		QueryResult<TemplateEntity> queryResult = new QueryResult<TemplateEntity>();
		List<TemplateEntity> templateList = getJdbcTemplate().query("select * from tb_template where id limit ?,?", new Object[] {firstindex,maxresult}, 
				new BeanPropertyRowMapper<TemplateEntity>(TemplateEntity.class));
		queryResult.setResultlist(templateList);
		int count = getJdbcTemplate().queryForObject("select count(*) from tb_template", Integer.class);
		queryResult.setTotalrecord(count);
		return queryResult;
	}

	@Override
	public QueryResult<TemplateEntity> findByAdminId(int aid, int firstindex, int maxresult) {
		// TODO Auto-generated method stub
		QueryResult<TemplateEntity> queryResult = new QueryResult<TemplateEntity>();
		List<TemplateEntity> templateList = getJdbcTemplate().query("select * from tb_template where aid=? and id limit ?,?", new Object[] {aid,firstindex,maxresult}, 
				new BeanPropertyRowMapper<TemplateEntity>(TemplateEntity.class));
		queryResult.setResultlist(templateList);
		int count = getJdbcTemplate().queryForObject("select count(*) from tb_template where aid=?",new Object[]{aid}, Integer.class);
		queryResult.setTotalrecord(count);
		return queryResult;
	}

	@Override
	public QueryResult<TemplateEntity> findByAdminAndType(int aid, int type, int firstindex, int maxresult) {
		// TODO Auto-generated method stub
		QueryResult<TemplateEntity> queryResult = new QueryResult<TemplateEntity>();
		List<TemplateEntity> templateList = getJdbcTemplate().query("select * from tb_template where aid=? and type=? and id limit ?,?", new Object[] {aid,type,firstindex,maxresult}, 
				new BeanPropertyRowMapper<TemplateEntity>(TemplateEntity.class));
		queryResult.setResultlist(templateList);
		int count = getJdbcTemplate().queryForObject("select count(*) from tb_template where aid=? and type=?",new Object[]{aid,type}, Integer.class);
		queryResult.setTotalrecord(count);
		return queryResult;
	}

}
