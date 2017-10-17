package cn.wow.common.dao;

import java.util.List;

import cn.wow.common.domain.AtlasResult;

public interface AtlasResultDao extends SqlDao{
	
	public void batchAdd(List<AtlasResult> list);
}