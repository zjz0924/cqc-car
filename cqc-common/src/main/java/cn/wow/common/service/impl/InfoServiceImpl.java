package cn.wow.common.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.wow.common.dao.InfoDao;
import cn.wow.common.dao.MaterialDao;
import cn.wow.common.dao.PartsDao;
import cn.wow.common.dao.VehicleDao;
import cn.wow.common.domain.Info;
import cn.wow.common.domain.Material;
import cn.wow.common.domain.Parts;
import cn.wow.common.domain.Vehicle;
import cn.wow.common.service.InfoService;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.pagination.PageHelperExt;

@Service
@Transactional
public class InfoServiceImpl implements InfoService{

    private static Logger logger = LoggerFactory.getLogger(InfoServiceImpl.class);

    @Autowired
    private InfoDao infoDao;
    @Autowired
    private VehicleDao vehicleDao;
    @Autowired
    private PartsDao partsDao;
    @Autowired
    private MaterialDao materialDao;

    public Info selectOne(Long id){
    	return infoDao.selectOne(id);
    }

    public int save(String userName, Info info){
    	return infoDao.insert(info);
    }

    public int update(String userName, Info info){
    	return infoDao.update(info);
    }

    public int deleteByPrimaryKey(String userName, Info info){
    	return infoDao.deleteByPrimaryKey(info.getId());
    }

    public List<Info> selectAllList(Map<String, Object> map){
    	PageHelperExt.startPage(map);
    	return infoDao.selectAllList(map);
    }
    
	public int insert(Vehicle vehicle, Parts parts, Material material, int type) {
		vehicleDao.insert(vehicle);
		partsDao.insert(parts);
		materialDao.insert(material);

		// 信息
		Info info = new Info();
		info.setCreateTime(vehicle.getCreateTime());
		info.setmId(material.getId());
		info.setpId(parts.getId());
		info.setState(Contants.ONDOING_TYPE);
		info.setvId(vehicle.getId());
		info.setType(type);
		
		// 任务
		
		
		// 操作记录
		
		return infoDao.insert(info);
	}

}
