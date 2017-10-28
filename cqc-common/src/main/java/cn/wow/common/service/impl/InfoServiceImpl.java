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

import cn.wow.common.dao.ExamineRecordDao;
import cn.wow.common.dao.InfoDao;
import cn.wow.common.dao.MaterialDao;
import cn.wow.common.dao.PartsDao;
import cn.wow.common.dao.TaskDao;
import cn.wow.common.dao.TaskRecordDao;
import cn.wow.common.dao.VehicleDao;
import cn.wow.common.domain.Account;
import cn.wow.common.domain.ExamineRecord;
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
	@Autowired
	private ExamineRecordDao examineRecordDao;

	public Info selectOne(Long id) {
		return infoDao.selectOne(id);
	}

	public int save(String userName, Info info) {
		return infoDao.insert(info);
	}

	public int update(String userName, Info info) {
		return infoDao.update(info);
	}

	public void updateState(Long id, Integer state) {
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
	public void insert(Account account, Vehicle vehicle, Parts parts, Material material, int type, Long taskId) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		Date date = material.getCreateTime();
		String taskCode = sdf.format(date);

		if (vehicle.getId() == null) {
			vehicleDao.insert(vehicle);
		} else {
			if (vehicle.getState() == Contants.ONDOING_TYPE) {
				vehicleDao.update(vehicle);
			}
		}

		if (parts.getId() == null) {
			partsDao.insert(parts);
		} else {
			if (parts.getState() == Contants.ONDOING_TYPE) {
				partsDao.update(parts);
			}
		}
		
		if(material.getId() == null){
			materialDao.insert(material);
		}else{
			materialDao.update(material);
		}

		if(taskId == null){
			// 信息
			Info info = new Info();
			info.setCreateTime(date);
			info.setmId(material.getId());
			info.setpId(parts.getId());
			info.setState(Contants.ONDOING_TYPE);
			info.setvId(vehicle.getId());
			info.setType(type);
			infoDao.insert(info);

			// 任务
			Task task = new Task();
			task.setCode(taskCode);
			task.setCreateTime(date);
			task.setiId(info.getId());
			task.setOrgId(account.getOrgId());
			task.setState(StandardTaskEnum.EXAMINE.getState());
			task.setType(TaskTypeEnum.OTS.getState());
			task.setFailNum(0);
			task.setaId(account.getId());
			task.setMatAtlResult(0);
			task.setMatPatResult(0);
			task.setPartsAtlResult(0);
			task.setPartsPatResult(0);
			taskDao.insert(task);

			// 操作记录
			TaskRecord record = new TaskRecord();
			record.setCreateTime(date);
			record.setCode(taskCode);
			record.setState(StandardTaskRecordEnum.ENTERING.getState());
			record.setaId(account.getId());
			record.setRemark("填写信息");
			taskRecordDao.insert(record);
		}else{
			Task task = taskDao.selectOne(taskId);
			if(task.getState() == StandardTaskEnum.EXAMINE_NOTPASS.getState()){
				// 更新任务状态
				this.updateState(task.getId(), StandardTaskEnum.EXAMINE.getState());
			}
			
			// 操作记录
			TaskRecord record = new TaskRecord();
			record.setCreateTime(date);
			record.setCode(taskCode);
			record.setState(StandardTaskRecordEnum.UPDATE.getState());
			record.setaId(account.getId());
			record.setRemark("更新信息");
			taskRecordDao.insert(record);
		}
		
	}

	/**
     * 审核
     * @param account  操作用户
     * @param id       任务ID
     * @param type     结果：1-通过，2-不通过
     * @param remark   备注
     */
	public void examine(Account account, Long id, int type, String remark) {
		Task task = taskDao.selectOne(id);
		Date date = new Date();
		
		// 操作记录
		TaskRecord record = new TaskRecord();
		record.setCreateTime(date);
		record.setCode(task.getCode());
		record.setaId(account.getId());
		taskRecordDao.insert(record);

		// 审核记录
		ExamineRecord examineRecord = new ExamineRecord();
		examineRecord.setaId(account.getId());
		examineRecord.setCreateTime(date);
		examineRecord.setRemark(remark);
		examineRecord.setState(type);
		examineRecord.settId(id);
		examineRecordDao.insert(examineRecord);
		
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
	}

	/**
     * 下达任务
     * @param account   操作用户
     * @param id        任务ID
     * @param partsAtlId   零部件图谱实验室ID
	 * @param matAtlId     原材料图谱实验室ID
	 * @param partsPatId   零部件型式实验室ID
	 * @param matPatId     原材料型式实验室ID
     */
	public void transmit(Account account, Long id, Long partsAtlId, Long matAtlId, Long partsPatId, Long matPatId) {
		Task task = taskDao.selectOne(id);
		task.setPartsAtlId(partsAtlId);
		task.setMatAtlId(matAtlId);
		task.setPartsPatId(partsPatId);
		task.setMatPatId(matPatId);
		task.setState(StandardTaskEnum.APPROVE.getState());
		taskDao.update(task);

		// 操作记录
		TaskRecord record = new TaskRecord();
		record.setCreateTime(new Date());
		record.setCode(task.getCode());
		record.setaId(account.getId());
		record.setState(StandardTaskRecordEnum.TRANSMIT.getState());
		taskRecordDao.insert(record);
	}

	/**
	 * 审批
	 */
	public void approve(Account account, Long id, int type, String remark) {
		Task task = taskDao.selectOne(id);
		// 操作记录
		TaskRecord record = new TaskRecord();
		record.setCreateTime(new Date());
		record.setCode(task.getCode());
		record.setaId(account.getId());

		if (type == 1) {
			// 更新任务状态
			this.updateState(task.getId(), StandardTaskEnum.UPLOADING.getState());
			record.setState(StandardTaskRecordEnum.APPROVE_AGREE.getState());
		} else {
			// 审批不通过
			this.updateState(task.getId(), StandardTaskEnum.TRANSMIT.getState());
			record.setState(StandardTaskRecordEnum.APPROVE_DISAGREE.getState());
			record.setRemark(remark);
		}
		taskRecordDao.insert(record);
	}
}
