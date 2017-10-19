package cn.wow.common.service;

import java.util.List;
import java.util.Map;

import cn.wow.common.domain.Account;
import cn.wow.common.domain.Task;

public interface TaskService {
    public Task selectOne(Long id);

    public int save(String userName, Task task);

    public int update(String userName, Task task);

    public int deleteByPrimaryKey(String userName, Task task);

    public List<Task> selectAllList(Map<String, Object> map);
    
    /**
     * 发送结果
     * @param account 操作用户
     * @param taskId  任务ID
     * @param orgs    要发送的机构
     * @param type    类型：1-图谱结果，2-型式结果，3-两者
     */
    public void sendResult(Account account, Long taskId, String orgs, int type) throws Exception;
    
    
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
	 * @param type    类型：1-原料图谱结果，2-零部件图谱结果
	 */
    public void confirmResult(Account account, Long taskId, int result, int type);
    
    

}
