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
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.dao.ApplicatDao;
import cn.wow.common.domain.Applicat;
import cn.wow.common.service.ApplicatService;

@Service
@Transactional
public class ApplicatServiceImpl implements ApplicatService {

	private static Logger logger = LoggerFactory.getLogger(ApplicatServiceImpl.class);

	@Autowired
	private ApplicatDao applicatDao;

	public Applicat selectOne(Long id) {
		return applicatDao.selectOne(id);
	}

	public int save(String userName, Applicat applicat) {
		return applicatDao.insert(applicat);
	}

	public int update(String userName, Applicat applicat) {
		return applicatDao.update(applicat);
	}

	public int deleteByPrimaryKey(String userName, Applicat applicat) {
		return applicatDao.deleteByPrimaryKey(applicat.getId());
	}

	public List<Applicat> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return applicatDao.selectAllList(map);
	}

	// 获取申请人ID
	public List<Long> selectIds(String applicat_name, String applicat_depart, Integer applicat_org) {
		List<Long> idList = new ArrayList<Long>();

		Map<String, Object> map = new PageMap(false);
		if (StringUtils.isNotBlank(applicat_name)) {
			map.put("qname", applicat_name);
		}

		if (StringUtils.isNotBlank(applicat_depart)) {
			map.put("qdepart", applicat_depart);
		}

		if (applicat_org != null) {
			map.put("orgId", applicat_org);
		}

		if (map.size() > 3) {
			List<Applicat> dataList = this.selectAllList(map);
			if (dataList != null && dataList.size() > 0) {
				for (Applicat app : dataList) {
					idList.add(app.getId());
				}
			} else {
				idList.add(-1l);
			}
		}
		return idList;
	}

}
