package cn.wow.common.dao;

import java.util.List;
import java.util.Map;

import cn.wow.common.domain.Org;
import cn.wow.common.domain.ReceiveOrg;

public interface OrgDao extends SqlDao{
    
	public Org getByCode(String code);
	
	public void batchUpdate(Map<String, Object> map);
	
	// 获取接收机构名称
	public List<ReceiveOrg> getReciveOrgName(Map<String, Object> map);
	
}