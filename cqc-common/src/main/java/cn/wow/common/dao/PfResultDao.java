package cn.wow.common.dao;

import java.util.List;
import cn.wow.common.domain.PfResult;

public interface PfResultDao extends SqlDao {
	public void batchAdd(List<PfResult> list);
}