package cn.wow.common.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.wow.common.dao.ReasonDao;
import cn.wow.common.domain.Applicat;
import cn.wow.common.domain.Reason;
import cn.wow.common.service.ReasonService;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.utils.pagination.PageMap;

@Service
@Transactional
public class ReasonServiceImpl implements ReasonService {

	private static Logger logger = LoggerFactory.getLogger(ReasonServiceImpl.class);

	@Autowired
	private ReasonDao reasonDao;

	public Reason selectOne(Long id) {
		return reasonDao.selectOne(id);
	}

	public int save(String userName, Reason Reason) {
		return reasonDao.insert(Reason);
	}

	public int update(String userName, Reason Reason) {
		return reasonDao.update(Reason);
	}

	public int deleteByPrimaryKey(String userName, Reason Reason) {
		return reasonDao.deleteByPrimaryKey(Reason.getId());
	}

	public List<Reason> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return reasonDao.selectAllList(map);
	}

	public List<Long> selectIds(String origin, String source, String reason) {
		List<Long> idList = new ArrayList<Long>();

		Map<String, Object> map = new PageMap(false);
		if (StringUtils.isNotBlank(origin)) {
			map.put("origin", origin);
		}

		if (StringUtils.isNotBlank(source)) {
			map.put("source", source);
		}

		if (StringUtils.isNotBlank(reason)) {
			map.put("reason", reason);
		}

		if (map.size() > 3) {
			List<Reason> dataList = this.selectAllList(map);
			if (dataList != null && dataList.size() > 0) {
				for (Reason obj : dataList) {
					idList.add(obj.getId());
				}
			} else {
				idList.add(-1l);
			}
		}
		
		return idList;
	}
}
