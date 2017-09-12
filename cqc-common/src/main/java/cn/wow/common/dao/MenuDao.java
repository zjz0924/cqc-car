package cn.wow.common.dao;

import java.util.List;

import cn.wow.common.domain.Menu;

public interface MenuDao extends SqlDao{

	public List<Menu> getMenuList();
}