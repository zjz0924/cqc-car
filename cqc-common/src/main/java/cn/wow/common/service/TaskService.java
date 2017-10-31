package cn.wow.common.service;

import java.util.List;
import java.util.Map;

import cn.wow.common.domain.Account;
import cn.wow.common.domain.ExamineRecord;
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
	 * @param pAtlOrgVal    零部件图谱
	 * @param pPatOrgVal    零部件型式
	 * @param mAtlOrgVal    原材料图谱
	 * @param mPatOrgVal    原材料型式   
	 */
    public void sendResult(Account account, Long taskId, String pAtlOrgVal, String pPatOrgVal, String mAtlOrgVal, String mPatOrgVal) throws Exception;
    
    
    /**
     * 发送邮件
     * @param subject  主题
     * @param content  内容
     * @param addr     接收人地址（多个邮件地址以";"分隔）
     */
    public boolean sendEmail(String subject, String content, String addr) throws Exception;
    
    
    
    /**
	 * 结果确认
	 * @param taskId  任务ID
	 * @param result  结果：1-合格，2-不合格
	 * @param type    类型：1-零部件图谱试验，2-零部件型式试验，3-原材料图谱试验，4-原材料型式试验，5-全部
	 */
    public void confirmResult(Account account, Long taskId, int result, int type);
    
    /**
	 * 结果对比
	 * @param taskId  任务ID
	 * @param result  对比结果
	 * @param state   状态：1-正常，2-异常
	 */
    public void compareResult(Account account, Long taskId, List<ExamineRecord> result, int state);
    

}
