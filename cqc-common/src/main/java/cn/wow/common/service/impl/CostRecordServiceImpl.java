package cn.wow.common.service.impl;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.wow.common.dao.AccountDao;
import cn.wow.common.dao.CostRecordDao;
import cn.wow.common.dao.ExpItemDao;
import cn.wow.common.domain.Account;
import cn.wow.common.domain.CostRecord;
import cn.wow.common.domain.EmailRecord;
import cn.wow.common.domain.ExpItem;
import cn.wow.common.service.CostRecordService;
import cn.wow.common.service.TaskService;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.utils.pagination.PageMap;

@Service
@Transactional
public class CostRecordServiceImpl implements CostRecordService{

    private static Logger logger = LoggerFactory.getLogger(CostRecordServiceImpl.class);

    @Autowired
    private CostRecordDao costRecordDao;
    @Autowired
    private ExpItemDao expItemDao;
    @Autowired
    private AccountDao accountDao;
    @Autowired
    private TaskService taskService;

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
    
    
    /**
     * 费用清单发送
     * @param account  
     * @param costId   清单ID
     * @param orgs	        发送机构
     * @param list     试验项目
     */
	public void costSend(Account account, Long costId, String orgs, List<ExpItem> itemList) throws Exception{
		// 添加试验项目
		expItemDao.batchAdd(itemList);
		Date date = new Date();
		
		// 修改清单信息
		CostRecord costRecord = costRecordDao.selectOne(costId);
		costRecord.setaId(account.getId());
		costRecord.setOrgs(orgs);
		costRecord.setSendTime(date);
		costRecord.setState(1);
		costRecordDao.update(costRecord);
		
		// 发送邮件
		taskService.sendCost(account, orgs, costRecord, itemList);
	}

}
