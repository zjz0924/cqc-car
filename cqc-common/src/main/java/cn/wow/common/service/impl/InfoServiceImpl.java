package cn.wow.common.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.wow.common.dao.ApplyRecordDao;
import cn.wow.common.dao.AtlasResultDao;
import cn.wow.common.dao.ExamineRecordDao;
import cn.wow.common.dao.InfoDao;
import cn.wow.common.dao.MaterialDao;
import cn.wow.common.dao.PartsDao;
import cn.wow.common.dao.PfResultDao;
import cn.wow.common.dao.TaskDao;
import cn.wow.common.dao.TaskRecordDao;
import cn.wow.common.dao.VehicleDao;
import cn.wow.common.domain.Account;
import cn.wow.common.domain.ApplyRecord;
import cn.wow.common.domain.AtlasResult;
import cn.wow.common.domain.ExamineRecord;
import cn.wow.common.domain.Info;
import cn.wow.common.domain.Material;
import cn.wow.common.domain.Parts;
import cn.wow.common.domain.PfResult;
import cn.wow.common.domain.Task;
import cn.wow.common.domain.TaskRecord;
import cn.wow.common.domain.Vehicle;
import cn.wow.common.service.ApplyRecordService;
import cn.wow.common.service.InfoService;
import cn.wow.common.service.OperationLogService;
import cn.wow.common.service.TaskService;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.operationlog.OperationType;
import cn.wow.common.utils.operationlog.ServiceType;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.utils.taskState.SamplingTaskEnum;
import cn.wow.common.utils.taskState.SamplingTaskRecordEnum;
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
	@Autowired
	private ApplyRecordDao applyRecordDao;
	@Autowired
	private PfResultDao pfResultDao;
	@Autowired
	private AtlasResultDao atlasResultDao;
	@Autowired
	private ApplyRecordService applyRecordService;
	@Autowired
	private TaskService taskService;
	@Autowired
	private OperationLogService operationLogService;
	
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
	public void insert(Account account, Vehicle vehicle, Parts parts, Material material, int type, Long taskId, int taskType) {
		Date date = material.getCreateTime();
		String taskCode = generateTaskCode(date);

		if (vehicle.getId() == null) {
			vehicleDao.insert(vehicle);
		} else {
			if (vehicle.getState() == Contants.ONDOING_TYPE) {
				vehicleDao.update(vehicle);
			}
		}

		if (taskType == TaskTypeEnum.OTS.getState()) {
			if (parts.getId() == null) {
				partsDao.insert(parts);
			} else {
				if (parts.getState() == Contants.ONDOING_TYPE) {
					partsDao.update(parts);
				}
			}
		}
		
		if(material.getId() == null){
			materialDao.insert(material);
		}else{
			materialDao.update(material);
		}

		String logDetail = "";
		
		if(taskId == null){
			// 信息
			Info info = new Info();
			info.setCreateTime(date);
			info.setmId(material.getId());
			
			if (taskType == TaskTypeEnum.OTS.getState()) {
				info.setpId(parts.getId());
			}
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
			task.setType(taskType);
			task.setFailNum(0);
			task.setaId(account.getId());
			task.setMatAtlResult(0);
			task.setMatPatResult(0);
			task.setPartsAtlResult(0);
			task.setPartsPatResult(0);
			task.setPartsAtlTimes(0);
			task.setPartsPatTimes(0);
			task.setMatAtlTimes(0);
			task.setMatPatTimes(0);
			task.setInfoApply(0);
			task.setResultApply(0);
			taskDao.insert(task);

			// 操作记录
			TaskRecord record = new TaskRecord();
			record.setCreateTime(date);
			record.setCode(taskCode);
			record.setTaskType(taskType);
			record.setState(StandardTaskRecordEnum.ENTERING.getState());
			record.setaId(account.getId());
			record.setRemark("填写信息");
			taskRecordDao.insert(record);
			
			logDetail = "任务申请，任务号：" + task.getCode();
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
			record.setTaskType(taskType);
			record.setState(StandardTaskRecordEnum.UPDATE.getState());
			record.setaId(account.getId());
			record.setRemark("更新信息");
			taskRecordDao.insert(record);
			
			logDetail = "编辑任务，任务号：" + task.getCode();
		}
		
		addLog(account.getUserName(), OperationType.APPLY, ServiceType.TASK, logDetail);
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
		
		// 审核记录
		ExamineRecord examineRecord = new ExamineRecord();
		examineRecord.setaId(account.getId());
		examineRecord.setCreateTime(date);
		examineRecord.setRemark(remark);
		examineRecord.setState(type);
		examineRecord.settId(id);
		examineRecord.setType(1);
		examineRecord.setTaskType(task.getType());
		examineRecordDao.insert(examineRecord);
		
		// 操作记录
		TaskRecord record = new TaskRecord();
		record.setCreateTime(date);
		record.setCode(task.getCode());
		record.setaId(account.getId());
		record.setTaskType(task.getType());
		
		if (type == 1) {
			// 更新任务状态
			this.updateState(task.getId(), StandardTaskEnum.TESTING.getState());
			record.setState(StandardTaskRecordEnum.EXAMINE_PASS.getState());
			record.setRemark("信息审核通过");
		} else {
			// 审核不通过
			this.updateState(task.getId(), StandardTaskEnum.EXAMINE_NOTPASS.getState());
			record.setState(StandardTaskRecordEnum.EXAMINE_NOTPASS.getState());
			record.setRemark(remark);
		}
		taskRecordDao.insert(record);
		
		String str = type == 1 ? "通过" : "不通过";
		String logDetail = "任务：" + task.getCode() + "，审核" + str;
		addLog(account.getUserName(), OperationType.EXAMINE, ServiceType.TASK, logDetail);
	}

	/**
     * 下达任务（OTO任务）
     * @param account   操作用户
     * @param id        任务ID
     * @param partsAtlId   零部件图谱实验室ID
	 * @param matAtlId     原材料图谱实验室ID
	 * @param partsPatId   零部件型式实验室ID
	 * @param matPatId     原材料型式实验室ID
     */
	public void transmit(Account account, Long id, Long partsAtlId, Long matAtlId, Long partsPatId, Long matPatId) {
		Task task = taskDao.selectOne(id);
		
		if(partsAtlId != null){
			task.setPartsAtlId(partsAtlId);
			task.setPartsAtlResult(0);
		}
		if(matAtlId != null){
			task.setMatAtlId(matAtlId);
			task.setMatAtlResult(0);
		}
		if(partsPatId != null){
			task.setPartsPatId(partsPatId);
			task.setPartsPatResult(0);
		}
		if(matPatId != null){
			task.setMatPatId(matPatId);
			task.setMatPatResult(0);
		}
		taskDao.update(task);

		// 操作记录
		TaskRecord record = new TaskRecord();
		record.setCreateTime(new Date());
		record.setCode(task.getCode());
		record.setaId(account.getId());
		record.setTaskType(task.getType());
		record.setState(StandardTaskRecordEnum.TRANSMIT.getState());
		record.setRemark("分配任务到实验室");
		taskRecordDao.insert(record);
		
		String logDetail = "下达任务，任务号：" + task.getCode() ;
		addLog(account.getUserName(), OperationType.TRANSMIT, ServiceType.TASK, logDetail);
	}
	
	
   /**
	 * 下达任务（PPAP）
	 * 
	 * @param t_id         任务ID
	 * @param i_id         信息ID
	 * @param taskType     任务类型 
	 * @param partsAtlId   零部件图谱实验室ID
	 * @param matAtlId     原材料图谱实验室ID
	 * @param partsPatId   零部件型式实验室ID
	 * @param matPatId     原材料型式实验室ID
	 */
	public boolean transmit(Account account, Long t_id, Long i_id, Long partsAtlId, Long matAtlId, Long partsPatId, Long matPatId, int taskType) {
		String taskCode = "";
		
		if (t_id == null) {
			Date date = new Date();
			String code = generateTaskCode(date);

			// 检查当前基准是否已有任务在进行
			Map<String, Object> iMap = new PageMap(false);
			iMap.put("iId", i_id);
			iMap.put("type", taskType);
			iMap.put("unstate", true);
			List<Task> taskList = taskDao.selectAllList(iMap);
			if (taskList != null && taskList.size() > 0) {
				return false;
			}

			Task task = new Task();
			task.setCode(code);
			task.setCreateTime(date);
			task.setiId(i_id);
			task.setOrgId(account.getOrgId());
			task.setState(SamplingTaskEnum.APPROVE.getState());
			task.setType(taskType);
			task.setFailNum(0);
			task.setaId(account.getId());
			task.setMatAtlResult(0);
			task.setMatPatResult(0);
			task.setPartsAtlResult(0);
			task.setPartsPatResult(0);
			task.setPartsAtlId(partsAtlId);
			task.setPartsPatId(partsPatId);
			task.setMatAtlId(matAtlId);
			task.setMatPatId(matPatId);
			task.setPartsAtlTimes(0);
			task.setPartsPatTimes(0);
			task.setMatAtlTimes(0);
			task.setMatPatTimes(0);
			task.setInfoApply(0);
			task.setResultApply(0);
			taskDao.insert(task);

			// 操作记录
			TaskRecord record = new TaskRecord();
			record.setCreateTime(date);
			record.setCode(code);
			record.setTaskType(taskType);
			record.setState(SamplingTaskRecordEnum.TRANSMIT.getState());
			record.setaId(account.getId());
			record.setRemark("下达试验任务");
			taskRecordDao.insert(record);

			taskCode = task.getCode();
		} else {
			Task task = taskDao.selectOne(t_id);
			task.setiId(i_id);
			task.setPartsAtlId(partsAtlId);
			task.setMatAtlId(matAtlId);
			task.setState(SamplingTaskEnum.APPROVE.getState());
			taskDao.update(task);

			// 操作记录
			TaskRecord record = new TaskRecord();
			record.setCreateTime(new Date());
			record.setCode(task.getCode());
			record.setTaskType(taskType);
			record.setState(SamplingTaskRecordEnum.TRANSMIT.getState());
			record.setaId(account.getId());
			record.setRemark("下达试验任务");
			taskRecordDao.insert(record);
			
			taskCode = task.getCode();
		}

		String logDetail = "下达任务，任务号：" + taskCode ;
		addLog(account.getUserName(), OperationType.TRANSMIT, ServiceType.TASK, logDetail);
		
		return true;
	}
	    
	

	/**
     * 审批（OTS）
     * @param account  操作用户
     * @param id       任务ID
     * @param result   结果：1-通过，2-不通过
     * @param remark   备注
     * @param catagory 分类：1-零部件图谱，2-原材料图谱，3-零部件型式，4-原材料型式，，5-全部（试验），6-信息修改申请，7-试验结果修改申请
     */
	public void approve(Account account, Long id, int result, String remark, int catagory) {
		Task task = taskDao.selectOne(id);
		Date date = new Date();
		
		// 审批记录
		ExamineRecord examineRecord = new ExamineRecord(); 
		examineRecord.setaId(account.getId());
		examineRecord.setCatagory(catagory);
		examineRecord.setCreateTime(date);
		examineRecord.setRemark(remark);
		examineRecord.setState(result);
		examineRecord.settId(id);
		examineRecord.setType(2);
		examineRecord.setTaskType(task.getType());
		examineRecordDao.insert(examineRecord);
		
		if(catagory == 6){
			ApplyRecord applyRecord = applyRecordService.getRecordByTaskId(task.getId(), 1);
			
			if(applyRecord != null){
				if (result == 1) {
					Info info = task.getInfo();
					
					if (applyRecord.getpId() != null) {
						//先检查有没有在用
						if(!isUse(info.getId(), info.getpId(), 2)) {
							Parts oldParts = info.getParts();
							oldParts.setState(2);
							partsDao.update(oldParts);
						}
						
						Parts parts = partsDao.selectOne(applyRecord.getpId());
						parts.setState(1);
						partsDao.update(parts);
						
						info.setpId(applyRecord.getpId());
					}

					if (applyRecord.getvId() != null) {
						//先检查有没有在用
						if(!isUse(info.getId(), info.getvId(), 1)) {
							Vehicle oldVehicle = info.getVehicle();
							oldVehicle.setState(2);
							vehicleDao.update(oldVehicle);
						}
						
						Vehicle vehicle = vehicleDao.selectOne(applyRecord.getvId());
						vehicle.setState(1);
						vehicleDao.update(vehicle);
						
						info.setvId(applyRecord.getvId());
					}

					if (applyRecord.getmId() != null) {
						// 先检查有没有在用
						if (!isUse(info.getId(), info.getmId(), 3)) {
							Material oldMaterial = info.getMaterial();
							oldMaterial.setState(2);
							materialDao.update(oldMaterial);
						}
						
						Material material = materialDao.selectOne(applyRecord.getmId());
						material.setState(1);
						materialDao.update(material);
						
						info.setmId(applyRecord.getmId());
					}
					infoDao.update(info);
					
				} else {
					task.setRemark(remark);
					applyRecord.setRemark(remark);
				}
				
				applyRecord.setState(result);
				applyRecord.setConfirmTime(date);
				applyRecordDao.update(applyRecord);
				
				task.setState(StandardTaskEnum.ACCOMPLISH.getState());
				task.setInfoApply(0);
				taskDao.update(task);
				
				// 操作记录
				TaskRecord record = new TaskRecord();
				record.setCreateTime(date);
				record.setCode(task.getCode());
				record.setaId(account.getId());
				record.setTaskType(task.getType());
				record.setState(StandardTaskRecordEnum.INFO_UPDATE.getState());
				record.setRemark("修改基本信息");
				taskRecordDao.insert(record);
			}
		}else if(catagory == 7){
			
			ApplyRecord applyRecord = applyRecordService.getRecordByTaskId(task.getId(), 2);
			if (result == 1) {
				task.setState(StandardTaskEnum.ACCOMPLISH.getState());
			}else{
				task.setFailNum(1);
				task.setRemark(remark);
				task.setState(StandardTaskEnum.APPLY_NOTPASS.getState());
				applyRecord.setRemark(remark);
			}
			
			Info info = task.getInfo();
			info.setState(result);
			infoDao.update(info);

			applyRecord.setState(result);
			applyRecord.setConfirmTime(date);
			applyRecordDao.update(applyRecord);

			// 父任务
			Task pTask = taskDao.selectOne(task.gettId());
			pTask.setResultApply(0);
			pTask.setState(StandardTaskEnum.ACCOMPLISH.getState());
			taskDao.update(pTask);

			task.setResultApply(0);
			task.setConfirmTime(date);
			taskDao.update(task);
			
			// 操作记录
			TaskRecord record = new TaskRecord();
			record.setCreateTime(date);
			record.setCode(task.getCode());
			record.setaId(account.getId());
			record.setTaskType(task.getType());
			record.setState(StandardTaskRecordEnum.RESULT_UPDATE.getState());
			record.setRemark("修改试验结果信息");
			taskRecordDao.insert(record);
		}else{
			// 操作记录
			TaskRecord record = new TaskRecord();
			record.setCreateTime(date);
			record.setCode(task.getCode());
			record.setaId(account.getId());
			record.setTaskType(task.getType());

			// 同意
			if (result == 1) {
				if(catagory == 1){
					task.setPartsAtlResult(1);
					remark = "零部件图谱试验审批通过";
				}else if(catagory == 2){
					task.setMatAtlResult(1);
					remark = "原材料图谱试验审批通过";
				}else if(catagory == 3){
					task.setPartsPatResult(1);
					remark = "零部件型式试验审批通过";
				}else if(catagory == 4){
					task.setMatPatResult(1);
					remark = "原材料型式试验审批通过";
				}else{
					task.setMatAtlResult(1);
					task.setMatPatResult(1);
					
					if(task.getType() == TaskTypeEnum.OTS.getState()) {
						task.setPartsAtlResult(1);
						task.setPartsPatResult(1);
					}
					remark = "图谱和型式试验全部审批通过";
				}
				record.setState(StandardTaskRecordEnum.APPROVE_AGREE.getState());
			} else {
				
				if(catagory == 1){
					task.setPartsAtlResult(6);
					task.setPartsAtlId(null);
					remark = "零部件图谱试验审批不通过：" + remark;
				}else if(catagory == 2){
					task.setMatAtlResult(6);
					task.setMatAtlId(null);
					remark = "原材料图谱试验审批不通过：" + remark;
				}else if(catagory == 3){
					task.setPartsPatResult(6);
					task.setPartsPatId(null);
					remark = "零部件型式试验审批不通过：" + remark;
				}else if(catagory == 4){
					task.setMatPatResult(6);
					task.setMatPatId(null);
					remark = "原材料型式试验审批不通过：" + remark;
				}else{
					task.setMatAtlResult(6);
					task.setMatPatResult(6);
					task.setMatAtlId(null);
					task.setMatPatId(null);
					
					if(task.getType() == TaskTypeEnum.OTS.getState()) {
						task.setPartsAtlResult(6);
						task.setPartsPatResult(6);
						task.setPartsPatId(null);
						task.setPartsAtlId(null);
					}
					remark = "图谱和型式试验全部审批不通过：" + remark;
				}
				record.setState(StandardTaskRecordEnum.APPROVE_DISAGREE.getState());
			}
			
			record.setRemark(remark);
			taskRecordDao.insert(record);
			
			taskDao.update(task);
			
			String logDetail = "审批任务，任务号：" + task.getCode() + "，审批结果：" + remark;
			addLog(account.getUserName(), OperationType.APPROVE, ServiceType.TASK, logDetail);
		}
	}
	
	
	 /**
     * 审批（PPAP）
     * @param account  操作用户
     * @param id       任务ID
     * @param result   结果：1-通过，2-不通过
     * @param remark   备注
     * @param catagory 分类：1-信息修改申请，2-试验结果修改申请，3-正常流程
     */
    public void approve(Account account, Long id, int result, int catagory, String remark){
    	Task task = taskDao.selectOne(id);
    	Date date = new Date();
    	
		// 审批记录
		ExamineRecord examineRecord = new ExamineRecord(); 
		examineRecord.setaId(account.getId());
		examineRecord.setCreateTime(date);
		examineRecord.setRemark(remark);
		examineRecord.setState(result);
		examineRecord.settId(id);
		examineRecord.setType(2);
		examineRecord.setTaskType(task.getType());
		examineRecordDao.insert(examineRecord);
		
		if (catagory == 1) {
			ApplyRecord applyRecord = applyRecordService.getRecordByTaskId(task.getId(), 1);

			if (applyRecord != null) {
				if (result == 1) {
					Info info = task.getInfo();

					if (applyRecord.getpId() != null) {
						//先检查有没有在用
						if(!isUse(info.getId(), info.getpId(), 2)) {
							Parts oldParts = info.getParts();
							oldParts.setState(2);
							partsDao.update(oldParts);
						}

						Parts parts = partsDao.selectOne(applyRecord.getpId());
						parts.setState(1);
						partsDao.update(parts);

						info.setpId(applyRecord.getpId());
					}

					if (applyRecord.getvId() != null) {
						//先检查有没有在用
						if(!isUse(info.getId(), info.getvId(), 1)) {
							Vehicle oldVehicle = info.getVehicle();
							oldVehicle.setState(2);
							vehicleDao.update(oldVehicle);
						}

						Vehicle vehicle = vehicleDao.selectOne(applyRecord.getvId());
						vehicle.setState(1);
						vehicleDao.update(vehicle);

						info.setvId(applyRecord.getvId());
					}

					if (applyRecord.getmId() != null) {
						// 先检查有没有在用
						if (!isUse(info.getId(), info.getmId(), 3)) {
							Material oldMaterial = info.getMaterial();
							oldMaterial.setState(2);
							materialDao.update(oldMaterial);
						}

						Material material = materialDao.selectOne(applyRecord.getmId());
						material.setState(1);
						materialDao.update(material);

						info.setmId(applyRecord.getmId());
					}
					infoDao.update(info);

				} else {
					task.setRemark(remark);
					applyRecord.setRemark(remark);
				}

				applyRecord.setState(result);
				applyRecord.setConfirmTime(date);
				applyRecordDao.update(applyRecord);

				task.setState(SamplingTaskEnum.ACCOMPLISH.getState());
				task.setInfoApply(0);
				taskDao.update(task);
				
				// 操作记录
				TaskRecord record = new TaskRecord();
				record.setCreateTime(date);
				record.setCode(task.getCode());
				record.setaId(account.getId());
				record.setTaskType(task.getType());
				record.setState(SamplingTaskRecordEnum.INFO_UPDATE.getState());
				record.setRemark("修改基本信息");
				taskRecordDao.insert(record);
			}
		} else if (catagory == 2) {

			ApplyRecord applyRecord = applyRecordService.getRecordByTaskId(task.getId(), 2);
			if (result == 1) {
				task.setState(SamplingTaskEnum.ACCOMPLISH.getState());
			}else{
				task.setFailNum(1);
				task.setRemark(remark);
				task.setState(SamplingTaskEnum.APPLY_NOTPASS.getState());
				applyRecord.setRemark(remark);
			}
			
			Info info = task.getInfo();
			info.setState(result);
			infoDao.update(info);

			applyRecord.setState(result);
			applyRecord.setConfirmTime(date);
			applyRecordDao.update(applyRecord);

			// 父任务
			Task pTask = taskDao.selectOne(task.gettId());
			pTask.setResultApply(0);
			pTask.setState(SamplingTaskEnum.ACCOMPLISH.getState());
			taskDao.update(pTask);

			task.setResultApply(0);
			task.setConfirmTime(date);
			taskDao.update(task);
			
			// 操作记录
			TaskRecord record = new TaskRecord();
			record.setCreateTime(date);
			record.setCode(task.getCode());
			record.setaId(account.getId());
			record.setTaskType(task.getType());
			record.setState(SamplingTaskRecordEnum.RESULT_UPDATE.getState());
			record.setRemark("修改试验结果信息");
			taskRecordDao.insert(record);
			
		} else {
			// 操作记录
			TaskRecord record = new TaskRecord();
			record.setCreateTime(date);
			record.setCode(task.getCode());
			record.setaId(account.getId());
			record.setTaskType(task.getType());

			if (result == 1) {
				task.setState(SamplingTaskEnum.UPLOAD.getState());
				task.setMatAtlResult(1);
				task.setPartsAtlResult(1);

				record.setRemark("审批通过");
				record.setState(SamplingTaskRecordEnum.APPROVE_AGREE.getState());
			} else {
				task.setState(SamplingTaskEnum.APPROVE_NOTPASS.getState());

				record.setState(SamplingTaskRecordEnum.APPROVE_DISAGREE.getState());
				record.setRemark("审批不通过：" + remark);
			}

			taskDao.update(task);
			taskRecordDao.insert(record);
		}
		
		String logDetail = "审批任务，任务号：" + task.getCode() + "，审批结果：" + remark;
		addLog(account.getUserName(), OperationType.APPROVE, ServiceType.TASK, logDetail);
    }

    
    
    /**
     * 申请信息修改
     * @param account
     * @param vehicle    整车信息
     * @param parts      零部件信息
     * @param material   原材料信息
     * @param task       任务
     */
    public void applyInfo(Account account, Task task, Vehicle vehicle, Parts parts, Material material){
		task.setInfoApply(1);
		if(task.getType() == TaskTypeEnum.OTS.getState() || task.getType() == TaskTypeEnum.GS.getState()){
			task.setState(StandardTaskEnum.APPLYING.getState());
		}else if(task.getType() == TaskTypeEnum.PPAP.getState() || task.getType() == TaskTypeEnum.SOP.getState()){
			task.setState(SamplingTaskEnum.APPLYING.getState());
		}
		taskDao.update(task);

		ApplyRecord applyRecord = new ApplyRecord();
		applyRecord.setaId(account.getId());
		applyRecord.setCreateTime(new Date());
		applyRecord.setState(0);
		applyRecord.settId(task.getId());
		applyRecord.setType(1);
		
		if(vehicle != null){
			vehicleDao.insert(vehicle);
			applyRecord.setvId(vehicle.getId());
		}
		if(parts != null){
			partsDao.insert(parts);
			applyRecord.setpId(parts.getId());
		}
		if(material != null){
			materialDao.insert(material);
			applyRecord.setmId(material.getId());
		}
		
		applyRecordDao.insert(applyRecord);
		
		// 操作记录
		TaskRecord record = new TaskRecord();
		record.setCreateTime(new Date());
		record.setCode(task.getCode());
		record.setaId(account.getId());
		record.setTaskType(task.getType());
		record.setRemark("申请信息修改");
		if (task.getType() == TaskTypeEnum.OTS.getState() || task.getType() == TaskTypeEnum.GS.getState()) {
			record.setState(StandardTaskRecordEnum.INFO_APPLY.getState());
		} else if (task.getType() == TaskTypeEnum.PPAP.getState() || task.getType() == TaskTypeEnum.SOP.getState()) {
			record.setState(SamplingTaskRecordEnum.INFO_APPLY.getState());
		}
		taskRecordDao.insert(record);
		
		String logDetail = "申请信息修改，任务号：" + task.getCode();
		addLog(account.getUserName(), OperationType.APPLY_INFO, ServiceType.APPLY, logDetail);
    }
    
    
    
    /**
     * 申请结果修改
     * @param account
     * @param taskId    任务ID
     * @param pfResultList    性能结果
     * @param atlResultList   图谱结果
     */
    public void applyResult(Account account, Long taskId, List<PfResult> pfResultList, List<AtlasResult> atlResultList){
    	Date date = new Date();
    	
    	Task task = taskDao.selectOne(taskId);
    	if(task.getType() == TaskTypeEnum.OTS.getState() || task.getType() == TaskTypeEnum.GS.getState()){
			task.setState(StandardTaskEnum.APPLYING.getState());
		}else if(task.getType() == TaskTypeEnum.PPAP.getState() || task.getType() == TaskTypeEnum.SOP.getState()){
			task.setState(SamplingTaskEnum.APPLYING.getState());
		}
    	task.setResultApply(2);
    	taskDao.update(task);
    	
		Info info = new Info();
		info.setCreateTime(date);
		info.setmId(task.getInfo().getmId());
		info.setpId(task.getInfo().getpId());
		info.setRemark(task.getInfo().getRemark());
		info.setState(0);
		info.setType(task.getInfo().getType());
		info.setvId(task.getInfo().getvId());
    	infoDao.insert(info);
    	
		// 创建新的子订单
    	task.setaId(account.getId());
    	task.setOrgId(account.getOrgId());
    	task.setFailNum(0);
    	task.setCreateTime(date);
    	task.setInfoApply(0);
    	task.setResultApply(1);
    	task.setiId(info.getId());
    	task.setConfirmTime(null);
    	task.settId(task.getId());
    	task.setCode(task.getCode() + "-R" + taskService.getSubTaskNum(task.getId()));
    	task.setId(null);
    	task.setRemark("");
    	taskDao.insert(task);
    	
    	// 操作记录
		TaskRecord record = new TaskRecord();
		record.setCreateTime(date);
		record.setCode(task.getCode());
		record.setaId(account.getId());
		record.setTaskType(task.getType());
		record.setRemark("申请修改试验结果");
		if (task.getType() == TaskTypeEnum.OTS.getState() || task.getType() == TaskTypeEnum.GS.getState()) {
			record.setState(StandardTaskRecordEnum.RESULT_APPLY.getState());
		} else if (task.getType() == TaskTypeEnum.PPAP.getState() || task.getType() == TaskTypeEnum.SOP.getState()) {
			record.setState(SamplingTaskRecordEnum.RESULT_APPLY.getState());
		}
		taskRecordDao.insert(record);
		
		// 型式结果
		if (pfResultList != null && pfResultList.size() > 0) {
			for (PfResult pf : pfResultList) {
				pf.setCreateTime(date);
				pf.setExpNo(1);
				pf.settId(task.getId());
			}
			pfResultDao.batchAdd(pfResultList);
		}
    	
		// 图谱结果
		if (atlResultList != null && atlResultList.size() > 0) {
			for (AtlasResult at : atlResultList) {
				at.settId(task.getId());
				at.setExpNo(1);
				at.setCreateTime(date);
			}
			atlasResultDao.batchAdd(atlResultList);
		}
		
		// 对比结论
		if(task.getType() == TaskTypeEnum.PPAP.getState() || task.getType() == TaskTypeEnum.SOP.getState()) {
			Map<String, Object> rMap = new PageMap(false);
			rMap.put("type", 4);
			rMap.put("catagorys", 8);
			rMap.put("taskId", taskId);
			List<ExamineRecord> recordList = examineRecordDao.selectAllList(rMap);
			
			if (recordList != null && recordList.size() > 0) {
				List<ExamineRecord> newList = new ArrayList<ExamineRecord>();
				for (ExamineRecord rd : recordList) {
					rd.settId(task.getId());
					rd.setCreateTime(date);
					rd.setId(null);
					newList.add(rd);
				}
				
				if (newList.size() > 0) {
					examineRecordDao.batchAdd(newList);
				}
			}
		}
		
		// 申请记录
		ApplyRecord applyRecord = new ApplyRecord();
		applyRecord.setaId(account.getId());
		applyRecord.setCreateTime(date);
		applyRecord.setState(0);
		applyRecord.settId(task.getId());
		applyRecord.setType(2);
		applyRecordDao.insert(applyRecord);
		
		String logDetail = "申请试验结果修改，任务号：" + task.getCode();
		addLog(account.getUserName(), OperationType.APPLY_RESULT, ServiceType.APPLY, logDetail);
    }
    
    
    /**
     * 获取信息ID列表
     */
	public List<Long> selectIdList(Map<String, Object> map) {
		return infoDao.selectIdList(map);
	}
    
	
	
	/**
	 * 生成订单编码
	 */
	String generateTaskCode(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String taskCode = sdf.format(date);

		return taskCode;
	}
	
	/**
	 * 是否有在使用的
	 * @param iId   信息ID
	 * @param id    ID
	 * @param type  类型：1-整车信息，2-零部件信息，3-原材料信息
	 * @return
	 */
	boolean isUse(Long iId, Long id, int type) {
		Map<String, Object> map = new PageMap(false);

		if (type == 1) {
			map.put("vId", id);
		} else if (type == 2) {
			map.put("pId", id);
		} else {
			map.put("mId", id);
		}
		map.put("state", 1);

		List<Info> infoList = infoDao.selectAllList(map);
		boolean flag = false;
		if (infoList != null && infoList.size() > 0) {
			for (Info info : infoList) {
				if (info.getId().longValue() != iId.longValue()) {
					flag = true;
					break;
				}
			}
			return flag;
		} else {
			return false;
		}
	}
	
	/**
	 *  添加日志
	 */
	void addLog(String userName, OperationType operationType, ServiceType serviceType, String logDetail) {
		operationLogService.save(userName, operationType, serviceType, logDetail);
	}
}
