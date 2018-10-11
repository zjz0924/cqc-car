package cn.wow.common.dao;

import java.util.List;

import cn.wow.common.domain.Parts;

public interface PartsDao extends SqlDao{

    Parts selectByCode(String code);
    
    /**
	 * 获取生产商名称列表
	 */
	public List<String> getProduceList(String name);
}