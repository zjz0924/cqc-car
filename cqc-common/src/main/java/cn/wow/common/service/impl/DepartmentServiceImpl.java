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
import cn.wow.common.dao.DepartmentDao;
import cn.wow.common.domain.Department;
import cn.wow.common.service.DepartmentService;

@Service
@Transactional
public class DepartmentServiceImpl implements DepartmentService {

	private static Logger logger = LoggerFactory.getLogger(DepartmentServiceImpl.class);

	@Autowired
	private DepartmentDao departmentDao;

	public Department selectOne(Long id) {
		return departmentDao.selectOne(id);
	}

	public int save(String userName, Department applicat) {
		return departmentDao.insert(applicat);
	}

	public int update(String userName, Department applicat) {
		return departmentDao.update(applicat);
	}

	public int deleteByPrimaryKey(String userName, Department applicat) {
		return departmentDao.deleteByPrimaryKey(applicat.getId());
	}

	public List<Department> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return departmentDao.selectAllList(map);
	}

	public Department selectByName(String name) {
		return departmentDao.selectByName(name);
	}
}
