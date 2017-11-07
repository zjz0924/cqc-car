package cn.wow.common.service.impl;

import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.dao.ApplyRecordDao;
import cn.wow.common.domain.ApplyRecord;
import cn.wow.common.service.ApplyRecordService;

@Service
@Transactional
public class ApplyRecordServiceImpl implements ApplyRecordService{

    private static Logger logger = LoggerFactory.getLogger(ApplyRecordServiceImpl.class);

    @Autowired
    private ApplyRecordDao applyRecordDao;

    public ApplyRecord selectOne(Long id){
    	return applyRecordDao.selectOne(id);
    }

    public int save(String userName, ApplyRecord applyRecord){
    	return applyRecordDao.insert(applyRecord);
    }

    public int update(String userName, ApplyRecord applyRecord){
    	return applyRecordDao.update(applyRecord);
    }

    public int deleteByPrimaryKey(String userName, ApplyRecord applyRecord){
    	return applyRecordDao.deleteByPrimaryKey(applyRecord.getId());
    }

    public List<ApplyRecord> selectAllList(Map<String, Object> map){
    	PageHelperExt.startPage(map);
    	return applyRecordDao.selectAllList(map);
    }

	public ApplyRecord getRecordByTaskId(Long taskId, int type) {
		Map<String, Object> tMap = new PageMap(false);
		tMap.put("taskId", taskId);
		tMap.put("type", type);

		List<ApplyRecord> list = applyRecordDao.getRecordByTaskId(tMap);

		if (list != null && list.size() > 0) {
			return list.get(0);
		} else {
			return null;
		}
	}
}
