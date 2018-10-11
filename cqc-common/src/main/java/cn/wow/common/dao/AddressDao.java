package cn.wow.common.dao;

import cn.wow.common.domain.Address;

public interface AddressDao extends SqlDao{

	public Address selectByName(String name);
}