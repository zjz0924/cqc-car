package cn.wow.common.service.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.dao.OrgDao;
import cn.wow.common.domain.Org;
import cn.wow.common.domain.TreeNode;
import cn.wow.common.service.OrgService;

@Service
@Transactional
public class OrgServiceImpl implements OrgService{

    private static Logger logger = LoggerFactory.getLogger(OrgServiceImpl.class);

    @Autowired
    private OrgDao orgDao;

    public Org selectOne(Long id){
    	return orgDao.selectOne(id);
    }
    
    public Org getByCode(String code){
		return orgDao.getByCode(code);
	}

    public int save(String userName, Org org){
    	return orgDao.insert(org);
    }
    
    public int move(Org org) {
		return orgDao.update(org);
	}

    public int update(String userName, Org org){
    	return orgDao.update(org);
    }

    public int deleteByPrimaryKey(String userName, Org org){
    	return orgDao.deleteByPrimaryKey(org.getId());
    }

    public List<Org> selectAllList(Map<String, Object> map){
    	PageHelperExt.startPage(map);
    	return orgDao.selectAllList(map);
    }
    
    /**
	 * 获取区域树
	 */
	public List<TreeNode> getTree() {
		Org rootOrg = orgDao.selectOne(1l);
		TreeNode rootNode = new TreeNode();

		List<TreeNode> tree = new ArrayList<TreeNode>();
		if (rootOrg != null) {
			rootNode.setId(rootOrg.getId().toString());
			rootNode.setText(rootOrg.getName());

			// 获取子集合
			Iterator<Org> subList = rootOrg.getSubList().iterator();
			if (subList.hasNext()) {
				List<TreeNode> subNodeList = new ArrayList<TreeNode>();

				// 遍历子节点
				while (subList.hasNext()) {
					Org subOrg = subList.next();

					TreeNode subOrgNode = new TreeNode();
					subOrgNode.setId(subOrg.getId().toString());
					subOrgNode.setText(subOrg.getName());
					subOrgNode.setParent(rootOrg.getId().toString());
					// 遍历子节点
					addSonNode(subOrgNode, subOrg);
					subNodeList.add(subOrgNode);
				}
				rootNode.setChildren(subNodeList);
			}
		}
		tree.add(rootNode);

		return tree;
	}

	private void addSonNode(TreeNode subOrgNode, Org org) {
		// 获取子集合
		Iterator<Org> subList = org.getSubList().iterator();

		if (subList.hasNext()) {
			List<TreeNode> subNodeList = new ArrayList<TreeNode>();

			// 遍历子节点
			while (subList.hasNext()) {
				Org subOrg = subList.next();

				TreeNode sonNode = new TreeNode();
				sonNode.setId(subOrg.getId().toString());
				sonNode.setText(subOrg.getName());
				sonNode.setParent(org.getId().toString());
				// 遍历子节点
				addSonNode(sonNode, subOrg);
				subNodeList.add(sonNode);
			}
			subOrgNode.setChildren(subNodeList);
		}
	}

}
