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
import cn.wow.common.dao.InfoDao;
import cn.wow.common.dao.MaterialDao;
import cn.wow.common.dao.PartsDao;
import cn.wow.common.dao.TaskDao;
import cn.wow.common.dao.TaskRecordDao;
import cn.wow.common.dao.VehicleDao;
import cn.wow.common.domain.Account;
import cn.wow.common.domain.EmailRecord;
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
 	// 图谱结果
 	@Value("${result.atlas}")
 	protected String atlasResult;
 	// 型式结果
 	@Value("${result.patern}")
 	protected String paternResult;
 	// 两种结果
 	@Value("${result.both}")
 	protected String bothResult;
 	
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
     * 发送结果
     * @param account 操作用户
     * @param taskId  任务ID
     * @param orgs    要发送的机构
     * @param type    类型：1-图谱结果，2-型式结果，3-两者
     * @throws Exception 
     */
    public void sendResult(Account account, Long taskId, String orgs, int type) throws Exception{
    	Task task = this.selectOne(taskId);
    	Date date = new Date();
    	
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
			
			String content = null;
			if(type == 1){
				content = MessageFormat.format(atlasResult, new Object[] { task.getCode() });		
			}else if(type == 2){
				content = MessageFormat.format(paternResult, new Object[] { task.getCode() });		
			}else{
				content = MessageFormat.format(bothResult, new Object[] { task.getCode() });		
			}
			
			// 发送邮件
			sendEmail(title, content, addr);
			
			// 邮件记录
			EmailRecord emailRecord = new EmailRecord(title, content, addr, taskId, account.getId(), 1, 1, mailUser, date);
			emailRecordDao.insert(emailRecord);
		}
		
		// 更新任务的结果情况
		String remark = "";
		if(type == 1){
			task.setAtlasResult(2);
			
			// 检查型式结果是否已发送
			if(task.getPatternResult().intValue() == 2){
				task.setState(StandardTaskEnum.CONFIRM.getState());
			}
			remark = "发送图谱试验结果";
		}else if(type == 2){
			task.setPatternResult(2);
			
			// 检查图谱结果是否已发送
			if(task.getAtlasResult().intValue() == 2){
				task.setState(StandardTaskEnum.CONFIRM.getState());
			}
			remark = "发送型式试验结果";
		}else{
			task.setAtlasResult(2);
			task.setPatternResult(2);
			task.setState(StandardTaskEnum.CONFIRM.getState());
			remark = "发送图谱和型式试验结果";
		}
		taskDao.update(task);
		
		// 任务记录
		TaskRecord taskRecord = new TaskRecord(task.getCode(), account.getId(), StandardTaskRecordEnum.SEND.getState(), remark, date);
		taskRecordDao.insert(taskRecord);
    }
    
    
    /**
   	 * 结果确认
   	 * @param taskId  任务ID
   	 * @param result  结果：1-合格，2-不合格
   	 * @param type    类型：1-原料图谱结果，2-零部件图谱结果
   	 */
	public void confirmResult(Account account, Long taskId, int result, int type) {
		Task task = this.selectOne(taskId);
    	
    	if(result == 1){
    		// 两项试验结果
        	boolean isPass = false;
    		String remark = "";
    		
    		if(type == 1){
    			task.setMaterialResult(1);
    			
    			if(task.getPartsResult().intValue() == 1){
    				isPass = true;
    			}
    			remark = "原料图谱结果确认合格";
    		}else{
    			task.setPartsResult(1);
    			
    			if(task.getMaterialResult().intValue() == 1){
    				isPass = true;
    			}
    			remark = "零部件图谱结果结果确认合格";
    		}
    		
    		// 任务记录
    		TaskRecord taskRecord = new TaskRecord(task.getCode(), account.getId(), StandardTaskRecordEnum.CONFIRM.getState(), remark, new Date());
    		taskRecordDao.insert(taskRecord);
    		
    		// 合格
    		if(isPass){
    			task.setState(StandardTaskEnum.NOTIFY.getState());
    			// 保存基准信息
    			saveStandard(account, task);
    		}
    		
    		taskDao.update(task);
    	}else{
    		
    		// 两项试验结果
        	boolean isNotPass = false;
    		String remark = "";
    		
    		if(type == 1){
    			task.setMaterialResult(2);
    			
    			// 结果已确认
    			if(task.getPartsResult().intValue() != 0){
    				isNotPass = true;
    			}
    			remark = "原料图谱结果确认不合格";
    		}else{
    			task.setPartsResult(2);
    			
    			// 结果已确认
    			if(task.getMaterialResult().intValue() != 0){
    				isNotPass = true;
    			}
    			remark = "零部件图谱结果结果确认不合格";
    		}
    		
    		// 任务记录
    		TaskRecord taskRecord = new TaskRecord(task.getCode(), account.getId(), StandardTaskRecordEnum.CONFIRM.getState(), remark, new Date());
    		taskRecordDao.insert(taskRecord);
    		
    		// 不合格
    		if(isNotPass){
    			task.setState(StandardTaskEnum.TRANSMIT.getState());
    			task.setFailNum(task.getFailNum() + 1);
    			
    			// 重新再上传
    			task.setAtlasResult(0);
    			task.setPatternResult(0);
    			task.setMaterialResult(0);
    			task.setPartsResult(0);
    		}
    		
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
		material.setState(state);
		materialDao.update(material);
		
		// 整车
		Parts parts = partsDao.selectOne(info.getpId());
		parts.setState(state);
		partsDao.update(parts);
				
		// 零部件
		Vehicle vehicle = vehicleDao.selectOne(info.getvId());
		vehicle.setState(state);
		vehicleDao.update(vehicle);
		
		// 任务记录
		TaskRecord taskRecord = new TaskRecord(task.getCode(), account.getId(), StandardTaskRecordEnum.SAVE.getState(), "基准信息已保存", new Date());
		taskRecordDao.insert(taskRecord);
	}

}
