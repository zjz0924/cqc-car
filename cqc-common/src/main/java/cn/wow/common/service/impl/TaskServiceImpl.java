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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.wow.common.dao.AccountDao;
import cn.wow.common.dao.EmailRecordDao;
import cn.wow.common.dao.ExamineRecordDao;
import cn.wow.common.dao.InfoDao;
import cn.wow.common.dao.MaterialDao;
import cn.wow.common.dao.PartsDao;
import cn.wow.common.dao.TaskDao;
import cn.wow.common.dao.TaskRecordDao;
import cn.wow.common.dao.VehicleDao;
import cn.wow.common.domain.Account;
import cn.wow.common.domain.EmailRecord;
import cn.wow.common.domain.ExamineRecord;
import cn.wow.common.domain.Info;
import cn.wow.common.domain.Material;
import cn.wow.common.domain.Parts;
import cn.wow.common.domain.Task;
import cn.wow.common.domain.TaskRecord;
import cn.wow.common.domain.Vehicle;
import cn.wow.common.service.TaskService;
import cn.wow.common.utils.mailSender.MailInfo;
import cn.wow.common.utils.mailSender.MailSender;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.utils.taskState.StandardTaskEnum;
import cn.wow.common.utils.taskState.StandardTaskRecordEnum;

@Service
@Transactional
public class TaskServiceImpl implements TaskService{

    private static Logger logger = LoggerFactory.getLogger(TaskServiceImpl.class);

    // 邮箱账号
 	@Value("${mail.user}")
 	protected String mailUser;
 	// 账号密码
 	@Value("${mail.password}")
 	protected String mailPassword;
 	// 服务器
 	@Value("${mail.smtp.host}")
 	protected String mailHost;
 	// 服务器端口
 	@Value("${mail.smtp.port}")
 	protected String mailPort;
 	// 结果标题
 	@Value("${result.title}")
 	protected String title;
 	// 结果内容
 	@Value("${result.content}")
 	protected String content;
 	
    @Autowired
    private TaskDao taskDao;
    @Autowired
    private AccountDao accountDao;
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

    public Task selectOne(Long id){
    	return taskDao.selectOne(id);
    }

    public int save(String userName, Task task){
    	return taskDao.insert(task);
    }

    public int update(String userName, Task task){
    	return taskDao.update(task);
    }

    public int deleteByPrimaryKey(String userName, Task task){
    	return taskDao.deleteByPrimaryKey(task.getId());
    }

    public List<Task> selectAllList(Map<String, Object> map){
    	PageHelperExt.startPage(map);
    	return taskDao.selectAllList(map);
    }
    
    /**
     * 发送邮件
     * @param subject  主题
     * @param content  内容
     * @param addr     接收人地址（多个邮件地址以";"分隔）
     */
    public boolean sendEmail(String subject, String content, String addr) throws Exception{
    	MailSender mailSender = MailSender.getInstance();
		
		MailInfo info = new MailInfo();
		info.setMailHost(mailHost);
		info.setMailPort(mailPort);
		info.setUsername(mailUser);
		info.setPassword(mailPassword);
		info.setNotifyTo(addr);
		info.setSubject(subject);
		info.setContent(content);
		return mailSender.sendTextMail(info, 3);
    }
    
    /**
	 * 结果发送
	 * @param taskId  任务ID
	 * @param pAtlOrgVal    零部件图谱
	 * @param pPatOrgVal    零部件型式
	 * @param mAtlOrgVal    原材料图谱
	 * @param mPatOrgVal    原材料型式   
	 */
    public void sendResult(Account account, Long taskId, String pAtlOrgVal, String pPatOrgVal, String mAtlOrgVal, String mPatOrgVal) throws Exception{

    	Task task = this.selectOne(taskId);
    	Date date = new Date();
    	String remark = "";
    	
    	if(StringUtils.isNotBlank(pAtlOrgVal)){
    		send(account, task, date, pAtlOrgVal, "零部件图谱试验");
    		task.setPartsAtlResult(3);
    		remark += "零部件图谱试验、";
    	}
    	
    	if(StringUtils.isNotBlank(pPatOrgVal)){
    		send(account, task, date, pPatOrgVal, "零部件型式试验");
    		task.setPartsPatResult(3);
    		remark += "零部件型式试验、";
    	}
    	
    	if(StringUtils.isNotBlank(mAtlOrgVal)){
    		send(account, task, date, mAtlOrgVal, "原材料图谱试验");
    		task.setMatAtlResult(3);
    		remark += "原材料图谱试验、";
    	}
    	
    	if(StringUtils.isNotBlank(mPatOrgVal)){
    		send(account, task, date, mPatOrgVal, "原材料型式试验");
    		task.setMatPatResult(3);
    		remark += "原材料型式试验、";
    	}
    	
    	if(StringUtils.isNotBlank(remark)){
    		remark = remark.substring(0, remark.length() - 1);
    		remark = "发送" + remark + "结果";
    	}
    	
		// 更新任务的结果情况
		taskDao.update(task);
		
		// 任务记录
		TaskRecord taskRecord = new TaskRecord(task.getCode(), account.getId(), StandardTaskRecordEnum.SEND.getState(), remark, date);
		taskRecordDao.insert(taskRecord);
    }
    
    
    /**
   	 * 结果确认
   	 * @param taskId  任务ID
   	 * @param result  结果：1-合格，2-不合格
   	 * @param type    类型：1-零部件图谱试验，2-零部件型式试验，3-原材料图谱试验，4-原材料型式试验，5-全部
   	 */
	public void confirmResult(Account account, Long taskId, int result, int type) {
		Task task = this.selectOne(taskId);
    	boolean isPass = false;
    	String remark = "";
    	Date date = new Date();
    	
    	if(result == 1){
    		if(type == 1){
    			task.setPartsAtlResult(4);
    			remark += "零部件图谱试验、";
    		}else if(type == 2 ){
    			task.setPartsPatResult(4);
    			remark += "零部件型式试验、";
    		}else if(type == 3){
    			task.setMatAtlResult(4);
    			remark += "原材料图谱试验、";
    		}else if(type == 4){
    			task.setMatPatResult(4);
    			remark += "原材料型式试验、";
    		}else{
    			if(task.getMatAtlResult() != 4){
    				task.setMatAtlResult(4);
    			}
    			
    			if(task.getMatPatResult() != 4){
    				task.setMatPatResult(4);
    			}
    			
    			if(task.getPartsAtlResult() != 4){
    				task.setPartsAtlResult(4);
    			}
    			
    			if(task.getPartsPatResult() != 4){
    				task.setPartsPatResult(4);
    			}
    			
    			isPass = true;
    			remark += "零部件图谱试验、零部件型式试验、原材料图谱试验、原材料型式试验、";
    		}
    		
    		if(StringUtils.isNotBlank(remark)){
    			remark = remark.substring(0, remark.length() - 1);
    			remark = remark + "结果确认合格";
    		}
    		
    		// 所有实验已确认
    		if(task.getMatAtlResult() == 4 && task.getMatPatResult() == 4 && task.getPartsAtlResult() == 4 && task.getPartsPatResult() == 4){
    			isPass = true;
    		}
    		
    		if(isPass){
    			task.setState(StandardTaskEnum.NOTIFY.getState());
    			// 保存基准信息
    			saveStandard(account, task);
    		}
    		taskDao.update(task);
    		
    		// 确认记录
    		ExamineRecord examineRecord = new ExamineRecord();
    		examineRecord.setaId(account.getId());
    		examineRecord.setCreateTime(date);
    		examineRecord.setRemark(remark);
    		examineRecord.setState(result);
    		examineRecord.settId(taskId);
    		examineRecord.setType(3);
    		examineRecord.setCatagory(type);
    		examineRecordDao.insert(examineRecord);
    		
    		// 任务记录
    		TaskRecord taskRecord = new TaskRecord(task.getCode(), account.getId(), StandardTaskRecordEnum.CONFIRM.getState(), remark, date);
    		taskRecordDao.insert(taskRecord);
    		
    	}else{
    		
    		if(type == 1){
    			task.setPartsAtlResult(0);
    			task.setPartsAtlId(null);
    			remark += "零部件图谱试验、";
    		}else if(type == 2){
    			task.setPartsPatResult(0);
    			task.setPartsPatId(null);
    			remark += "零部件型式试验、";
    		}else if(type == 3){
    			task.setMatAtlResult(0);
    			task.setMatAtlId(null);
    			remark += "原材料图谱试验、";
    		}else if(type == 4){
    			task.setMatPatResult(0);
    			task.setMatPatId(null);
    			remark += "原材料型式试验、";
    		}else{
    			if(task.getPartsAtlResult() == 3){
    				task.setPartsAtlResult(0);
        			task.setPartsAtlId(null);
        			remark += "零部件图谱试验、";
    			}
    			
    			if(task.getPartsPatResult() == 3){
    				task.setPartsPatResult(0);
        			task.setPartsPatId(null);
        			remark += "零部件型式试验、";
    			}
    			
    			if(task.getMatAtlResult() == 3){
    				task.setMatAtlResult(0);
        			task.setMatAtlId(null);
        			remark += "原材料图谱试验、";
    			}
    			
    			if(task.getMatPatResult() == 3){
    				task.setMatPatResult(0);
        			task.setMatPatId(null);
        			remark += "原材料型式试验、";
    			}
    		}
    		
    		if(StringUtils.isNotBlank(remark)){
    			remark = remark.substring(0, remark.length() - 1);
    			remark = remark + "结果确认不合格";
    		}
    		
    		// 任务记录
    		TaskRecord taskRecord = new TaskRecord(task.getCode(), account.getId(), StandardTaskRecordEnum.CONFIRM.getState(), remark, new Date());
    		taskRecordDao.insert(taskRecord);
    		
    		// 确认记录
    		ExamineRecord examineRecord = new ExamineRecord();
    		examineRecord.setaId(account.getId());
    		examineRecord.setCreateTime(date);
    		examineRecord.setRemark(remark);
    		examineRecord.setState(result);
    		examineRecord.settId(taskId);
    		examineRecord.setType(3);
    		examineRecord.setCatagory(type);
    		examineRecordDao.insert(examineRecord);
    		
    		taskDao.update(task);
    	}
	}
	
	/** 
	 * 基准保存： 修改信息、零部件、原材料、整车信息的状态为已审核
	 */
	public void saveStandard(Account account, Task task) {
		Integer state = 1;
		
		// 信息
		Info info = infoDao.selectOne(task.getiId());
		info.setState(state);
		infoDao.update(info);
		
		// 原材料
		Material material = materialDao.selectOne(info.getmId());
		if(material.getState() == 0){
			material.setState(state);
			materialDao.update(material);
		}
		
		// 整车
		Parts parts = partsDao.selectOne(info.getpId());
		if(parts.getState() == 0){
			parts.setState(state);
			partsDao.update(parts);
		}
				
		// 零部件
		Vehicle vehicle = vehicleDao.selectOne(info.getvId());
		if(vehicle.getState() == 0){
			vehicle.setState(state);
			vehicleDao.update(vehicle);
		}
		
		// 任务记录
		TaskRecord taskRecord = new TaskRecord(task.getCode(), account.getId(), StandardTaskRecordEnum.SAVE.getState(), "基准信息已保存", new Date());
		taskRecordDao.insert(taskRecord);
	}
	

	// 发送邮件
	protected void send(Account account, Task task, Date date, String orgs, String tips) throws Exception{
		// 机构ID
		String[] orgsList = orgs.split(",");
		List<Long> orgIdList = new ArrayList<Long>();
		for (String str : orgsList) {
			if (StringUtils.isNotBlank(str)) {
				orgIdList.add(Long.parseLong(str));
			}
		}

		// 用户列表
		Map<String, Object> aMap = new PageMap(false);
		aMap.put("orgs", orgIdList);
		List<Account> accountList = accountDao.selectAllList(aMap);
		
		if (accountList != null && accountList.size() > 0) {
			String addr = "";
			for (Account ac : accountList) {
				if (StringUtils.isNotBlank(ac.getEmail())) {
					addr += ac.getEmail() + ";";
				}
			}
			
			if(StringUtils.isNotBlank(addr)){
				addr = addr.substring(0, addr.length() - 1);
			}
			
			content = MessageFormat.format(content, new Object[] { task.getCode(), tips });	
			
			// 发送邮件
			sendEmail(title, content, addr);
			
			// 邮件记录
			EmailRecord emailRecord = new EmailRecord(title, content, addr, task.getId(), account.getId(), 1, 1, mailUser, date);
			emailRecordDao.insert(emailRecord);
		}
	}
	
}
