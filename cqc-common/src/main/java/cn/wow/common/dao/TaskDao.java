package cn.wow.common.dao;

import java.util.Map;

public interface TaskDao extends SqlDao{
   
	public void updateState(Map<String, Object> map);
}