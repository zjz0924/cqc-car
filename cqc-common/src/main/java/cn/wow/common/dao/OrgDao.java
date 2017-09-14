package cn.wow.common.dao;

import cn.wow.common.domain.Org;

public interface OrgDao extends SqlDao{
    
	public Org getByCode(String code);
	
}