package cn.wow.common.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.wow.common.dao.MenuDao;
import cn.wow.common.domain.Menu;
import cn.wow.common.domain.MenuNode;
import cn.wow.common.service.MenuService;
import cn.wow.common.utils.pagination.PageMap;

@Service
@Transactional
public class MenuServiceImpl implements MenuService {

	private static Logger logger = LoggerFactory.getLogger(MenuServiceImpl.class);

	@Autowired
	private MenuDao menuDao;

	public List<Menu> getMenuList() {
		return menuDao.getMenuList();
	}

	public Menu selectByAlias(String alias) {
		return menuDao.selectByAlias(alias);
	}

	public Menu selectOne(Long id) {
		return menuDao.selectOne(id);
	}

	public int update(String userName, Menu menu) {
		return menuDao.update(menu);
	}

	public List<Menu> selectAllList(Map<String, Object> map) {
		return menuDao.selectAllList(map);
	}

	public List<MenuNode> getMenuTree() {
		Map<String, Object> rMap = new PageMap(false);
		rMap.put("custom_order_sql", "p_id asc, sort_num asc");
		List<Menu> menuList = selectAllList(rMap);
		List<MenuNode> nodeList = new ArrayList<MenuNode>();
		
		for(Menu menu : menuList){
			MenuNode node = new MenuNode(menu.getId(), menu.getName(), menu.getUrl(), menu.getSortNum(), menu.getpId());
			nodeList.add(node);
		}
		
		return nodeList;
	}

	
}
