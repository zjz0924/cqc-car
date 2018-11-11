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

import cn.wow.common.dao.CostRecordDao;
import cn.wow.common.dao.EmailRecordDao;
import cn.wow.common.dao.ExpItemDao;
import cn.wow.common.domain.Account;
import cn.wow.common.domain.CostRecord;
import cn.wow.common.domain.EmailRecord;
import cn.wow.common.domain.ExpItem;
import cn.wow.common.service.CommonService;
import cn.wow.common.service.CostRecordService;
import cn.wow.common.service.OperationLogService;
import cn.wow.common.utils.operationlog.OperationType;
import cn.wow.common.utils.operationlog.ServiceType;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.utils.taskState.EmailTypeEnum;

@Service
@Transactional
public class CostRecordServiceImpl implements CostRecordService {

	private static Logger logger = LoggerFactory.getLogger(CostRecordServiceImpl.class);

	// 邮箱账号
	@Value("${mail.user}")
	protected String mailUser;
	// 费用清单标题
	@Value("${cost.title}")
	protected String costTitle;
	// 费用清单内容
	@Value("${cost.content}")
	protected String costContent;

	@Autowired
	private CostRecordDao costRecordDao;
	@Autowired
	private ExpItemDao expItemDao;
	@Autowired
	private OperationLogService operationLogService;
	@Autowired
	private EmailRecordDao emailRecordDao;
	@Autowired
	private CommonService commonService;

	public CostRecord selectOne(Long id) {
		return costRecordDao.selectOne(id);
	}

	public int save(String userName, CostRecord costRecord) {
		return costRecordDao.insert(costRecord);
	}

	public int update(String userName, CostRecord costRecord) {
		return costRecordDao.update(costRecord);
	}

	public int deleteByPrimaryKey(String userName, CostRecord costRecord) {
		return costRecordDao.deleteByPrimaryKey(costRecord.getId());
	}

	public List<CostRecord> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return costRecordDao.selectAllList(map);
	}

	/**
	 * 费用清单发送
	 * 
	 * @param account
	 * @param costId  清单ID
	 * @param orgs    发送机构
	 * @param list    试验项目
	 */
	public void costSend(Account account, Long costId, String orgs, List<ExpItem> itemList) throws Exception {
		// 添加试验项目
		expItemDao.batchAdd(itemList);
		Date date = new Date();

		Double total = 0d;
		if (itemList != null && itemList.size() > 0) {
			for (ExpItem item : itemList) {
				total += item.getTotal();
			}
		}

		// 修改清单信息
		CostRecord costRecord = costRecordDao.selectOne(costId);
		costRecord.setaId(account.getId());
		costRecord.setOrgs(orgs);
		costRecord.setSendTime(date);
		costRecord.setState(1);
		costRecord.setTotal(total);
		costRecordDao.update(costRecord);

		// 发送邮件
		this.sendCostEmail(account, orgs, costRecord, itemList);

		// 操作日志
		String lab = "";
		if (costRecord.getLabType() == 1) {
			lab = "零件图谱试验费用单";
		} else if (costRecord.getLabType() == 2) {
			lab = "零件型式试验费用单";
		} else if (costRecord.getLabType() == 3) {
			lab = "材料图谱试验费用单";
		} else {
			lab = "材料型式试验费用单";
		}
		String logDetail = "任务：" + costRecord.getTask().getCode() + "," + lab;
		addLog(account.getUserName(), OperationType.SEND_COST, ServiceType.COST, logDetail);
	}

	/**
	 * 添加日志
	 */
	void addLog(String userName, OperationType operationType, ServiceType serviceType, String logDetail) {
		operationLogService.save(userName, operationType, serviceType, logDetail);
	}

	/**
	 * 发送费用清单
	 * 
	 * @param account    操作用户
	 * @param costRecord 费用清单
	 * @param orgs       发送机构
	 */
	private void sendCostEmail(Account account, String orgs, CostRecord costRecord, List<ExpItem> itemList)
			throws Exception {
		Date date = new Date();
		List<Account> accountList = commonService.getAccountList(orgs);

		if (accountList != null && accountList.size() > 0) {

			String labType = "";
			if (costRecord.getLabType() == 1) {
				labType = "零件图谱试验";
			} else if (costRecord.getLabType() == 2) {
				labType = "零件型式试验";
			} else if (costRecord.getLabType() == 3) {
				labType = "材料图谱试验";
			} else {
				labType = "材料型式试验";
			}
			costContent = MessageFormat.format(costContent, new Object[] { costRecord.getTask().getCode(), labType });

			// 费用列表
			StringBuffer tempContent = new StringBuffer(
					"<div><table style='margin-left: 5px;font-size: 14px;'><tr style='height: 30px'><td style='width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;'>序号</td><td style='width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;'>试验项目</td><td style='width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;'>参考标准</td><td style='width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;'>单价（元）</td><td style='width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;'>数量</td><td style='width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;'>总价（元）</td><td style='width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;'>备注</td></tr>");
			if (itemList != null && itemList.size() > 0) {
				for (int i = 0; i < itemList.size(); i++) {
					ExpItem item = itemList.get(i);
					tempContent.append("<tr style='height: 30px'><td style='background: #f5f5f5;padding-left: 5px;'>"
							+ (i + 1) + "</td><td style='background: #f5f5f5;padding-left: 5px;'>" + item.getProject()
							+ "</td><td style='background: #f5f5f5;padding-left: 5px;'>" + item.getStandard()
							+ "</td><td style='background: #f5f5f5;padding-left: 5px;'>" + item.getPrice()
							+ "</td><td style='background: #f5f5f5;padding-left: 5px;'>" + item.getNum()
							+ "</td><td style='background: #f5f5f5;padding-left: 5px;'>" + item.getTotal()
							+ "</td><td style='background: #f5f5f5;padding-left: 5px;'>" + item.getRemark()
							+ "</td></tr>");
				}
			}
			tempContent.append("</table></div>");

			StringBuffer addrs = new StringBuffer("");
			List<EmailRecord> emailRecordList = new ArrayList<EmailRecord>();

			for (Account ac : accountList) {
				if (StringUtils.isNotBlank(ac.getEmail())) {
					addrs.append(ac.getEmail() + ";");

					// 邮件记录
					EmailRecord emailRecord = new EmailRecord(costTitle, costContent + tempContent.toString(),
							ac.getEmail(), costRecord.getTask().getId(), account.getId(), EmailTypeEnum.COST, mailUser,
							date);
					emailRecordList.add(emailRecord);
				}
			}

			// 邮件记录
			if (emailRecordList.size() > 0) {
				emailRecordDao.batchAdd(emailRecordList);
			}

			// 发送Html邮件
			commonService.sendEmail(costTitle, costContent + tempContent.toString(), addrs.toString(), null, 2);
		}
	}
}
