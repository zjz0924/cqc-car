package cn.wow.common.service.impl;

import java.util.Date;
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
    
    
	// 结果上传
	public void upload(Account account, List<AtlasResult> atlasResult, Long taskId, Date time) {
		Task task = taskDao.selectOne(taskId);

		// 批量添加
		batchAdd(atlasResult);

		// 操作记录
		TaskRecord record = new TaskRecord();
		record.setCreateTime(time);
		record.setCode(task.getCode());
		record.setState(StandardTaskRecordEnum.UPLOAD_ATLAS.getState());
		record.setaId(account.getId());
		taskRecordDao.insert(record);

		// 检查型式结果是否已经上传，如果已上传，修改任务状态
		if (task.getPatternResult().intValue() > 0) {
			task.setState(StandardTaskEnum.SENDING.getState());
		}

		task.setAtlasResult(1);
		taskDao.update(task);
	}

}
