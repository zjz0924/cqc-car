package cn.wow.common.service.impl;

import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.dao.AttachDao;
import cn.wow.common.domain.Attach;
import cn.wow.common.service.AttachService;

@Service
@Transactional
public class AttachServiceImpl implements AttachService {

	private static Logger logger = LoggerFactory.getLogger(AttachServiceImpl.class);

	@Autowired
	private AttachDao attachDao;

	public Attach selectOne(Long id) {
		return attachDao.selectOne(id);
	}

	public int save(String userName, Attach attach) {
		return attachDao.insert(attach);
	}

	public int update(String userName, Attach attach) {
		return attachDao.update(attach);
	}

	public int deleteByPrimaryKey(String userName, Attach attach) {
		return attachDao.deleteByPrimaryKey(attach.getId());
	}

	public List<Attach> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return attachDao.selectAllList(map);
	}

	public Attach getFileName(Long taskId) {
		Attach attach = attachDao.selectOne(taskId);

		if (attach != null) {
			attach.setFileName();
		}
		return attach;
	}
}
