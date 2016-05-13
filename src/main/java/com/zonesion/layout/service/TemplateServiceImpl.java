package com.zonesion.layout.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zonesion.layout.dao.TemplateDao;
import com.zonesion.layout.model.TemplateEntity;
import com.zonesion.layout.model.TemplateVO;
import com.zonesion.layout.page.QueryResult;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月21日 下午3:27:47  
 * @version V1.0    
 */
@Service("templateService")
public class TemplateServiceImpl implements TemplateService {

	@Resource
	private TemplateDao templateDao;
	
	@Override
	public List<TemplateEntity> findAll() {
		// TODO Auto-generated method stub
		return templateDao.findAll();
	}

	@Override
	public TemplateEntity findByTemplateId(int tid) {
		// TODO Auto-generated method stub
		return templateDao.findByTemplateId(tid);
	}

	@Override
	public List<TemplateEntity> findByAdminId(int aid) {
		// TODO Auto-generated method stub
		return templateDao.findByAdminId(aid);
	}

	@Override
	public List<TemplateEntity> findByAdminAndType(int aid, int type) {
		// TODO Auto-generated method stub
		return templateDao.findByAdminAndType(aid, type);
	}

	@Override
	public int save(TemplateEntity templateEntity) {
		// TODO Auto-generated method stub
		return templateDao.save(templateEntity);
	}

	@Override
	public int delete(int id) {
		// TODO Auto-generated method stub
		return templateDao.delete(id);
	}
	
	@Override
	public int enable(int id,int visible) {
		// TODO Auto-generated method stub
		return templateDao.enable(id,visible);
	}

	@Override
	public int update(TemplateEntity templateEntity) {
		// TODO Auto-generated method stub
		return templateDao.update(templateEntity);
	}

	@Override
	public QueryResult<TemplateEntity> findAll(int firstindex, int maxresult) {
		// TODO Auto-generated method stub
		return templateDao.findAll(firstindex, maxresult);
	}

	@Override
	public QueryResult<TemplateEntity> findByAdminId(int aid, int firstindex, int maxresult) {
		// TODO Auto-generated method stub
		return templateDao.findByAdminId(aid, firstindex, maxresult);
	}

	@Override
	public QueryResult<TemplateEntity> findByAdminAndType(int aid, int type, int firstindex, int maxresult) {
		// TODO Auto-generated method stub
		return templateDao.findByAdminAndType(aid, type, firstindex, maxresult);
	}

	@Override
	public QueryResult<TemplateVO> findByAdminAndType(int aid, int type, int visible, int firstindex, int maxresult) {
		// TODO Auto-generated method stub
		return templateDao.findByAdminAndType(aid, type, visible, firstindex, maxresult);
	}

	@Override
	public QueryResult<TemplateVO> findByAdminAndType(String nickname, String templatename, int type, int visible, int firstindex, int maxresult) {
		// TODO Auto-generated method stub
		return templateDao.findByAdminAndType(nickname, templatename, type, visible, firstindex, maxresult);
	}

}
