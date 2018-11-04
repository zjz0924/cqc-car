package cn.wow.common.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.wow.common.dao.AccountDao;
import cn.wow.common.domain.Account;
import cn.wow.common.domain.Reason;
import cn.wow.common.service.AccountService;
import cn.wow.common.utils.cookie.MD5;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.utils.pagination.PageMap;

@Service
@Transactional
public class AccountServiceImpl implements AccountService {

	private static Logger logger = LoggerFactory.getLogger(AccountServiceImpl.class);

	@Autowired
	private AccountDao accountDao;

	public Account selectOne(Long id) {
		return accountDao.selectOne(id);
	}

	public int save(String userName, Account account) {
		return accountDao.insert(account);
	}

	public int update(String userName, Account account) {
		return accountDao.update(account);
	}

	public int deleteByPrimaryKey(String userName, Account account) {
		return accountDao.deleteByPrimaryKey(account.getId());
	}

	public Account selectByAccountName(String userName) {
		return accountDao.selectByAccountName(userName);
	}

	public List<Account> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return accountDao.selectAllList(map);
	}

	public void batchAdd(List<Account> list) {
		accountDao.batchAdd(list);
	}

	public void batchUpdate(List<Account> list) {
		accountDao.batchUpdate(list);
	}

	public void clearPic(Long id) {
		accountDao.clearPic(id);
	}

	/**
	 * 获取下达任务的机构ID
	 * 
	 * @param taskId 任务ID
	 * @param state  任务记录状态
	 */
	public List<Account> getOperationUser(Long taskId, Integer state) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("taskId", taskId);
		map.put("state", state);
		return accountDao.getOperationUser(map);
	}

	/**
	 * 批量删除
	 */
	public void batchDelete(String userName, Long[] ids) {
		if (ids != null && ids.length > 0) {
			for (Long id : ids) {
				Account account = accountDao.selectOne(id);
				if (account != null) {
					this.deleteByPrimaryKey(userName, account);
				}
			}
		}
	}

	/**
	 * 批量重置密码
	 */
	public void batchResetPwd(String userName, Long[] ids, String defaultPwd) {
		if (ids != null && ids.length > 0) {
			for (Long id : ids) {
				Account account = this.selectOne(id);
				account.setPassword(MD5.getMD5(defaultPwd, "utf-8").toUpperCase());
				this.update(userName, account);
			}
		}
	}

	public List<Long> selectIds(String name, String department, Long orgId) {
		List<Long> idList = new ArrayList<Long>();

		Map<String, Object> map = new PageMap(false);

		if (StringUtils.isNotBlank(name)) {
			map.put("nickName", name);
		}
		if (StringUtils.isNotBlank(department)) {
			map.put("department", department);
		}
		if (orgId != null) {
			map.put("orgId", orgId);
		}

		if (map.size() > 3) {
			List<Account> dataList = this.selectAllList(map);
			if (dataList != null && dataList.size() > 0) {
				for (Account obj : dataList) {
					idList.add(obj.getId());
				}
			} else {
				idList.add(-1l);
			}
		}

		return idList;
	}

}
