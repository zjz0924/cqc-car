package cn.wow.common.service.impl;

import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.dao.PartsDao;
import cn.wow.common.domain.Parts;
import cn.wow.common.service.PartsService;

@Service
@Transactional
public class PartsServiceImpl implements PartsService{

    private static Logger logger = LoggerFactory.getLogger(PartsServiceImpl.class);

    @Autowired
    private PartsDao partsDao;

    public Parts selectOne(Long id){
    	return partsDao.selectOne(id);
    }
    
    public Parts selectByCode(String code){
    	return partsDao.selectByCode(code);
    }

    public int save(String userName, Parts parts){
    	return partsDao.insert(parts);
    }

    public int update(String userName, Parts parts){
    	return partsDao.update(parts);
    }

    public int deleteByPrimaryKey(String userName, Parts parts){
    	return partsDao.deleteByPrimaryKey(parts.getId());
    }

    public List<Parts> selectAllList(Map<String, Object> map){
    	PageHelperExt.startPage(map);
    	return partsDao.selectAllList(map);
    }

}
