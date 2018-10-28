package cn.wow.common.dao;

import java.util.List;
import java.util.Map;
import cn.wow.common.domain.LabConclusion;

public interface LabConclusionDao extends SqlDao{
	
	public void batchAdd(List<LabConclusion> list);
	
	public List<LabConclusion> batchQuery(Map<String, Object> map);

}