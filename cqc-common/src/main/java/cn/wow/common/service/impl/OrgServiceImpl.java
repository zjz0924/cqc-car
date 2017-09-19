package cn.wow.common.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.wow.common.dao.OrgDao;
import cn.wow.common.domain.Org;
import cn.wow.common.domain.TreeNode;
import cn.wow.common.service.OrgService;
import cn.wow.common.utils.pagination.PageHelperExt;

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
	public List<TreeNode> getTree(String svalue, String stype) {
		Org rootOrg = orgDao.selectOne(1l);
		
		/**
		 * 搜索思路：
		 * 1. 先搜索有哪些节点匹配
		 * 2. 获取它们的次上级父节点
		 * 3. 再添加子节点的时候过滤掉父节点是当前节点的节点
		 */
		List<Long> sId = new ArrayList<Long>();
		if (isSearch(svalue)) {
			Map<String, Object> qMap = new HashMap<String, Object>();
			qMap.put(stype, svalue);
			List<Org> dataList = orgDao.selectAllList(qMap);

			List<Org> parentList = new ArrayList<Org>();
			if (dataList != null && dataList.size() > 0) {
				for (Org org : dataList) {
					sId.add(org.getId());
					parentList.add(getSecondOrg(org));
				}
			}
			rootOrg.setSubList(dataList);
		}
		
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
					
					if ((isSearch(svalue) && !sId.contains(subOrg.getId())) || !isSearch(svalue)) {
						// 遍历子节点
						addSonNode(subOrgNode, subOrg);
					}
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
				// 遍历子节点
				addSonNode(sonNode, subOrg);
				subNodeList.add(sonNode);
			}
			subOrgNode.setChildren(subNodeList);
		}
	}
	
	// 获取二级节点
	private Org getSecondOrg(Org org) {
		if (org.getParent() != null && org.getParent().getId() != 1l) {
			getSecondOrg(org.getParent());
		}
		return org.getParent();
	}
	
	
	private boolean isSearch(String svalue) {
		if (StringUtils.isNotBlank(svalue)) {
			return true;
		} else {
			return false;
		}
	}

}
