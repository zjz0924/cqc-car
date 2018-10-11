package cn.wow.common.service;

import java.util.List;
import java.util.Map;

import cn.wow.common.domain.CarCode;

public interface CarCodeService {
    public CarCode selectOne(Long id);

    public int save(String userName, CarCode CarCode);

    public int update(String userName, CarCode CarCode);

    public int deleteByPrimaryKey(String userName, CarCode CarCode);

    public List<CarCode> selectAllList(Map<String, Object> map);
    
    public CarCode selectByCode(String code);

}
