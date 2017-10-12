package cn.wow.common.service;

import java.util.List;
import java.util.Map;
import cn.wow.common.domain.Info;
import cn.wow.common.domain.Material;
import cn.wow.common.domain.Parts;
import cn.wow.common.domain.Vehicle;

public interface InfoService {
    public Info selectOne(Long id);

    public int save(String userName, Info info);

    public int update(String userName, Info info);

    public int deleteByPrimaryKey(String userName, Info info);

    public List<Info> selectAllList(Map<String, Object> map);
    
    public int insert(Vehicle vehicle, Parts parts, Material material, int type);
}
