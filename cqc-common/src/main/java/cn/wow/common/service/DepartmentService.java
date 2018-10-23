package cn.wow.common.service;

import java.util.List;
import java.util.Map;
import cn.wow.common.domain.Department;

public interface DepartmentService {
	
    public Department selectOne(Long id);

    public int save(String userName, Department department);

    public int update(String userName, Department department);

    public int deleteByPrimaryKey(String userName, Department department);

    public List<Department> selectAllList(Map<String, Object> map);
    
    public Department selectByName(String name);

}
