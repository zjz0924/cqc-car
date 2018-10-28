package cn.wow.common.service;

import java.util.List;
import java.util.Map;
import cn.wow.common.domain.Attach;

public interface AttachService {
	
    public Attach selectOne(Long id);

    public int save(String userName, Attach attach);

    public int update(String userName, Attach attach);

    public int deleteByPrimaryKey(String userName, Attach attach);

    public List<Attach> selectAllList(Map<String, Object> map);

    public Attach getFileName(Long taskId);
}
