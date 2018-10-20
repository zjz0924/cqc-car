package cn.wow.common.dao;

import cn.wow.common.domain.ReasonOption;

public interface ReasonOptionDao extends SqlDao{

	public ReasonOption selectByName(String name);
}