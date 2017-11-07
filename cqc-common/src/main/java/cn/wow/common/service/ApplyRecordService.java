package cn.wow.common.service;

import java.util.List;
import java.util.Map;
import cn.wow.common.domain.ApplyRecord;

public interface ApplyRecordService {
    public ApplyRecord selectOne(Long id);

    public int save(String userName, ApplyRecord applyRecord);

    public int update(String userName, ApplyRecord applyRecord);

    public int deleteByPrimaryKey(String userName, ApplyRecord applyRecord);

    public List<ApplyRecord> selectAllList(Map<String, Object> map);
    
    public ApplyRecord getRecordByTaskId(Long taskId, int type);

}
