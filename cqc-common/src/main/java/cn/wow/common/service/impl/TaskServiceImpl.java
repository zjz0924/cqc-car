package cn.wow.common.service.impl;

import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.wow.common.dao.AtlasResultDao;
import cn.wow.common.dao.CostRecordDao;
import cn.wow.common.dao.EmailRecordDao;
import cn.wow.common.dao.ExamineRecordDao;
import cn.wow.common.dao.InfoDao;
import cn.wow.common.dao.LabConclusionDao;
import cn.wow.common.dao.LabReqDao;
import cn.wow.common.dao.MaterialDao;
import cn.wow.common.dao.PartsDao;
import cn.wow.common.dao.PfResultDao;
import cn.wow.common.dao.ReasonDao;
import cn.wow.common.dao.TaskDao;
import cn.wow.common.dao.TaskRecordDao;
import cn.wow.common.dao.VehicleDao;
import cn.wow.common.domain.Account;
import cn.wow.common.domain.CostRecord;
import cn.wow.common.domain.EmailRecord;
import cn.wow.common.domain.ExamineRecord;
import cn.wow.common.domain.Info;
import cn.wow.common.domain.Material;
import cn.wow.common.domain.Parts;
import cn.wow.common.domain.Task;
import cn.wow.common.domain.TaskRecord;
import cn.wow.common.domain.Vehicle;
import cn.wow.common.service.CommonService;
import cn.wow.common.service.OperationLogService;
import cn.wow.common.service.TaskService;
import cn.wow.common.utils.operationlog.OperationType;
import cn.wow.common.utils.operationlog.ServiceType;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.utils.taskState.EmailTypeEnum;
import cn.wow.common.utils.taskState.SamplingTaskEnum;
import cn.wow.common.utils.taskState.SamplingTaskRecordEnum;
import cn.wow.common.utils.taskState.StandardTaskEnum;
import cn.wow.common.utils.taskState.StandardTaskRecordEnum;
import cn.wow.common.utils.taskState.TaskTypeEnum;

@Service
@Transactional
public class TaskServiceImpl implements TaskService {

	private static Logger logger = LoggerFactory.getLogger(TaskServiceImpl.class);

	// 邮箱账号
	@Value("${mail.user}")
	protected String mailUser;

	// 结果标题
	@Value("${result.title}")
	protected String titleTemplate;
	// 结果内容
	@Value("${result.content}")
	protected String contentTemplate;

	@Autowired
	private TaskDao taskDao;
	@Autowired
	private EmailRecordDao emailRecordDao;
	@Autowired
	private TaskRecordDao taskRecordDao;
	@Autowired
	private InfoDao infoDao;
	@Autowired
	private PartsDao partsDao;
	@Autowired
	private MaterialDao materialDao;
	@Autowired
	private VehicleDao vehicleDao;
	@Autowired
	private ExamineRecordDao examineRecordDao;
	@Autowired
	private CostRecordDao costRecordDao;
	@Autowired
	private OperationLogService operationLogService;
	@Autowired
	private CommonService commonService;
	@Autowired
	private LabConclusionDao labConclusionDao;
	@Autowired
	private LabReqDao labReqDao;
	@Autowired
	private PfResultDao pfResultDao;
	@Autowired
	private AtlasResultDao atlasResultDao;
	@Autowired
	private ReasonDao reasonDao;

	public Task selectOne(Long id) {
		return taskDao.selectOne(id);
	}

	public int save(String userName, Task task) {
		return taskDao.insert(task);
	}

	public int update(String userName, Task task) {
		return taskDao.update(task);
	}

	public int deleteByPrimaryKey(String userName, Task task) {
		// 试验结论
		labConclusionDao.deleteByPrimaryKey(task.getId());
		// 实验要求
		labReqDao.deleteByTaskId(task.getId());
		// 型式试验
		pfResultDao.deleteByPrimaryKey(task.getId());
		// 图谱试验
		atlasResultDao.deleteByPrimaryKey(task.getId());
		// 抽样原因
		if (task.getReasonId() != null) {
			reasonDao.deleteByPrimaryKey(task.getReasonId());
		}
		// 任务记录
		taskRecordDao.deleteByCode(task.getCode());
		// 费用记录
		costRecordDao.deleteByPrimaryKey(task.getId());
		// 邮件
		emailRecordDao.deleteByPrimaryKey(task.getId());
		// 审核记录
		examineRecordDao.deleteByPrimaryKey(task.getId());

		return taskDao.deleteByPrimaryKey(task.getId());
	}

	public List<Task> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return taskDao.selectAllList(map);
	}

	/**
	 * 结果发送
	 * 
	 * @param taskId  任务ID
	 * @param pAtlVal 零件图谱
	 * @param pPatVal 零件型式
	 * @param mAtlVal 材料图谱
	 * @param mPatVal 材料型式
	 * @param type    类型：1-发送结果， 2-不发送，直接跳过
	 */
	public void sendResult(Account account, Long taskId, String pAtlVal, String pPatVal, String mAtlVal, String mPatVal,
			Integer type) throws Exception {

		Task task = this.selectOne(taskId);
		Date date = new Date();
		String remark = "";

		if (StringUtils.isNotBlank(pAtlVal) || type.intValue() == 2) {
			task.setPartsAtlResult(3);
			remark += "零件图谱试验、";
		}

		if (StringUtils.isNotBlank(pPatVal) || type.intValue() == 2) {
			task.setPartsPatResult(3);
			remark += "零件型式试验、";
		}

		if (StringUtils.isNotBlank(mAtlVal) || type.intValue() == 2) {
			task.setMatAtlResult(3);
			remark += "材料图谱试验、";
		}

		if (StringUtils.isNotBlank(mPatVal) || type.intValue() == 2) {
			task.setMatPatResult(3);
			remark += "材料型式试验、";
		}

		if (StringUtils.isNotBlank(remark)) {
			remark = remark.substring(0, remark.length() - 1);
			remark = "发送" + remark + "结果";
		}

		// PPAP/SOP任务发送结果后，进入结果接收阶段
		if (task.getType() == TaskTypeEnum.PPAP.getState() || task.getType() == TaskTypeEnum.SOP.getState()) {
			task.setState(SamplingTaskEnum.COMFIRM.getState());
		}

		// 更新任务的结果情况
		taskDao.update(task);

		// 任务记录
		TaskRecord taskRecord = new TaskRecord(task.getCode(), account.getId(), StandardTaskRecordEnum.SEND.getState(),
				remark, date, task.getType());
		taskRecordDao.insert(taskRecord);

		// 发送结果（最后发送，防止事务提交失败）
		if (type == 1) {
			if (StringUtils.isNotBlank(pAtlVal)) {
				sendResultEmail(account, task, date, pAtlVal, 1);
			}

			if (StringUtils.isNotBlank(pPatVal)) {
				sendResultEmail(account, task, date, pPatVal, 2);
			}

			if (StringUtils.isNotBlank(mAtlVal)) {
				sendResultEmail(account, task, date, mAtlVal, 3);
			}

			if (StringUtils.isNotBlank(mPatVal)) {
				sendResultEmail(account, task, date, mPatVal, 4);
			}
		} else {
			remark = "不发送结果";
		}

		// 操作日志
		String logDetail = remark + "，任务号：" + task.getCode();
		addLog(account.getUserName(), OperationType.SEND, ServiceType.LAB, logDetail);
	}

	/**
	 * 结果接收
	 * 
	 * @param taskId 任务ID
	 * @param result 结果：1-合格，2-不合格
	 * @param type   类型：1-零件图谱试验，2-零件型式试验，3-材料图谱试验，4-材料型式试验，5-全部 （针对OTS任务类型）
	 * @param remark 不合格的理由
	 * @param orgs   发送警告书的机构
	 */
	public void confirmResult(Account account, Long ids[], int result, int type, String remark, String orgs)
			throws Exception {

		if (ids != null && ids.length > 0) {
			for (Long id : ids) {
				Task task = this.selectOne(id);

				// OTS/GS 任务
				if (task.getType() == TaskTypeEnum.OTS.getState() || task.getType() == TaskTypeEnum.GS.getState()) {
					OtsResultConfirm(task, account, result, type, remark);
				} else if (task.getType() == TaskTypeEnum.PPAP.getState()
						|| task.getType() == TaskTypeEnum.SOP.getState()) {
					PpapResultConfirm(task, account, result, remark, orgs);
				}
			}
		}
	}

	/**
	 * OTS 结果接收
	 */
	void OtsResultConfirm(Task task, Account account, int result, int type, String remark) {
		boolean isPass = false;
		Date date = new Date();

		if (result == 1) {
			if (type == 1) {
				task.setPartsAtlResult(4);
				remark += "零件图谱试验、";
			} else if (type == 2) {
				task.setPartsPatResult(4);
				remark += "零件型式试验、";
			} else if (type == 3) {
				task.setMatAtlResult(4);
				remark += "材料图谱试验、";
			} else if (type == 4) {
				task.setMatPatResult(4);
				remark += "材料型式试验、";
			} else {
				if (task.getMatAtlId() != null && task.getMatAtlResult() != 4) {
					task.setMatAtlResult(4);
					remark += "材料图谱试验、";
				}

				if (task.getMatPatId() != null && task.getMatPatResult() != 4) {
					task.setMatPatResult(4);
					remark += "材料型式试验、";
				}

				if (task.getPartsAtlId() != null && task.getPartsAtlResult() != 4) {
					task.setPartsAtlResult(4);
					remark += "零件图谱试验、";
				}

				if (task.getPartsPatId() != null && task.getPartsPatResult() != 4) {
					task.setPartsPatResult(4);
					remark += "零件型式试验、";
				}
				isPass = true;
			}

			if (StringUtils.isNotBlank(remark)) {
				remark = remark.substring(0, remark.length() - 1);
				remark = remark + "结果接收";
			}

			// 所有实验已确认（可以单独分开接收结果）
			if (!isPass) {
				if (task.getType() == TaskTypeEnum.OTS.getState()) {
					if (task.getMatAtlId() != null) {
						if (task.getMatAtlResult() == 4) {
							isPass = true;
						} else {
							isPass = false;
						}
					}

					if (task.getPartsAtlId() != null) {
						if (task.getPartsAtlResult() == 4) {
							isPass = true;
						} else {
							isPass = false;
						}
					}
				} else if (task.getType() == TaskTypeEnum.GS.getState()) {
					// 有做实验的都必须接收才是完成
					if (task.getPartsAtlId() != null) {
						if (task.getPartsAtlResult() == 4) {
							isPass = true;
						} else {
							isPass = false;
						}
					}

					if (task.getPartsPatId() != null) {
						if (task.getPartsAtlResult() == 4) {
							isPass = true;
						} else {
							isPass = false;
						}
					}

					if (task.getMatAtlId() != null) {
						if (task.getMatAtlResult() == 4) {
							isPass = true;
						} else {
							isPass = false;
						}
					}

					if (task.getMatPatId() != null) {
						if (task.getMatPatResult() == 4) {
							isPass = true;
						} else {
							isPass = false;
						}
					}
				}
			}

			if (isPass) {
				task.setState(StandardTaskEnum.ACCOMPLISH.getState());
				task.setConfirmTime(new Date());
				// 保存基准信息
				saveStandard(account, task);
			}
			task.setIsReceive(result);
			taskDao.update(task);

			// 确认记录
			ExamineRecord examineRecord = new ExamineRecord(task.getId(), account.getId(), result, remark, 3, type,
					date, TaskTypeEnum.OTS.getState());
			examineRecordDao.insert(examineRecord);

			// 任务记录
			TaskRecord taskRecord = new TaskRecord(task.getCode(), account.getId(),
					StandardTaskRecordEnum.CONFIRM.getState(), remark, date, task.getType());
			taskRecordDao.insert(taskRecord);

		} else {
			String temp = "";
			if (type == 1) {
				task.setPartsAtlResult(0);
				task.setPartsAtlId(null);
				temp += "零件图谱试验、";
			} else if (type == 2) {
				task.setPartsPatResult(0);
				task.setPartsPatId(null);
				temp += "零件型式试验、";
			} else if (type == 3) {
				task.setMatAtlResult(0);
				task.setMatAtlId(null);
				temp += "材料图谱试验、";
			} else if (type == 4) {
				task.setMatPatResult(0);
				task.setMatPatId(null);
				temp += "材料型式试验、";
			} else {

				task.setPartsAtlResult(0);
				task.setPartsAtlId(null);
				temp += "零件图谱试验、";

				task.setPartsPatResult(0);
				task.setPartsPatId(null);
				temp += "零件型式试验、";

				task.setMatAtlResult(0);
				task.setMatAtlId(null);
				temp += "材料图谱试验、";

				task.setMatPatResult(0);
				task.setMatPatId(null);
				temp += "材料型式试验、";
			}

			if (StringUtils.isNotBlank(temp)) {
				temp = temp.substring(0, temp.length() - 1);
				temp = temp + "结果不接收";
			}
			remark = temp + ",不接收原因：" + remark;

			// 任务记录
			TaskRecord taskRecord = new TaskRecord(task.getCode(), account.getId(),
					StandardTaskRecordEnum.CONFIRM.getState(), remark, new Date(), task.getType());
			taskRecordDao.insert(taskRecord);

			// 确认记录
			ExamineRecord examineRecord = new ExamineRecord(task.getId(), account.getId(), result, remark, 3, type,
					date, TaskTypeEnum.OTS.getState());
			examineRecordDao.insert(examineRecord);

			task.setIsReceive(result);
			taskDao.update(task);
		}

		// 费用记录
		List<CostRecord> costRecordList = new ArrayList<CostRecord>();
		if (type != 5) {
			costRecordList.add(getCostRecord(account, date, task, type, result));
		} else {
			if (task.getType() == TaskTypeEnum.OTS.getState() || task.getType() == TaskTypeEnum.GS.getState()) {
				costRecordList.add(getCostRecord(account, date, task, 1, result));
				costRecordList.add(getCostRecord(account, date, task, 2, result));
			}
			costRecordList.add(getCostRecord(account, date, task, 3, result));
			costRecordList.add(getCostRecord(account, date, task, 4, result));
		}
		costRecordDao.batchAdd(costRecordList);

		if (StringUtils.isBlank(remark)) {
			remark = "结果接收，结果合格";
		}

		// 操作日志
		String logDetail = remark + "，任务号：" + task.getCode();
		addLog(account.getUserName(), OperationType.CONFIRM, ServiceType.LAB, logDetail);
	}

	/**
	 * PPAP 任务结果接收
	 */
	void PpapResultConfirm(Task task, Account account, int result, String remark, String orgs) throws Exception {
		Date date = new Date();

		task.setState(SamplingTaskEnum.ACCOMPLISH.getState());
		task.setConfirmTime(new Date());
		task.setIsReceive(result);

		if (result == 1) {

			taskDao.update(task);

			// 确认记录
			ExamineRecord examineRecord = new ExamineRecord(task.getId(), account.getId(), result, "接收结果", 3, null,
					date, TaskTypeEnum.PPAP.getState());
			examineRecordDao.insert(examineRecord);

			// 任务记录
			TaskRecord taskRecord = new TaskRecord(task.getCode(), account.getId(),
					SamplingTaskRecordEnum.SAVE.getState(), "结果留存", date, task.getType());
			taskRecordDao.insert(taskRecord);
		} else {
			task.setFailNum(1);
			task.setRemark(remark);
			taskDao.update(task);

			// 确认记录
			ExamineRecord examineRecord = new ExamineRecord(task.getId(), account.getId(), result, "不接收结果，原因：" + remark,
					3, null, date, TaskTypeEnum.PPAP.getState());
			examineRecordDao.insert(examineRecord);

			// 任务记录
			TaskRecord taskRecord = new TaskRecord(task.getCode(), account.getId(),
					SamplingTaskRecordEnum.SAVE.getState(), "不接收结果，原因：" + remark, date, task.getType());
			taskRecordDao.insert(taskRecord);
		}

		// 费用记录
		List<CostRecord> costRecordList = new ArrayList<CostRecord>();
		if (task.getPartsAtlId() != null) {
			costRecordList.add(getCostRecord(account, date, task, 1, task.getResult()));
		}
		if (task.getMatAtlId() != null) {
			costRecordList.add(getCostRecord(account, date, task, 3, task.getResult()));
		}
		costRecordDao.batchAdd(costRecordList);

		if (StringUtils.isBlank(remark)) {
			if (result == 1) {
				remark = "接收结果";
			} else {
				remark = "不接收结果";
			}
		}

		// 操作日志
		String logDetail = remark + "，任务号：" + task.getCode();
		addLog(account.getUserName(), OperationType.CONFIRM, ServiceType.LAB, logDetail);
	}

	/**
	 * 结果对比
	 * 
	 * @param taskId            任务ID
	 * @param examineRecordList 对比结果
	 * @param state             状态：1-正常，2-异常
	 */
	public void compareResult(Account account, Long taskId, List<ExamineRecord> examineRecordList, int state,
			int result) {
		Task task = taskDao.selectOne(taskId);
		Date date = new Date();
		String remark = "";
		Integer recordState = null;

		if (state == 1) {
			task.setState(SamplingTaskEnum.SENDING.getState());
			task.setResult(result);

			remark = "提交对比结果";
			recordState = SamplingTaskRecordEnum.COMPARISON_NORMAL.getState();

			examineRecordDao.batchAdd(examineRecordList);
		} else {
			task.setState(SamplingTaskEnum.UPLOAD.getState());
			task.setPartsAtlResult(1);
			task.setMatAtlResult(1);
			remark = "结果异常，需要重新上传";
			recordState = SamplingTaskRecordEnum.COMPARISON_NORMAL.getState();

			// 确认记录
			ExamineRecord examineRecord = new ExamineRecord(taskId, account.getId(), state, remark, 4, 11, date,
					TaskTypeEnum.PPAP.getState());
			examineRecordDao.insert(examineRecord);
		}
		taskDao.update(task);

		// 操作记录
		TaskRecord taskRecord = new TaskRecord(task.getCode(), account.getId(), recordState, remark, new Date(),
				task.getType());
		taskRecordDao.insert(taskRecord);

		// 操作日志
		String logDetail = remark + "，任务号：" + task.getCode();
		addLog(account.getUserName(), OperationType.COMPARE, ServiceType.LAB, logDetail);
	}

	/**
	 * 基准保存： 修改信息、零件、材料、车型信息的状态为已审核
	 */
	public void saveStandard(Account account, Task task) {
		Integer state = 1;

		// 信息
		Info info = infoDao.selectOne(task.getiId());
		info.setState(state);
		infoDao.update(info);

		// 材料
		Material material = materialDao.selectOne(info.getmId());
		if (material.getState() == 0) {
			material.setState(state);
			materialDao.update(material);
		}

		// 车型
		Vehicle vehicle = vehicleDao.selectOne(info.getvId());
		if (vehicle.getState() == 0) {
			vehicle.setState(state);
			vehicleDao.update(vehicle);
		}

		if (task.getType() == TaskTypeEnum.OTS.getState()) {
			// 零件
			Parts parts = partsDao.selectOne(info.getpId());
			if (parts.getState() == 0) {
				parts.setState(state);
				partsDao.update(parts);
			}
		}

		// 任务记录
		TaskRecord taskRecord = new TaskRecord(task.getCode(), account.getId(), StandardTaskRecordEnum.SAVE.getState(),
				"基准信息已保存", new Date(), task.getType());
		taskRecordDao.insert(taskRecord);
	}

	/**
	 * 发送邮件
	 * 
	 * @param account 用户
	 * @param task    任务
	 * @param date    日期
	 * @param emails  用户邮箱
	 * @param tips    提示
	 * @param title   标题
	 * @param content 内容
	 * @param type    类型：1-结果发送，2-收费通知
	 */
	protected void sendResultEmail(Account account, Task task, Date date, String emails, int type) throws Exception {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");

		String labOrg = "";
		String lab = "";

		if (type == 1) {
			lab = "零件图谱试验";

			if (task.getPartsAtl() != null) {
				labOrg = task.getPartsAtl().getName();
			}
		} else if (type == 2) {
			lab = "零件型式试验";

			if (task.getPartsPat() != null) {
				labOrg = task.getPartsPat().getName();
			}
		} else if (type == 3) {
			lab = "材料图谱试验";

			if (task.getMatAtl() != null) {
				labOrg = task.getMatAtl().getName();
			}
		} else if (type == 4) {
			lab = "材料型式试验";

			if (task.getMatPat() != null) {
				labOrg = task.getMatPat().getName();
			}
		}

		String contentTemp = MessageFormat.format(contentTemplate,
				new Object[] { sdf.format(task.getCreateTime()), task.getCode(), labOrg, lab });
		String[] emailArray = emails.split(";");

		if (emailArray != null && emailArray.length > 0) {
			List<EmailRecord> emailRecordList = new ArrayList<EmailRecord>();

			for (String email : emailArray) {
				if (StringUtils.isNotBlank(email)) {
					// 邮件记录
					EmailRecord emailRecord = new EmailRecord(titleTemplate, contentTemp, email, task.getId(),
							account.getId(), EmailTypeEnum.RESULT, mailUser, date);
					emailRecordList.add(emailRecord);
				}
			}

			// 邮件记录
			if (emailRecordList.size() > 0) {
				emailRecordDao.batchAdd(emailRecordList);
			}

			// 发送邮件
			commonService.sendEmail(titleTemplate, contentTemp, emails, null, 2);
		}
	}

	/**
	 * 组装费用记录
	 * 
	 * @param account 操作人
	 * @param date    时间
	 * @param task    任务
	 * @param type    类型： 1-零件图谱，2-零件型式，3-材料图谱，4-材料型式
	 * @param result  实验结果（1-合格，2-不合格）
	 */
	CostRecord getCostRecord(Account account, Date date, Task task, int type, int result) {
		Long labId = null;
		int times = 0;

		if (type == 1) {
			labId = task.getPartsAtlId();
			times = task.getPartsAtlTimes();
		} else if (type == 2) {
			labId = task.getPartsPatId();
			times = task.getPartsPatTimes();
		} else if (type == 3) {
			labId = task.getMatAtlId();
			times = task.getMatAtlTimes();
		} else if (type == 4) {
			labId = task.getMatPatId();
			times = task.getMatPatTimes();
		}

		CostRecord costRecord = new CostRecord();
		costRecord.setaId(account.getId());
		costRecord.setCreateTime(date);
		costRecord.setLabId(labId);
		costRecord.setLabType(type);
		costRecord.setState(0);
		costRecord.settId(task.getId());
		costRecord.setTimes(times);
		costRecord.setLabResult(result);

		return costRecord;
	}

	/**
	 * PPAP任务第二次确认
	 * 
	 * @param taskId 任务ID
	 * @param result 结果：1-第二次抽样，2-中止任务
	 * @param remark 不合格的理由
	 */
	public void confirmResult(Account account, Long taskId, int result, String remark) {
		Task task = taskDao.selectOne(taskId);
		Date date = new Date();

		if (result == 1) {
			task.setState(SamplingTaskEnum.ACCOMPLISH.getState());
			taskDao.update(task);

			remark = "进行二次抽样";

			// 新建子任务
			Task subTask = new Task();
			subTask.setCode(task.getCode() + "-R" + this.getSubTaskNum(task.getId()));
			subTask.setCreateTime(date);
			subTask.setiId(task.getiId());
			subTask.setOrgId(account.getOrgId());
			subTask.setState(SamplingTaskEnum.APPROVE.getState());
			subTask.setType(task.getType());
			subTask.setFailNum(0);
			subTask.setaId(account.getId());
			subTask.setMatAtlResult(0);
			subTask.setMatPatResult(0);
			subTask.setPartsAtlResult(0);
			subTask.setPartsPatResult(0);
			subTask.setPartsAtlId(task.getPartsAtlId());
			subTask.setMatAtlId(task.getMatAtlId());
			subTask.setPartsAtlTimes(0);
			subTask.setPartsPatTimes(0);
			subTask.setMatAtlTimes(0);
			subTask.setMatPatTimes(0);
			subTask.setInfoApply(0);
			subTask.setResultApply(0);
			subTask.settId(task.getId());
			taskDao.insert(subTask);

		} else {
			task.setState(SamplingTaskEnum.END.getState());
			task.setConfirmTime(date);
			task.setRemark(remark);
			remark = "中止任务，原因：" + remark;
			taskDao.update(task);
		}

		// 确认记录
		ExamineRecord examineRecord = new ExamineRecord(taskId, account.getId(), result, remark, 5, null, date,
				TaskTypeEnum.PPAP.getState());
		examineRecordDao.insert(examineRecord);

		// 任务记录
		TaskRecord taskRecord = new TaskRecord(task.getCode(), account.getId(),
				SamplingTaskRecordEnum.RECONFIRM.getState(), remark, date, task.getType());
		taskRecordDao.insert(taskRecord);

	}

	/**
	 * 获取info id 批量查询任务
	 * 
	 * @param list
	 */
	public List<Task> batchQueryByInfoId(List<Long> list) {
		return taskDao.batchQueryByInfoId(list);
	}

	/**
	 * 获取待办任务
	 */
	public List<Task> getBacklogTask(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return taskDao.getBacklogTask(map);
	}

	/**
	 * 获取子任务的数量
	 * 
	 * @param taskId
	 */
	public int getSubTaskNum(Long taskId) {
		// 查看子任务的数量
		Map<String, Object> tMap = new PageMap(false);
		tMap.put("tId", taskId);
		List<Task> taskList = taskDao.selectAllList(tMap);

		int taskNum = 1;
		if (taskList != null && taskList.size() > 0) {
			taskNum = taskList.size() + 1;
		}
		return taskNum;
	}

	/**
	 * 获取最上级的父任务
	 * 
	 * @param taskId
	 */
	public Task getRootTask(Long taskId) {
		Task task = taskDao.selectOne(taskId);
		if (task != null) {
			if (task.gettId() != null) {
				return getRootTask(task.gettId());
			} else {
				return task;
			}
		} else {
			return null;
		}
	}

	/**
	 * 获取任务数
	 */
	public Integer getTaskNum(Map<String, Object> map) {
		return taskDao.getTaskNum(map);
	}

	/**
	 * 添加日志
	 */
	void addLog(String userName, OperationType operationType, ServiceType serviceType, String logDetail) {
		operationLogService.save(userName, operationType, serviceType, logDetail);
	}

	/**
	 * 查询基准任务
	 * 
	 * @code 任务号
	 */
	public Task getStandardTask(String code) {
		Map<String, Object> qMap = new HashMap<String, Object>();
		qMap.put("qCode", code);
		qMap.put("type", TaskTypeEnum.OTS.getState());
		qMap.put("state", StandardTaskEnum.ACCOMPLISH.getState());

		List<Task> taskList = taskDao.selectAllList(qMap);
		if (taskList != null && taskList.size() > 0) {
			return taskList.get(0);
		} else {
			return null;
		}
	}
}
