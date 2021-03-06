package cn.wow.common.service;

import java.util.Date;
import java.util.List;
import java.util.Map;
import cn.wow.common.domain.Parts;
import cn.wow.common.vo.ResultFlagVO;

public interface PartsService {
    public Parts selectOne(Long id);

    public int save(String userName, Parts parts);

    public int update(String userName, Parts parts);

    public int deleteByPrimaryKey(String userName, Parts parts);

    public List<Parts> selectAllList(Map<String, Object> map);
    
    public Parts selectByCode(String code);
    
    public Parts selectByCodeAndType(String code, Integer type);
    
    /**
     * 检查零件信息是否存在
     */
	public ResultFlagVO isExist(Long id, String name, Date proTime, String producer, String producerCode, String p_code, String p_proNo, Integer p_num, String p_place);
	
	
	/**
	 * 获取生产商名称列表
	 */
	public List<String> getProduceList(String name);
	
	
	/**
	 * 是否更新零件信息
	 */
	public boolean isUpdatePartsInfo(Parts parts, String p_code, String p_name, String p_proTime, String p_place,
			String p_proNo, String p_remark, Integer p_num, String p_producer, String p_producerCode);
}
