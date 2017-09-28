package cn.wow.common.service.impl;

import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.dao.VehicleDao;
import cn.wow.common.domain.Vehicle;
import cn.wow.common.service.VehicleService;

@Service
@Transactional
public class VehicleServiceImpl implements VehicleService {

	private static Logger logger = LoggerFactory.getLogger(VehicleServiceImpl.class);

	@Autowired
	private VehicleDao vehicleDao;

	public Vehicle selectOne(Long id) {
		return vehicleDao.selectOne(id);
	}
	
	public Vehicle selectByCode(String code){
		return vehicleDao.selectByCode(code);
	}

	public int save(String userName, Vehicle vehicle) {
		return vehicleDao.insert(vehicle);
	}

	public int update(String userName, Vehicle vehicle) {
		return vehicleDao.update(vehicle);
	}

	public int deleteByPrimaryKey(String userName, Vehicle vehicle) {
		return vehicleDao.deleteByPrimaryKey(vehicle.getId());
	}

	public List<Vehicle> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return vehicleDao.selectAllList(map);
	}

}
