package cn.wow.common.service;

import java.util.List;
import java.util.Map;

import cn.wow.common.domain.Account;
import cn.wow.common.domain.EmailRecord;
import cn.wow.common.domain.Task;

public interface EmailRecordService {
    public EmailRecord selectOne(Long id);

    public int save(String userName, EmailRecord emailRecord);

    public int update(String userName, EmailRecord emailRecord);

    public int deleteByPrimaryKey(String userName, EmailRecord emailRecord);

    public List<EmailRecord> selectAllList(Map<String, Object> map);

    /**
              *   发送邮件
     */
    public void sendEmail(String addr, Task task, Account account);
    
}
