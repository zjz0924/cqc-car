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
import cn.wow.common.dao.PfResultDao;
import cn.wow.common.dao.TaskDao;
import cn.wow.common.dao.TaskRecordDao;
import cn.wow.common.domain.Account;
import cn.wow.common.domain.PfResult;
import cn.wow.common.domain.Task;
import cn.wow.common.domain.TaskRecord;
import cn.wow.common.service.PfResultService;

@Service
@Transactional
public class PfResultServiceImpl implements PfResultService{

    private static Logger logger = LoggerFactory.getLogger(PfResultServiceImpl.class);

    @Autowired
    private PfResultDao pfResultDao;
    @Autowired
    private TaskDao taskDao;
    @Autowired
    private TaskRecordDao taskRecordDao;

    public PfResult selectOne(Long id){
    	return pfResultDao.selectOne(id);
    }

    public int save(String userName, PfResult pfResult){
    	return pfResultDao.insert(pfResult);
    }

    public int update(String userName, PfResult pfResult){
    	return pfResultDao.update(pfResult);
    }

    public int deleteByPrimaryKey(String userName, PfResult pfResult){
    	return pfResultDao.deleteByPrimaryKey(pfResult.getId());
    }

    public List<PfResult> selectAllList(Map<String, Object> map){
    	PageHelperExt.startPage(map);
    	return pfResultDao.selectAllList(map);
    }
    
    // 获取试验次数
    public int getExpNoByCatagory(Long taskId, int catagory){
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("taskId", taskId);
    	map.put("catagory", catagory);
    	return pfResultDao.getExpNoByCatagory(map);
    }
    
    public void batchAdd(List<PfResult> list){
    	pfResultDao.batchAdd(list);
    }
    
    //性能结果上传
    public void upload(Account account, List<PfResult> dataList, Long taskId){
    	Task task = taskDao.selectOne(taskId);

		// 批量添加
    	batchAdd(dataList);

		// 操作记录
		TaskRecord record = new TaskRecord();
		record.setCreateTime(dataList.get(0).getCreateTime());
		record.setCode(task.getCode());
		record.setState(StandardTaskRecordEnum.UPLOAD_PATTERN.getState());
		record.setaId(account.getId());
		taskRecordDao.insert(record);

		task.setPatternResult(1);
		taskDao.update(task);
    }

}
