package cn.wow.common.service.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.wow.common.dao.PartsDao;
import cn.wow.common.domain.Parts;
import cn.wow.common.service.PartsService;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.vo.ResultFlagVO;

@Service
@Transactional
public class PartsServiceImpl implements PartsService {

	private static Logger logger = LoggerFactory.getLogger(PartsServiceImpl.class);

	@Autowired
	private PartsDao partsDao;

	public Parts selectOne(Long id) {
		return partsDao.selectOne(id);
	}

	public Parts selectByCode(String code) {
		return partsDao.selectByCode(code);
	}

	public int save(String userName, Parts parts) {
		return partsDao.insert(parts);
	}

	public int update(String userName, Parts parts) {
		return partsDao.update(parts);
	}

	public int deleteByPrimaryKey(String userName, Parts parts) {
		return partsDao.deleteByPrimaryKey(parts.getId());
	}

	public List<Parts> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return partsDao.selectAllList(map);
	}

	public Parts selectByCodeAndType(String code, Integer type) {
		Map<String, Object> map = new PageMap(false);
		map.put("code", code);
		map.put("type", type);

		List<Parts> list = partsDao.selectAllList(map);
		if (list != null && list.size() > 0) {
			return list.get(0);
		} else {
			return null;
		}
	}

	/**
	 * 检查零部件信息是否存在
	 */
	public ResultFlagVO isExist(Long id, String name, Date proTime, String producer, String producerCode, String p_code,
			String p_proNo, Integer p_num, String p_place) {

		ResultFlagVO vo = new ResultFlagVO();

		Map<String, Object> map = new PageMap(false);
		if (id != null) {
			map.put("eid", id);
		}
		map.put("ename", name);
		map.put("producer", producer);
		map.put("producerCode", producerCode);
		map.put("eProTime", proTime);

		List<Parts> dataList = partsDao.selectAllList(map);
		if (dataList != null && dataList.size() > 0) {
			for (Parts p : dataList) {
				if (p.getState() == 1) {
					continue;
				}

				if (!isTheSame(p.getCode(), p_code)) {
					continue;
				}

				if (!isTheSame(p.getProNo(), p_proNo)) {
					continue;
				}

				if (!isTheSame(p.getPlace(), p_place)) {
					continue;
				}

				if (!isTheSame(p_num, p.getNum())) {
					continue;
				}

				vo.setFlag(true);
				vo.setState(0);
				break;
			}
		} else {
			vo.setFlag(false);
		}
		return vo;
	}

	/**
	 * 获取生产商名称列表
	 */
	public List<String> getProduceList(String name) {
		return partsDao.getProduceList(name);
	}

	/**
	 * 是否更新零部件信息
	 */
	public boolean isUpdatePartsInfo(Parts parts, String p_code, String p_name, String p_proTime, String p_place,
			String p_proNo, String p_remark, Integer p_num, String p_producer, String p_producerCode) {

		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if (parts == null) {
			if (StringUtils.isNotBlank(p_code) || StringUtils.isNotBlank(p_name) || StringUtils.isNotBlank(p_proTime)
					|| StringUtils.isNotBlank(p_place) || StringUtils.isNotBlank(p_proNo)
					|| StringUtils.isNotBlank(p_remark) || p_num != null || StringUtils.isNotBlank(p_producer)
					|| StringUtils.isNotBlank(p_producerCode)) {
				return true;
			} else {
				return false;
			}
		} else {
			if (p_code.equals(parts.getCode()) && p_name.equals(parts.getName())
					&& ((parts.getProTime() != null && p_proTime.equals(sdf.format(parts.getProTime())))
							|| (parts.getProTime() == null && StringUtils.isBlank(p_proTime)))
					&& p_place.equals(parts.getPlace()) && p_proNo.equals(parts.getProNo())
					&& p_remark.equals(parts.getRemark())
					&& ((p_num != null && p_num.intValue() == parts.getNum()) || p_num == null)
					&& p_producer.equals(parts.getProducer()) && p_producerCode.equals(parts.getProducerCode())) {
				return false;
			} else {
				return true;
			}
		}

	}

	private boolean isTheSame(String obj1, String obj2) {
		if (StringUtils.isNotBlank(obj1) && StringUtils.isNotBlank(obj2)) {
			if (obj1.equals(obj2)) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}

	private boolean isTheSame(Integer obj1, Integer obj2) {
		if (obj1 != null && obj2 != null) {
			if (obj1.intValue() == obj2.intValue()) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}

}
