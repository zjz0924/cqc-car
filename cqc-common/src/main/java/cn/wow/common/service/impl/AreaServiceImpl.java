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
import cn.wow.common.dao.AreaDao;
import cn.wow.common.domain.Area;
import cn.wow.common.domain.TreeNode;
import cn.wow.common.service.AreaService;
import cn.wow.common.utils.pagination.PageHelperExt;

@Service
@Transactional
public class AreaServiceImpl implements AreaService {

	private static Logger logger = LoggerFactory.getLogger(AreaServiceImpl.class);

	@Autowired
	private AreaDao areaDao;

	public Area selectOne(Long id) {
		return areaDao.selectOne(id);
	}
	
	public Area getAreaByCode(String code){
		return areaDao.getAreaByCode(code);
	}

	public int save(String userName, Area area) {
		return areaDao.insert(area);
	}

	public int update(String userName, Area area) {
		return areaDao.update(area);
	}

	public int move(Area area) {
		return areaDao.update(area);
	}

	public int deleteByPrimaryKey(String userName, Area area) {
		return areaDao.deleteByPrimaryKey(area.getId());
	}

	public List<Area> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return areaDao.selectAllList(map);
	}

	/**
	 * 获取区域树
	 */
	public List<TreeNode> getAreaTree(String svalue, String stype) {
		Area rootArea = areaDao.selectOne(1l);
		TreeNode rootNode = new TreeNode();
		
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
			List<Area> dataList = areaDao.selectAllList(qMap);

			List<Area> parentList = new ArrayList<Area>();
			if (dataList != null && dataList.size() > 0) {
				for (Area area : dataList) {
					sId.add(area.getId());
					parentList.add(getSecondArea(area));
				}
			}
			rootArea.setSubList(dataList);
		}

		List<TreeNode> tree = new ArrayList<TreeNode>();
		if (rootArea != null) {
			rootNode.setId(rootArea.getId().toString());
			rootNode.setText(rootArea.getName());

			// 获取子集合
			Iterator<Area> subList = rootArea.getSubList().iterator();
			if (subList.hasNext()) {
				List<TreeNode> subNodeList = new ArrayList<TreeNode>();

				// 遍历子节点
				while (subList.hasNext()) {
					Area subArea = subList.next();

					TreeNode subAreaNode = new TreeNode();
					subAreaNode.setId(subArea.getId().toString());
					subAreaNode.setText(subArea.getName());
					// 遍历子节点
					addSonNode(subAreaNode, subArea);
					subNodeList.add(subAreaNode);
				}
				rootNode.setChildren(subNodeList);
			}
		}
		tree.add(rootNode);

		return tree;
	}

	private void addSonNode(TreeNode subAreaNode, Area area) {
		// 获取子集合
		Iterator<Area> subList = area.getSubList().iterator();

		if (subList.hasNext()) {
			List<TreeNode> subNodeList = new ArrayList<TreeNode>();

			// 遍历子节点
			while (subList.hasNext()) {
				Area subArea = subList.next();

				TreeNode sonNode = new TreeNode();
				sonNode.setId(subArea.getId().toString());
				sonNode.setText(subArea.getName());
				// 遍历子节点
				addSonNode(sonNode, subArea);
				subNodeList.add(sonNode);
			}
			subAreaNode.setChildren(subNodeList);
		}
	}
	
	// 获取二级节点
	private Area getSecondArea(Area area) {
		if (area.getParent() != null && area.getParent().getId() != 1l) {
			getSecondArea(area.getParent());
		}
		return area.getParent();
	}

	private boolean isSearch(String svalue) {
		if (StringUtils.isNotBlank(svalue)) {
			return true;
		} else {
			return false;
		}
	}
}
