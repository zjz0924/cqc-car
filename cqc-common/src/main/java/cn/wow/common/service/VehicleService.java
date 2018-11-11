package cn.wow.common.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import cn.wow.common.domain.Vehicle;
import cn.wow.common.vo.ResultFlagVO;

public interface VehicleService {
    public Vehicle selectOne(Long id);

    public int save(String userName, Vehicle vehicle);

    public int update(String userName, Vehicle vehicle);

    public int deleteByPrimaryKey(String userName, Vehicle vehicle);

    public List<Vehicle> selectAllList(Map<String, Object> map);
    
    public Vehicle selectByCode(String code);
    
    /**
     * 检查车型信息是否存在
     */
    public ResultFlagVO isExist(Long id, String code, Date proTime, String proAddr);
    
    /**
	 * 是否更新车型信息
	 */
	public boolean isUpdateVehicleInfo(Vehicle vehicle, String v_code, String v_proTime, String v_proAddr, String v_remark);
}
