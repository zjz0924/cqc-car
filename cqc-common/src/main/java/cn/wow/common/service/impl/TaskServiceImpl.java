package cn.wow.common.service.impl;

import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.dao.TaskDao;
import cn.wow.common.domain.Task;
import cn.wow.common.service.TaskService;

@Service
@Transactional
public class TaskServiceImpl implements TaskService{

    private static Logger logger = LoggerFactory.getLogger(TaskServiceImpl.class);

    @Autowired
    private TaskDao taskDao;

    public Task selectOne(Long id){
    	return taskDao.selectOne(id);
    }

    public int save(String userName, Task task){
    	return taskDao.insert(task);
    }

    public int update(String userName, Task task){
    	return taskDao.update(task);
    }

    public int deleteByPrimaryKey(String userName, Task task){
    	return taskDao.deleteByPrimaryKey(task.getId());
    }

    public List<Task> selectAllList(Map<String, Object> map){
    	PageHelperExt.startPage(map);
    	return taskDao.selectAllList(map);
    }

}
