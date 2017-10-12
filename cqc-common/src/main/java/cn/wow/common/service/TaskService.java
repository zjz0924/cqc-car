package cn.wow.common.service;

import java.util.List;
import java.util.Map;
import cn.wow.common.domain.Task;

public interface TaskService {
    public Task selectOne(Long id);

    public int save(String userName, Task task);

    public int update(String userName, Task task);

    public int deleteByPrimaryKey(String userName, Task task);

    public List<Task> selectAllList(Map<String, Object> map);

}
