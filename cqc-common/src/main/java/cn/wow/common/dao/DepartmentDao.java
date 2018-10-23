package cn.wow.common.dao;

import cn.wow.common.domain.Department;

public interface DepartmentDao extends SqlDao{

	public Department selectByName(String name);
}
