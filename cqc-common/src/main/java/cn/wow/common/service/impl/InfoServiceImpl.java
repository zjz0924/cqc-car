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
		Date date = material.getCreateTime();
		String taskCode = generateTaskCode(date);

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
			task.setPartsAtlTimes(0);
			task.setPartsPatTimes(0);
			task.setMatAtlTimes(0);
			task.setMatPatTimes(0);
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
		
		// 审核记录
		ExamineRecord examineRecord = new ExamineRecord();
		examineRecord.setaId(account.getId());
		examineRecord.setCreateTime(date);
		examineRecord.setRemark(remark);
		examineRecord.setState(type);
		examineRecord.settId(id);
		examineRecord.setType(1);
		examineRecord.setTaskType(TaskTypeEnum.OTS.getState());
		examineRecordDao.insert(examineRecord);
		
		// 操作记录
		TaskRecord record = new TaskRecord();
		record.setCreateTime(date);
		record.setCode(task.getCode());
		record.setaId(account.getId());
		
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
		}
		if(matAtlId != null){
			task.setMatAtlId(matAtlId);
		}
		if(partsPatId != null){
			task.setPartsPatId(partsPatId);
		}
		if(matPatId != null){
			task.setMatPatId(matPatId);
		}
		taskDao.update(task);

		// 操作记录
		TaskRecord record = new TaskRecord();
		record.setCreateTime(new Date());
		record.setCode(task.getCode());
		record.setaId(account.getId());
		record.setState(StandardTaskRecordEnum.TRANSMIT.getState());
		record.setRemark("分配任务到实验室");
		taskRecordDao.insert(record);
	}
	
	
   /**
	 * 下达任务（PPAP）
	 * 
	 * @param t_id         任务ID
	 * @param v_id         整车信息ID
	 * @param p_id         零部件信息ID
	 * @param m_id         原材料信息ID
	 * @param partsAtlId   零部件图谱实验室ID
	 * @param matAtlId     原材料图谱实验室ID
	 * @param partsPatId   零部件型式实验室ID
	 * @param matPatId     原材料型式实验室ID
	 */
	public boolean transmit(Account account, Long t_id, Long v_id, Long p_id, Long m_id, Long partsAtlId, Long matAtlId,
			Long partsPatId, Long matPatId) {

		if (t_id == null) {
			Date date = new Date();
			String code = generateTaskCode(date);

			// 检查当前信息是否已有任务
			Map<String, Object> iMap = new PageMap(false);
			iMap.put("vId", v_id);
			iMap.put("pId", p_id);
			iMap.put("mId", m_id);
			iMap.put("type", TaskTypeEnum.PPAP.getState());
			List<Info> infoList = infoDao.selectAllList(iMap);
			if (infoList != null && infoList.size() > 0) {
				return false;
			}

			// 信息
			Info info = new Info();
			info.setCreateTime(date);
			info.setmId(m_id);
			info.setpId(p_id);
			info.setState(Contants.FINISH_TYPE);
			info.setvId(v_id);
			info.setType(TaskTypeEnum.PPAP.getState());
			infoDao.insert(info);

			Task task = new Task();
			task.setCode(code);
			task.setCreateTime(date);
			task.setiId(info.getId());
			task.setOrgId(account.getOrgId());
			task.setState(SamplingTaskEnum.APPROVE.getState());
			task.setType(TaskTypeEnum.PPAP.getState());
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
			
			taskDao.insert(task);

			// 操作记录
			TaskRecord record = new TaskRecord();
			record.setCreateTime(date);
			record.setCode(code);
			record.setState(SamplingTaskRecordEnum.TRANSMIT.getState());
			record.setaId(account.getId());
			record.setRemark("下达试验任务");
			taskRecordDao.insert(record);

		} else {
			Task task = taskDao.selectOne(t_id);
			task.setPartsAtlId(partsAtlId);
			task.setMatAtlId(matAtlId);
			task.setState(SamplingTaskEnum.APPROVE.getState());
			taskDao.update(task);

			// 操作记录
			TaskRecord record = new TaskRecord();
			record.setCreateTime(new Date());
			record.setCode(task.getCode());
			record.setState(SamplingTaskRecordEnum.TRANSMIT.getState());
			record.setaId(account.getId());
			record.setRemark("下达试验任务");
			taskRecordDao.insert(record);
		}

		return true;
	}
	    
	

	/**
     * 审批（OTS）
     * @param account  操作用户
     * @param id       任务ID
     * @param result   结果：1-通过，2-不通过
     * @param remark   备注
     * @param catagory 分类：1-零部件图谱，2-原材料图谱，3-零部件型式，4-原材料型式，5-全部
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
		
		// 操作记录
		TaskRecord record = new TaskRecord();
		record.setCreateTime(date);
		record.setCode(task.getCode());
		record.setaId(account.getId());

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
				task.setPartsAtlResult(1);
				task.setPartsPatResult(1);
				remark = "图谱和型式试验全部审批通过";
			}
			record.setState(StandardTaskRecordEnum.APPROVE_AGREE.getState());
		} else {
			
			if(catagory == 1){
				task.setPartsAtlResult(0);
				task.setPartsAtlId(null);
				remark = "零部件图谱试验审批不通过：" + remark;
			}else if(catagory == 2){
				task.setMatAtlResult(0);
				task.setMatAtl(null);
				remark = "原材料图谱试验审批不通过：" + remark;
			}else if(catagory == 3){
				task.setPartsPatResult(0);
				task.setPartsPat(null);
				remark = "零部件型式试验审批不通过：" + remark;
			}else if(catagory == 4){
				task.setMatPatResult(0);
				task.setMatPat(null);
				remark = "原材料型式试验审批不通过：" + remark;
			}else{
				task.setMatAtlResult(0);
				task.setMatPatResult(0);
				task.setPartsAtlResult(0);
				task.setPartsPatResult(0);
				
				task.setPartsAtlId(null);
				task.setMatAtlId(null);
				task.setPartsPatId(null);
				task.setMatPatId(null);
				
				remark = "图谱和型式试验全部审批不通过：" + remark;
			}
			record.setState(StandardTaskRecordEnum.APPROVE_DISAGREE.getState());
		}
		
		record.setRemark(remark);
		taskRecordDao.insert(record);
		
		taskDao.update(task);
	}
	
	
	 /**
     * 审批（PPAP）
     * @param account  操作用户
     * @param id       任务ID
     * @param result   结果：1-通过，2-不通过
     * @param remark   备注
     */
    public void approve(Account account, Long id, int result, String remark){
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
		
		// 操作记录
		TaskRecord record = new TaskRecord();
		record.setCreateTime(date);
		record.setCode(task.getCode());
		record.setaId(account.getId());
		
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
	
	
	
	/**
	 * 生成订单编码
	 */
	String generateTaskCode(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String taskCode = sdf.format(date);

		return taskCode;
	}
}
