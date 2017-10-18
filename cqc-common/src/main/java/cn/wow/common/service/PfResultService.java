package cn.wow.common.service;

import java.util.List;
import java.util.Map;
import cn.wow.common.domain.Account;
import cn.wow.common.domain.PfResult;

public interface PfResultService {
    public PfResult selectOne(Long id);

    public int save(String userName, PfResult pfResult);

    public int update(String userName, PfResult pfResult);

    public int deleteByPrimaryKey(String userName, PfResult pfResult);

    public List<PfResult> selectAllList(Map<String, Object> map);
    
    public void batchAdd(List<PfResult> list);
    
    /**
     * 性能结果上传
     * @param account
     * @param atlasResult
     */
    public void upload(Account account, List<PfResult> dataList, Long taskId);
    
    
    /**
     * 获取试验次数
     * @param taskId    任务ID
     * @param catagory  种类：1-零部件，2-原材料
     */
    public int getExpNoByCatagory(Long taskId, int catagory);

}
