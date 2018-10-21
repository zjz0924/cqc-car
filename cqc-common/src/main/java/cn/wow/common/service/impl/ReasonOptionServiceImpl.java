package cn.wow.common.service.impl;

import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.wow.common.dao.ReasonOptionDao;
import cn.wow.common.domain.ReasonOption;
import cn.wow.common.service.ReasonOptionService;
import cn.wow.common.utils.pagination.PageHelperExt;

@Service
@Transactional
public class ReasonOptionServiceImpl implements ReasonOptionService {

	private static Logger logger = LoggerFactory.getLogger(ReasonOptionServiceImpl.class);

	@Autowired
	private ReasonOptionDao reasonOptionDao;

	public ReasonOption selectOne(Long id) {
		return reasonOptionDao.selectOne(id);
	}

	public int save(String userName, ReasonOption ReasonOption) {
		return reasonOptionDao.insert(ReasonOption);
	}

	public int update(String userName, ReasonOption ReasonOption) {
		return reasonOptionDao.update(ReasonOption);
	}

	public int deleteByPrimaryKey(String userName, ReasonOption ReasonOption) {
		return reasonOptionDao.deleteByPrimaryKey(ReasonOption.getId());
	}

	public List<ReasonOption> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return reasonOptionDao.selectAllList(map);
	}

	public ReasonOption selectByName(Map<String, Object> map) {
		return reasonOptionDao.selectByName(map);
	}
}
