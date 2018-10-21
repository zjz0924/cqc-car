package cn.wow.common.service;

import java.util.List;
import java.util.Map;
import cn.wow.common.domain.Reason;

public interface ReasonService {
	
    public Reason selectOne(Long id);

    public int save(String userName, Reason Reason);

    public int update(String userName, Reason Reason);

    public int deleteByPrimaryKey(String userName, Reason Reason);

    public List<Reason> selectAllList(Map<String, Object> map);
    
    public List<Long> selectIds(String origin, String source, String reason);
    
}
