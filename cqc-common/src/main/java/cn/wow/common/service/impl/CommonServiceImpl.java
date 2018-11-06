package cn.wow.common.service.impl;

import java.text.MessageFormat;
import java.text.SimpleDateFormat;
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
import cn.wow.common.domain.Account;
import cn.wow.common.domain.EmailRecord;
import cn.wow.common.domain.Task;
import cn.wow.common.service.CommonService;
import cn.wow.common.utils.mailSender.MailInfo;
import cn.wow.common.utils.mailSender.MailSender;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.utils.taskState.EmailTypeEnum;
import cn.wow.common.utils.taskState.TaskStageEnum;
import cn.wow.common.utils.taskState.TaskTypeEnum;

@Service
@Transactional
public class CommonServiceImpl implements CommonService {

	private static Logger logger = LoggerFactory.getLogger(CommonServiceImpl.class);

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
	// 审核-标题
	@Value("${examine.title}")
	protected String examineTitleTemplate;
	// 审核-内容
	@Value("${examine.content}")
	protected String examineContentTemplate;
	// 下达-标题
	@Value("${transmit.title}")
	protected String transmitTitleTemplate;
	// 下达-内容
	@Value("${transmit.content}")
	protected String transimitContentTemplate;
	// 审批-标题
	@Value("${approve.title}")
	protected String approveTitleTemplate;
	// 审批-内容
	@Value("${approve.content}")
	protected String approveContentTemplate;

	@Autowired
	private EmailRecordDao emailRecordDao;
	@Autowired
	private AccountDao accountDao;

	/**
	 * 邮件通知
	 * 
	 * @param task
	 */
	public void mailNotify(Account account, Task task, TaskStageEnum stage) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");

		try {
			if (task != null && task.getId() != null) {
				String title = null;
				String content = null;
				String addr = null;
				String taskName = null;

				if (stage.getState() == TaskStageEnum.EXAMINE.getState()) {

					if (task.getType() == TaskTypeEnum.OTS.getState()) {
						taskName = "基准任务";
					} else if (task.getType() == TaskTypeEnum.GS.getState()) {
						taskName = "第三方委托试验";
					}

					title = examineTitleTemplate;
					content = MessageFormat.format(examineContentTemplate, new Object[] {
							sdf.format(task.getCreateTime()), taskName, task.getCode(), account.getNickName() });
					addr = getEmailByAccountId(task.getExamineAccountId());

				} else if (stage.getState() == TaskStageEnum.TRANSMIT.getState()) {

					if (task.getType() == TaskTypeEnum.OTS.getState()) {
						taskName = "基准任务";
					} else if (task.getType() == TaskTypeEnum.GS.getState()) {
						taskName = "第三方委托试验";
					}

					title = transmitTitleTemplate;
					content = MessageFormat.format(transimitContentTemplate, new Object[] {
							sdf.format(task.getCreateTime()), taskName, task.getCode(), account.getNickName() });
					addr = getEmailByAccountId(task.getTrainsmitAccountId());

				} else if (stage.getState() == TaskStageEnum.APPROVE.getState()) {

					if (task.getType() == TaskTypeEnum.OTS.getState()) {
						taskName = "基准任务";
					} else if (task.getType() == TaskTypeEnum.GS.getState()) {
						taskName = "第三方委托试验";
					} else if (task.getType() == TaskTypeEnum.PPAP.getState()) {
						taskName = "图谱试验抽查-开发阶段";
					} else {
						taskName = "图谱试验抽查-量产阶段";
					}

					title = approveTitleTemplate;
					content = MessageFormat.format(approveContentTemplate, new Object[] {
							sdf.format(task.getCreateTime()), taskName, task.getCode(), account.getNickName() });
					addr = getEmailByAccountId(task.getTrainsmitAccountId());
				}

				if (StringUtils.isNotBlank(addr)) {
					EmailRecord emailRecord = new EmailRecord(title, content, addr, task.getId(), account.getId(),
							EmailTypeEnum.RESULT, mailUser, date);
					emailRecordDao.insert(emailRecord);

					this.sendEmail(title, content, addr, null, 2);
				}

			} else {
				logger.error("系统错误：发送邮件失败，任务为空或者任务ID为空");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("系统错误：发送邮件失败，任务号：" + task != null ? task.getCode() : "" + "，任务阶段：" + stage.getMsg());
		}
	}

	/**
	 * 发送邮件
	 * 
	 * @param subject  主题
	 * @param content  内容
	 * @param notifyTo 接收人地址（多个邮件地址以";"分隔）
	 * @param notifyCC 抄送人地址（多个邮件地址以";"分隔）
	 * @param type     类型：1-text 2-html
	 */
	public boolean sendEmail(String subject, String content, String notifyTo, String notifyCc, int type)
			throws Exception {
		MailSender mailSender = MailSender.getInstance();

		MailInfo info = new MailInfo();
		info.setMailHost(mailHost);
		info.setMailPort(mailPort);
		info.setUsername(mailUser);
		info.setPassword(mailPassword);

		info.setSubject(subject);
		info.setContent(content);

		if (StringUtils.isNotBlank(notifyTo) || StringUtils.isNotBlank(notifyCc)) {

			if (StringUtils.isNotBlank(notifyTo)) {
				info.setNotifyTo(notifyTo);
			}

			if (StringUtils.isNotBlank(notifyCc)) {
				info.setNotifyCc(notifyCc);
			}

			if (type == 1) {
				return mailSender.sendTextMail(info, 3);
			} else {
				return mailSender.sendHtmlMail(info, 3);
			}

		} else {
			return false;
		}

	}

	/**
	 * 获取用户列表
	 * 
	 * @param orgs 机构ID
	 */
	public List<Account> getAccountList(String orgs) {
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

		return accountList;
	}

	/**
	 * 根据用户ID获取用户email
	 * 
	 * @param accountId
	 * @return
	 */
	private String getEmailByAccountId(Long accountId) {
		if (accountId != null) {
			Account account = accountDao.selectOne(accountId);

			if (account != null && StringUtils.isNotBlank(account.getEmail())) {
				return account.getEmail();
			} else {
				return null;
			}

		} else {
			return null;
		}
	}

}
