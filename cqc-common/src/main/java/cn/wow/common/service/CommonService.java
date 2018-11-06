package cn.wow.common.service;

import java.util.List;

import cn.wow.common.domain.Account;
import cn.wow.common.domain.Task;
import cn.wow.common.utils.taskState.TaskStageEnum;

public interface CommonService {

	/**
	 * 邮件通知
	 */
	public void mailNotify(Account account, Task task, TaskStageEnum stage);

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
			throws Exception;

	
	/**
	 * 获取用户列表
	 * @param orgs 机构ID
	 */
	public List<Account> getAccountList(String orgs);
}
