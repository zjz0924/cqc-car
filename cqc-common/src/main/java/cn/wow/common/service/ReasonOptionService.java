package cn.wow.common.service;

import java.util.List;
import java.util.Map;
import cn.wow.common.domain.ReasonOption;

public interface ReasonOptionService {
	
    public ReasonOption selectOne(Long id);

    public int save(String userName, ReasonOption ReasonOption);

    public int update(String userName, ReasonOption ReasonOption);

    public int deleteByPrimaryKey(String userName, ReasonOption ReasonOption);

    public List<ReasonOption> selectAllList(Map<String, Object> map);
    
    public ReasonOption selectByName(Map<String, Object> map);
    
}
