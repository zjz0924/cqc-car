package cn.wow.common.dao;

import java.util.Map;
import cn.wow.common.domain.ReasonOption;

public interface ReasonOptionDao extends SqlDao{

	public ReasonOption selectByName(Map<String, Object> map);
}