package cn.wow.common.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import cn.wow.common.utils.operationlog.annotation.OperationLogIgnore;
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
		TreeNode rootNode = new TreeNode();
		
		/**
		 * 搜索思路：
		 * 1. 先搜索有哪些节点匹配
		 * 2. 获取它们的次上级父节点
		 * 3. 再添加子节点的时候过滤掉父节点是当前节点的节点
		 */
		// 搜索的节点ID
		Set<Long> targetId = new HashSet<Long>();
		// 所有符合要求的节点ID
		Set<Long> legalId = new HashSet<Long>();
		// 搜索的节点的父ID
		Set<Long> parentId = new HashSet<Long>();
		
		if (isSearch(svalue)) {
			Map<String, Object> qMap = new HashMap<String, Object>();
			qMap.put(stype, svalue);
			List<Org> dataList = orgDao.selectAllList(qMap);

			Set<Org> parentSet = new HashSet<Org>();
			if (dataList != null && dataList.size() > 0) {
				for (Org org : dataList) {
					//不处理根节点
					if(org.getParent() != null){
						targetId.add(org.getId());
						legalId.add(org.getId());
					}
					
					// 获取搜索节点的二级父节点
					Org parentOrg = getSecondOrg(org, legalId, parentId);
					if (!parentSet.contains(parentOrg)) {
						parentSet.add(parentOrg);
					}
					// 去掉重复的对象
					removeDuplicate(parentSet);
				}
				
				//防止父节点与子节点名称相同
				targetId.removeAll(parentId);
			}
			
			List<Org> parentList = new ArrayList<Org>();
			parentList.addAll(parentSet);
			rootOrg.setSubList(parentList);
		}
		
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

					if ((isSearch(svalue) && legalId.contains(subOrg.getId())) || !isSearch(svalue)) {
						TreeNode subOrgNode = new TreeNode();
						subOrgNode.setId(subOrg.getId().toString());
						subOrgNode.setText(subOrg.getName());

						boolean isSearch = isSearch(svalue);
						if ((isSearch && !targetId.contains(subOrg.getId())) || !isSearch) {
							// 遍历子节点
							addSonNode(subOrgNode, subOrg, legalId, targetId, isSearch);
						}
						subNodeList.add(subOrgNode);
					}
				}
				rootNode.setChildren(subNodeList);
			}
		}
		tree.add(rootNode);

		return tree;
	}

	private void addSonNode(TreeNode subOrgNode, Org org, Set<Long> legalId, Set<Long> targetId, boolean isSearch) {
		// 获取子集合
		Iterator<Org> subList = org.getSubList().iterator();

		if (subList.hasNext()) {
			List<TreeNode> subNodeList = new ArrayList<TreeNode>();

			// 遍历子节点
			while (subList.hasNext()) {
				Org subOrg = subList.next();

				if ((isSearch && legalId.contains(subOrg.getId())) || !isSearch) {
					TreeNode sonNode = new TreeNode();
					sonNode.setId(subOrg.getId().toString());
					sonNode.setText(subOrg.getName());
					
					if ((isSearch && !targetId.contains(subOrg.getId())) || !isSearch) {
						// 遍历子节点
						addSonNode(sonNode, subOrg, legalId, targetId, isSearch);
					}
					subNodeList.add(sonNode);
				}
			}
			subOrgNode.setChildren(subNodeList);
		}
	}
	
	// 获取二级节点
	private Org getSecondOrg(Org org, Set<Long> legalId, Set<Long> parentId) {
		if (org.getParent() != null && org.getParent().getId() != 1l) {
			legalId.add(org.getParent().getId());
			parentId.add(org.getParent().getId());
			return getSecondOrg(org.getParent(), legalId, parentId);
		}
		return org;
	}
	
	
	private boolean isSearch(String svalue) {
		if (StringUtils.isNotBlank(svalue)) {
			return true;
		} else {
			return false;
		}
	}

	// 去除set中重复数据的方法
	@OperationLogIgnore
	private Set<Org> removeDuplicate(Set<Org> set) {
		Map<String, Org> map = new HashMap<String, Org>();
		Set<Org> tempSet = new HashSet<Org>();
		for (Org org : set) {
			if (map.get(org.getCode()) == null) {
				map.put(org.getCode(), org);
			} else {
				tempSet.add(org);
			}
		}
		set.removeAll(tempSet);
		return set;
	}
	
}
