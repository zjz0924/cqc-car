package cn.wow.common.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.wow.common.domain.Account;
import cn.wow.common.domain.AtlasResult;

public interface AtlasResultService {
    public AtlasResult selectOne(Long id);

    public int save(String userName, AtlasResult atlasResult);

    public int update(String userName, AtlasResult atlasResult);

    public int deleteByPrimaryKey(String userName, AtlasResult atlasResult);

    public List<AtlasResult> selectAllList(Map<String, Object> map);
    
    public void batchAdd(List<AtlasResult> list);
    
    /**
     * 图谱结果上传
     * @param account
     * @param atlasResult
     */
    public void upload(Account account, List<AtlasResult> atlasResult, Long taskId, Date time);

}
