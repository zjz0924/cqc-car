package cn.wow.common.dao;

import java.util.List;
import java.util.Map;

import cn.wow.common.domain.AtlasResult;

public interface AtlasResultDao extends SqlDao{
	
	public void batchAdd(List<AtlasResult> list);
	
	public int getExpNoByCatagory(Map<String, Object> map);
}