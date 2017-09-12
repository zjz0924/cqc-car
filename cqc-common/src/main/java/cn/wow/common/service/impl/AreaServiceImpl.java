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

import cn.wow.common.dao.AreaDao;
import cn.wow.common.domain.Area;
import cn.wow.common.domain.AreaNode;
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

	public int save(String userName, Area area) {
		return areaDao.insert(area);
	}

	public int update(String userName, Area area) {
		return areaDao.update(area);
	}

	public int deleteByPrimaryKey(String userName, Area area) {
		return areaDao.deleteByPrimaryKey(area.getId());
	}

	public List<Area> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return areaDao.selectAllList(map);
	}

	public List<AreaNode> getAreaTree() {
		Area rootArea = areaDao.selectOne(1l);
		AreaNode rootNode = new AreaNode();

		List<AreaNode> tree = new ArrayList<AreaNode>();
		if (rootArea != null) {
			rootNode.setId(rootArea.getId().toString());
			rootNode.setText(rootArea.getName());

			// 获取子集合
			Iterator<Area> subList = rootArea.getSubList().iterator();
			if (subList.hasNext()) {
				List<AreaNode> subNodeList = new ArrayList<AreaNode>();

				// 遍历子节点
				while (subList.hasNext()) {
					Area subArea = subList.next();

					AreaNode subAreaNode = new AreaNode();
					subAreaNode.setId(subArea.getId().toString());
					subAreaNode.setText(subArea.getName());
					subAreaNode.setParent(rootArea.getId().toString());
					// 遍历子节点
					addSonOrg(subAreaNode, subArea);
					subNodeList.add(subAreaNode);
				}
				rootNode.setChildren(subNodeList);
			}
		}
		tree.add(rootNode);

		return tree;
	}

	private void addSonOrg(AreaNode subAreaNode, Area area) {
		// 获取子集合
		Iterator<Area> subList = area.getSubList().iterator();

		if (subList.hasNext()) {
			List<AreaNode> subNodeList = new ArrayList<AreaNode>();

			// 遍历子节点
			while (subList.hasNext()) {
				Area subArea = subList.next();

				AreaNode sonNode = new AreaNode();
				sonNode.setId(subArea.getId().toString());
				sonNode.setText(subArea.getName());
				sonNode.setParent(area.getId().toString());
				// 遍历子节点
				addSonOrg(sonNode, subArea);
				subNodeList.add(sonNode);
			}
			subAreaNode.setChildren(subNodeList);
		}
	}

}
