package cn.wow.common.service.impl;

import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.dao.MenuDao;
import cn.wow.common.domain.Menu;
import cn.wow.common.service.MenuService;

@Service
@Transactional
public class MenuServiceImpl implements MenuService{

    private static Logger logger = LoggerFactory.getLogger(MenuServiceImpl.class);

    @Autowired
    private MenuDao menuDao;

    public List<Menu> getMenuList(){
    	return menuDao.getMenuList();
    }

}
