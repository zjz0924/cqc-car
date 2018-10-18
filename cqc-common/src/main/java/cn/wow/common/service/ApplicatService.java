package cn.wow.common.service;

import java.util.List;
import java.util.Map;
import cn.wow.common.domain.Applicat;

public interface ApplicatService {
	
    public Applicat selectOne(Long id);

    public int save(String userName, Applicat applicat);

    public int update(String userName, Applicat applicat);

    public int deleteByPrimaryKey(String userName, Applicat applicat);

    public List<Applicat> selectAllList(Map<String, Object> map);
    
    // 获取申请人ID
    public List<Long> selectIds(String applicat_name, String applicat_depart, Integer applicat_org);

}
