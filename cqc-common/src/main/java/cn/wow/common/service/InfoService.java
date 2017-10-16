package cn.wow.common.service;

import java.util.List;
import java.util.Map;

import cn.wow.common.domain.Account;
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
    
    public int insert(Account account, Vehicle vehicle, Parts parts, Material material, int type);
    
    /**
     * 审核
     * @param account  操作用户
     * @param id       任务ID
     * @param type     结果：1-通过，2-不通过
     * @param remark   备注
     */
    public void examine(Account account, Long id, int type, String remark);
    
    /**
     * 更新任务状态
     * @param id     任务ID
     * @param state  任务状态
     */
    public void updateState(Long id, Integer state);
    
    /**
     * 下达任务
     * @param account   操作用户
     * @param id        任务ID
     * @param tgLabe    热重分析实验室ID
	 * @param dtLab     差热扫描实验室ID
	 * @param infLab    红外光分析实验室ID
     */
    public void transmit(Account account, Long id, Long tgLabe, Long dtLab, Long infLab);
}
