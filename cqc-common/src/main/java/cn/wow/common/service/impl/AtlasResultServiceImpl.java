package cn.wow.common.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.wow.common.utils.operationlog.OperationType;
import cn.wow.common.utils.operationlog.ServiceType;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.utils.taskState.SamplingTaskEnum;
import cn.wow.common.utils.taskState.StandardTaskRecordEnum;
import cn.wow.common.utils.taskState.TaskTypeEnum;
import cn.wow.common.dao.AtlasResultDao;
import cn.wow.common.dao.ExamineRecordDao;
import cn.wow.common.dao.TaskDao;
import cn.wow.common.dao.TaskRecordDao;
import cn.wow.common.domain.Account;
import cn.wow.common.domain.AtlasResult;
import cn.wow.common.domain.CompareVO;
import cn.wow.common.domain.ExamineRecord;
import cn.wow.common.domain.Task;
import cn.wow.common.domain.TaskRecord;
import cn.wow.common.service.AtlasResultService;
import cn.wow.common.service.OperationLogService;

@Service
@Transactional
public class AtlasResultServiceImpl implements AtlasResultService{

    private static Logger logger = LoggerFactory.getLogger(AtlasResultServiceImpl.class);

    @Autowired
    private AtlasResultDao atlasResultDao;
    @Autowired
    private TaskRecordDao taskRecordDao;
    @Autowired
    private TaskDao taskDao;
    @Autowired
    private ExamineRecordDao examineRecordDao;
    @Autowired
	private OperationLogService operationLogService;
    

    public AtlasResult selectOne(Long id){
    	return atlasResultDao.selectOne(id);
    }

    public int save(String userName, AtlasResult atlasResult){
    	return atlasResultDao.insert(atlasResult);
    }

    public int update(String userName, AtlasResult atlasResult){
    	return atlasResultDao.update(atlasResult);
    }

    public int deleteByPrimaryKey(String userName, AtlasResult atlasResult){
    	return atlasResultDao.deleteByPrimaryKey(atlasResult.getId());
    }

    public List<AtlasResult> selectAllList(Map<String, Object> map){
    	PageHelperExt.startPage(map);
    	return atlasResultDao.selectAllList(map);
    }
    
    public void batchAdd(List<AtlasResult> list){
    	atlasResultDao.batchAdd(list);
    }
    
    // 获取试验次数
    public int getExpNoByCatagory(Long taskId, int catagory){
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("taskId", taskId);
    	map.put("catagory", catagory);
    	return atlasResultDao.getExpNoByCatagory(map);
    }
    
    /**
     * 图谱结果上传
     * @param account
     * @param atlasResult
     */
	public void upload(Account account, List<AtlasResult> atlasResult, Long taskId, Date time) {
		Task task = taskDao.selectOne(taskId);
		String remark = "";
		
		// 批量添加
		batchAdd(atlasResult);
		
		if(atlasResult != null && atlasResult.size() == 6){
			// 实验结果
			task.setMatAtlResult(2);
			task.setPartsAtlResult(2);
			// 实验次数
			task.setPartsAtlTimes(task.getPartsAtlTimes() + 1);
			task.setMatAtlTimes(task.getMatAtlTimes() + 1);
			
			remark = "上传零部件和原材料图谱试验结果";
		}else{
			if(atlasResult.get(0).getCatagory() == 1){
				task.setPartsAtlResult(2);
				task.setPartsAtlTimes(task.getPartsAtlTimes() + 1);
				remark = "上传零部件图谱试验结果";
			}else{
				task.setMatAtlResult(2);
				task.setMatAtlTimes(task.getMatAtlTimes() + 1);
				remark = "上传原材料图谱试验结果";
			}
		}
		
		// PPAP任务
		if (task.getType() == TaskTypeEnum.PPAP.getState() || task.getType() == TaskTypeEnum.SOP.getState()) {
			// 已上传完
			if (task.getMatAtlResult() == 2 && task.getPartsAtlResult() == 2) {
				task.setState(SamplingTaskEnum.COMPARE.getState());
			}
		}

		// 操作记录
		TaskRecord record = new TaskRecord();
		record.setCreateTime(time);
		record.setCode(task.getCode());
		record.setState(StandardTaskRecordEnum.UPLOAD.getState());
		record.setRemark(remark);
		record.setaId(account.getId());
		record.setTaskType(task.getType());
		taskRecordDao.insert(record);

		taskDao.update(task);
		
		String logDetail =  remark + "，任务号：" + task.getCode();
		addLog(account.getUserName(), OperationType.UPLOAD_ATL, ServiceType.LAB, logDetail);
	}

	
	/**
     * 获取基准图谱结果
     * @param iId        信息ID
     * @param catagory  种类：1-零部件，2-原材料
     */
	public List<AtlasResult> getStandardAtlResult(Long iId, int catagory) {
		Map<String, Object> aMap = new PageMap(false);
		aMap.put("iId", iId);
		aMap.put("catagory", catagory);
		return atlasResultDao.getStandardAtlResult(aMap);
	}
	
	
	/**
	 * 组装图谱对比
	 * @param sd_atlasResult  基准图谱
	 * @param sl_atlasResult  抽样图谱
	 */
	public Map<Integer, CompareVO> assembleCompareAtlas(List<AtlasResult> sd_atlasResult, List<AtlasResult> sl_atlasResult){
		Map<Integer, CompareVO> map = new HashMap<Integer, CompareVO>();

		for (AtlasResult ar : sd_atlasResult) {
			CompareVO vo = new CompareVO();
			vo.setStandard_pic(ar.getPic());
			map.put(ar.getType(), vo);
		}

		for (AtlasResult ar : sl_atlasResult) {
			CompareVO vo = map.get(ar.getType());
			vo.setSampling_pic(ar.getPic());
			map.put(ar.getType(), vo);
		}
		return map;
	}
	
	
	/**
	 * 组装图谱结果
	 * @param pfDataList  当前任务所有的图谱结果记录
	 * @param pPfResult   零部件的图谱结果记录
	 * @param mPfResult   原材料的图谱结果记录
	 */
	public void assembleAtlasResult(List<AtlasResult> atDataList, Map<Integer, List<AtlasResult>> pAtlasResult,
			Map<Integer, List<AtlasResult>> mAtlasResult) {

		if (atDataList != null && atDataList.size() > 0) {
			for (AtlasResult at : atDataList) {
				if (at.getCatagory() == 1) { // 零部件
					List<AtlasResult> list = pAtlasResult.get(at.getExpNo());
					if (list != null) {
						list.add(at);
					} else {
						list = new ArrayList<AtlasResult>();
						list.add(at);
					}
					pAtlasResult.put(at.getExpNo(), list);
				} else { // 原材料
					List<AtlasResult> list = mAtlasResult.get(at.getExpNo());
					if (list != null) {
						list.add(at);
					} else {
						list = new ArrayList<AtlasResult>();
						list.add(at);
					}
					mAtlasResult.put(at.getExpNo(), list);
				}
			}
		}
	}
	
	
	/**
	 * 组装对比结果
	 */
	public Map<String, List<ExamineRecord>> assembleCompareResult(Long taskId) {
		Map<String, List<ExamineRecord>> result = new HashMap<String, List<ExamineRecord>>();

		Map<String, Object> erMap = new PageMap(false);
		erMap.put("taskId", taskId);
		erMap.put("type", 4);
		erMap.put("catagorys", 8);
		erMap.put("custom_order_sql", "create_time desc, catagory asc limit 8");
		List<ExamineRecord> erList = examineRecordDao.selectAllList(erMap);

		// 零部件结果
		List<ExamineRecord> pList = new ArrayList<ExamineRecord>();
		// 原材料结果
		List<ExamineRecord> mList = new ArrayList<ExamineRecord>();

		for (ExamineRecord er : erList) {
			if (er.getCatagory() <= 4) {
				pList.add(er);
			} else {
				mList.add(er);
			}
		}

		Collections.sort(pList);
		Collections.sort(mList);
		result.put("零部件", pList);
		result.put("原材料", mList);

		return result;
	}
	
	
	/**
	 * 获取最后一次试验结果
	 * @param type    类型（1-零部件，2-原材料）
	 * @param taskId  任务ID
	 */
	public List<AtlasResult> getLastResult(int type, Long taskId) {
		Map<String, Object> pAtMap = new HashMap<String, Object>();
		pAtMap.put("tId", taskId);
		pAtMap.put("expNo", this.getExpNoByCatagory(taskId, type));
		pAtMap.put("catagory", type);
		return this.selectAllList(pAtMap);
	}
	
	
	/**
	 *  添加日志
	 */
	void addLog(String userName, OperationType operationType, ServiceType serviceType, String logDetail) {
		operationLogService.save(userName, operationType, serviceType, logDetail);
	}
	
}
