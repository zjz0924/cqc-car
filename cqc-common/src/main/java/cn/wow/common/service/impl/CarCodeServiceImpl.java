package cn.wow.common.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.wow.common.dao.CarCodeDao;
import cn.wow.common.domain.CarCode;
import cn.wow.common.service.CarCodeService;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.utils.pagination.PageMap;

@Service
@Transactional
public class CarCodeServiceImpl implements CarCodeService {

	private static Logger logger = LoggerFactory.getLogger(CarCodeServiceImpl.class);

	@Autowired
	private CarCodeDao carCodeDao;

	public CarCode selectOne(Long id) {
		return carCodeDao.selectOne(id);
	}

	public int save(String userName, CarCode CarCode) {
		return carCodeDao.insert(CarCode);
	}

	public int update(String userName, CarCode CarCode) {
		return carCodeDao.update(CarCode);
	}

	public int deleteByPrimaryKey(String userName, CarCode CarCode) {
		return carCodeDao.deleteByPrimaryKey(CarCode.getId());
	}

	public List<CarCode> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return carCodeDao.selectAllList(map);
	}

	public CarCode selectByCode(String code) {
		return carCodeDao.selectByCode(code);
	}

	
	/**
	 * 获取 车型代码列表
	 */
	public List<CarCode> getCarCodeList() {
		Map<String, Object> carCodeMap = new PageMap(false);
		carCodeMap.put("custom_order_sql", "code asc");
		List<CarCode> carCodeList = carCodeDao.selectAllList(carCodeMap);

		return carCodeList;
	}
}
