package cn.wow.common.dao;

import java.util.List;
import java.util.Map;

import cn.wow.common.domain.Account;

public interface AccountDao extends SqlDao{
    int deleteByPrimaryKey(Long id);
    
    Account selectByAccountName(String userName);
    
    public void batchAdd(List<Account> list);
	
	public void batchUpdate(List<Account> list);
	
	public void clearPic(Long id);
	
	public void clearOrg(Long id);
	
	/**
	 * 获取下达任务的机构ID
	 */
	public Long getOrderOrgId(Map<String, Object> map);
}