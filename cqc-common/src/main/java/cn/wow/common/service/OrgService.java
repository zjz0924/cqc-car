package cn.wow.common.service;

import java.util.List;
import java.util.Map;
import cn.wow.common.domain.Org;
import cn.wow.common.domain.TreeNode;

public interface OrgService {
    public Org selectOne(Long id);

    public int save(String userName, Org org);

    public int update(String userName, Org org);

    public int deleteByPrimaryKey(String userName, Org org);

    public List<Org> selectAllList(Map<String, Object> map);
    
    /**
     * 获取树
     * @param svalue 搜索值
     * @param stype  搜索类型
     */
    public List<TreeNode> getTree(String svalue, String stype);
    
    public int move(Org org);
    
    public Org getByCode(String code);

}
