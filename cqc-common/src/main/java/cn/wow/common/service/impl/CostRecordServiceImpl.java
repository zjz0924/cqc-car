package cn.wow.common.service.impl;

import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.dao.CostRecordDao;
import cn.wow.common.domain.CostRecord;
import cn.wow.common.service.CostRecordService;

@Service
@Transactional
public class CostRecordServiceImpl implements CostRecordService{

    private static Logger logger = LoggerFactory.getLogger(CostRecordServiceImpl.class);

    @Autowired
    private CostRecordDao costRecordDao;

    public CostRecord selectOne(Long id){
    	return costRecordDao.selectOne(id);
    }

    public int save(String userName, CostRecord costRecord){
    	return costRecordDao.insert(costRecord);
    }

    public int update(String userName, CostRecord costRecord){
    	return costRecordDao.update(costRecord);
    }

    public int deleteByPrimaryKey(String userName, CostRecord costRecord){
    	return costRecordDao.deleteByPrimaryKey(costRecord.getId());
    }

    public List<CostRecord> selectAllList(Map<String, Object> map){
    	PageHelperExt.startPage(map);
    	return costRecordDao.selectAllList(map);
    }

}
