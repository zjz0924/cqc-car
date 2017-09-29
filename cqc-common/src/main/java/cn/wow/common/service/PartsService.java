package cn.wow.common.service;

import java.util.List;
import java.util.Map;
import cn.wow.common.domain.Parts;

public interface PartsService {
    public Parts selectOne(Long id);

    public int save(String userName, Parts parts);

    public int update(String userName, Parts parts);

    public int deleteByPrimaryKey(String userName, Parts parts);

    public List<Parts> selectAllList(Map<String, Object> map);
    
    public Parts selectByCode(String code);
    
    public Parts selectByCodeAndType(String code, Integer type);

}
