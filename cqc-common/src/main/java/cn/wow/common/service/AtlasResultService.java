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
    
    /**
     * 获取试验次数
     * @param taskId    任务ID
     * @param catagory  种类：1-零部件，2-原材料
     */
    public int getExpNoByCatagory(Long taskId, int catagory);
    
    /**
     * 获取零部件基准图谱结果
     * @param id   零部件ID
     */
    public List<AtlasResult> getStandardPartsAtlResult(Long id);
	
    
    /**
     * 获取原材料基准图谱结果
     * @param id   原材料ID
     */
	public List<AtlasResult> getStandardMatAtlResult(Long id);

}
