package cn.wow.common.service;

import java.util.List;
import java.util.Map;
import cn.wow.common.domain.Vehicle;

public interface VehicleService {
    public Vehicle selectOne(Long id);

    public int save(String userName, Vehicle vehicle);

    public int update(String userName, Vehicle vehicle);

    public int deleteByPrimaryKey(String userName, Vehicle vehicle);

    public List<Vehicle> selectAllList(Map<String, Object> map);
    
    public Vehicle selectByCode(String code);
}
