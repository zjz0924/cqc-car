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
     * 检查零部件信息是否存在
     */
	public ResultFlagVO isExist(Long id, String p_code, String p_name, Date p_proTime, String p_place, String p_proNo,
			String p_keyCode, Integer p_isKey, String p_remark, String p_contacts,
			String p_phone, String p_producer);

	
	
	/**
	 * 获取生产商名称列表
	 */
	public List<String> getProduceList(String name);
}
