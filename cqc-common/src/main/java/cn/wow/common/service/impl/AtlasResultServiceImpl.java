package cn.wow.common.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.utils.taskState.StandardTaskEnum;
import cn.wow.common.utils.taskState.StandardTaskRecordEnum;
import cn.wow.common.dao.AtlasResultDao;
import cn.wow.common.dao.TaskDao;
import cn.wow.common.dao.TaskRecordDao;
import cn.wow.common.domain.Account;
import cn.wow.common.domain.AtlasResult;
import cn.wow.common.domain.Task;
import cn.wow.common.domain.TaskRecord;
import cn.wow.common.service.AtlasResultService;

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
			task.setMatAtlResult(2);
			task.setPartsAtlResult(2);
			remark = "上传零部件和原材料图谱试验结果";
		}else{
			if(atlasResult.get(0).getCatagory() == 1){
				task.setPartsAtlResult(2);
				remark = "上传零部件图谱试验结果";
			}else{
				task.setMatAtlResult(2);
				remark = "上传原材料图谱试验结果";
			}
		}

		// 操作记录
		TaskRecord record = new TaskRecord();
		record.setCreateTime(time);
		record.setCode(task.getCode());
		record.setState(StandardTaskRecordEnum.UPLOAD.getState());
		record.setRemark(remark);
		record.setaId(account.getId());
		taskRecordDao.insert(record);

		taskDao.update(task);
	}

}
