package cn.wow.common.dao;

import cn.wow.common.domain.CarCode;

public interface CarCodeDao extends SqlDao{

	public CarCode selectByCode(String code);
}