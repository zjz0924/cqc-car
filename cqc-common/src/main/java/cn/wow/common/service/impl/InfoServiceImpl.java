package cn.wow.common.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.wow.common.dao.InfoDao;
import cn.wow.common.dao.MaterialDao;
import cn.wow.common.dao.PartsDao;
import cn.wow.common.dao.TaskDao;
import cn.wow.common.dao.TaskRecordDao;
import cn.wow.common.dao.VehicleDao;
import cn.wow.common.domain.Account;
import cn.wow.common.domain.Info;
import cn.wow.common.domain.Material;
import cn.wow.common.domain.Parts;
import cn.wow.common.domain.Task;
import cn.wow.common.domain.TaskRecord;
import cn.wow.common.domain.Vehicle;
import cn.wow.common.service.InfoService;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.utils.taskState.StandardTaskEnum;
import cn.wow.common.utils.taskState.StandardTaskRecordEnum;
import cn.wow.common.utils.taskState.TaskTypeEnum;

@Service
@Transactional
public class InfoServiceImpl implements InfoService {

	private static Logger logger = LoggerFactory.getLogger(InfoServiceImpl.class);

	@Autowired
	private InfoDao infoDao;
	@Autowired
	private VehicleDao vehicleDao;
	@Autowired
	private PartsDao partsDao;
	@Autowired
	private MaterialDao materialDao;
	@Autowired
	private TaskDao taskDao;
	@Autowired
	private TaskRecordDao taskRecordDao;

	public Info selectOne(Long id) {
		return infoDao.selectOne(id);
	}

	public int save(String userName, Info info) {
		return infoDao.insert(info);
	}

	public int update(String userName, Info info) {
		return infoDao.update(info);
	}
	
	public void updateState(Long id, Integer state){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("state", state);
		
		taskDao.updateState(map);
	}

	public int deleteByPrimaryKey(String userName, Info info) {
		return infoDao.deleteByPrimaryKey(info.getId());
	}

	public List<Info> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return infoDao.selectAllList(map);
	}

	/**
	 * 添加信息
	 */
	public int insert(Account account, Vehicle vehicle, Parts parts, Material material, int type) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		Date date = vehicle.getCreateTime();
		String taskCode = sdf.format(date);
		
		vehicleDao.insert(vehicle);
		partsDao.insert(parts);
		materialDao.insert(material);

		// 信息
		Info info = new Info();
		info.setCreateTime(date);
		info.setmId(material.getId());
		info.setpId(parts.getId());
		info.setState(Contants.ONDOING_TYPE);
		info.setvId(vehicle.getId());
		info.setType(type);

		// 任务
		Task task = new Task();
		task.setCode(taskCode);
		task.setCreateTime(date);
		task.setiId(account.getId());
		task.setOrgId(account.getOrgId());
		task.setState(StandardTaskEnum.EXAMINE.getState());
		task.setType(TaskTypeEnum.OTS.getState());
		task.setFailNum(0);
		task.setaId(account.getId());
		taskDao.insert(task);

		// 操作记录
		TaskRecord record = new TaskRecord();
		record.setCreateTime(date);
		record.setCode(taskCode);
		record.setState(StandardTaskRecordEnum.ENTERING.getState());
		record.setaId(account.getId());
		taskRecordDao.insert(record);

		return infoDao.insert(info);
	}

	
	/**
	 * 审核
	 */
	public void examine(Account account, Long id, int type, String remark) {
		Task task = taskDao.selectOne(id);
		// 操作记录
		TaskRecord record = new TaskRecord();
		record.setCreateTime(new Date());
		record.setCode(task.getCode());
		record.setaId(account.getId());

		if (type == 1) {
			// 更新任务状态
			this.updateState(task.getId(), StandardTaskEnum.TRANSMIT.getState());
			record.setState(StandardTaskRecordEnum.EXAMINE_PASS.getState());
		} else {
			// 审核不通过
			this.updateState(task.getId(), StandardTaskEnum.EXAMINE_NOTPASS.getState());
			record.setState(StandardTaskRecordEnum.EXAMINE_NOTPASS.getState());
			record.setRemark(remark);
		}
		taskRecordDao.insert(record);
	}
}
