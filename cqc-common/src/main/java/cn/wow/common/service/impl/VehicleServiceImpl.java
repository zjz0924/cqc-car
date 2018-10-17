package cn.wow.common.service.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.wow.common.dao.VehicleDao;
import cn.wow.common.domain.Vehicle;
import cn.wow.common.service.VehicleService;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.vo.ResultFlagVO;

@Service
@Transactional
public class VehicleServiceImpl implements VehicleService {

	private static Logger logger = LoggerFactory.getLogger(VehicleServiceImpl.class);

	@Autowired
	private VehicleDao vehicleDao;

	public Vehicle selectOne(Long id) {
		return vehicleDao.selectOne(id);
	}

	public Vehicle selectByCode(String code) {
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

	/**
	 * 检查整车信息是否存在
	 */
	public ResultFlagVO isExist(Long id, String code, Date proTime, String proAddr) {
		ResultFlagVO vo = new ResultFlagVO();

		Map<String, Object> map = new PageMap(false);
		if (id != null) {
			map.put("eid", id);
		}
		map.put("ecode", code);
		map.put("eProTime", proTime);
		map.put("proAddr", proAddr);

		List<Vehicle> dataList = vehicleDao.selectAllList(map);
		if (dataList != null && dataList.size() > 0) {
			vo.setFlag(true);
			vo.setState(dataList.get(0).getState());
		} else {
			vo.setFlag(false);
		}
		return vo;
	}

	
	/**
	 * 是否更新整车信息
	 */
	public boolean isUpdateVehicleInfo(Vehicle vehicle, String v_code, String v_proTime, String v_proAddr, String v_remark) {
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		if (v_code.equals(vehicle.getCode())
				&& ((StringUtils.isNotBlank(v_proTime) && vehicle.getProTime() != null
						&& v_proTime.equals(sdf.format(vehicle.getProTime())))
						|| (StringUtils.isBlank(v_proTime) && vehicle.getProTime() == null))
				&& v_proAddr.equals(v_proAddr) && v_remark.equals(vehicle.getRemark())) {
			return false;
		} else {
			return true;
		}
	}
}
