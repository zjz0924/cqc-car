package cn.wow.common.dao;

import java.util.List;

import cn.wow.common.domain.ExamineRecord;

public interface ExamineRecordDao extends SqlDao {

	public void batchAdd(List<ExamineRecord> list);
}