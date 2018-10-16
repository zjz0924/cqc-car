package cn.wow.common.service.impl;

import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.dao.AddressDao;
import cn.wow.common.domain.Address;
import cn.wow.common.service.AddressService;

@Service
@Transactional
public class AddressServiceImpl implements AddressService{

    private static Logger logger = LoggerFactory.getLogger(AddressServiceImpl.class);

    @Autowired
    private AddressDao addressDao;

    public Address selectOne(Long id){
    	return addressDao.selectOne(id);
    }

    public int save(String userName, Address address){
    	return addressDao.insert(address);
    }

    public int update(String userName, Address address){
    	return addressDao.update(address);
    }

    public int deleteByPrimaryKey(String userName, Address address){
    	return addressDao.deleteByPrimaryKey(address.getId());
    }

    public List<Address> selectAllList(Map<String, Object> map){
    	PageHelperExt.startPage(map);
    	return addressDao.selectAllList(map);
    }

    public Address selectByName(String name) {
    	return addressDao.selectByName(name);
    }
    
    
    /**
	 * 获取 生产基地列表
	 */
	public List<Address> getAddressList() {
		Map<String, Object> addressMap = new PageMap(false);
		addressMap.put("custom_order_sql", "name asc");
		List<Address> addressList = addressDao.selectAllList(addressMap);

		return addressList;
	}
}
