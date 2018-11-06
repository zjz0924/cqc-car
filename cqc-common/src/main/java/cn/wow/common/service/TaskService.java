package cn.wow.common.service;

import java.util.List;
import java.util.Map;

import cn.wow.common.domain.Account;
import cn.wow.common.domain.CostRecord;
import cn.wow.common.domain.ExamineRecord;
import cn.wow.common.domain.ExpItem;
import cn.wow.common.domain.Task;

public interface TaskService {
    public Task selectOne(Long id);

    public int save(String userName, Task task);

    public int update(String userName, Task task);

    public int deleteByPrimaryKey(String userName, Task task);

    public List<Task> selectAllList(Map<String, Object> map);
    
    /**
	 * 结果发送
	 * @param taskId  任务ID
	 * @param pAtlVal    零部件图谱
	 * @param pPatVal    零部件型式
	 * @param mAtlVal    原材料图谱
	 * @param mPatVal    原材料型式   
	 * @param type          类型：1-发送结果， 2-不发送，直接跳过 
	 */
    public void sendResult(Account account, Long taskId, String pAtlVal, String pPatVal, String mAtlVal, String mPatVal, Integer type) throws Exception;
    
    /**
	 * 结果确认
	 * @param result  结果：1-合格，2-不合格
	 * @param type    类型：1-零部件图谱试验，2-零部件型式试验，3-原材料图谱试验，4-原材料型式试验，5-全部
	 * @param remark  不合格的理由
	 * @param orgs    发送警告书的机构
	 */
    public void confirmResult(Account account, Long[] ids, int result, int type, String remark, String orgs) throws Exception;
    
    
    /**
   	 * PPAP任务第二次确认
   	 * @param taskId  任务ID
   	 * @param result  结果：1-第二次抽样，2-中止任务
   	 * @param remark  不合格的理由
   	 */
     public void confirmResult(Account account, Long taskId, int result, String remark);
    
    
    
    /**
	 * 结果对比
	 * @param taskId  任务ID
	 * @param examineRecordList  对比结果
	 * @param state   状态：1-正常，2-异常
	 * @param result  任务结果：1-合格，2-不合格
	 */
    public void compareResult(Account account, Long taskId, List<ExamineRecord> examineRecordList, int state, int result);
    

    /**
     * 获取info id 批量查询任务
     * @param list
     */
    public List<Task> batchQueryByInfoId(List<Long> list);
    
    
    /**
     *  获取子任务的数量
     * @param taskId
     */
    public int getSubTaskNum(Long taskId);
    
    
    /**
     * 获取最上级的父任务
     * @param taskId
     */
    public Task getRootTask(Long taskId);
    
    /**
	 * 获取任务数
	 */
	public Integer getTaskNum(Map<String, Object> map);
	
	
	/**
	 * 查询基准任务
	 * @code  任务号
	 */
	public Task getStandardTask(String code);
	
	
	/**
	 * 获取待办任务
	 */
	public List<Task> getBacklogTask(Map<String, Object> map);
	
}
