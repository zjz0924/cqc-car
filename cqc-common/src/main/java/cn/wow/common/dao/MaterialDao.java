package cn.wow.common.dao;

import java.util.List;
import java.util.Map;

import cn.wow.common.domain.Material;

public interface MaterialDao extends SqlDao{
    
	Material selectByCode(String code);
	
	/**
	 * 获取生产商名称列表
	 */
	public List<String> getProduceList(String name);
}