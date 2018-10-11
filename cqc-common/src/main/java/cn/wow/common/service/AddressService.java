package cn.wow.common.service;

import java.util.List;
import java.util.Map;

import cn.wow.common.domain.Address;

public interface AddressService {
    public Address selectOne(Long id);

    public int save(String userName, Address address);

    public int update(String userName, Address address);

    public int deleteByPrimaryKey(String userName, Address address);

    public List<Address> selectAllList(Map<String, Object> map);
    
    public Address selectByName(String name);

}
