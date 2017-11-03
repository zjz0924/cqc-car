package cn.wow.common.service;

import java.util.List;
import java.util.Map;
import cn.wow.common.domain.CostRecord;

public interface CostRecordService {
    public CostRecord selectOne(Long id);

    public int save(String userName, CostRecord costRecord);

    public int update(String userName, CostRecord costRecord);

    public int deleteByPrimaryKey(String userName, CostRecord costRecord);

    public List<CostRecord> selectAllList(Map<String, Object> map);

}
