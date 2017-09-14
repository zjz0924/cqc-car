package cn.wow.support.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.wow.common.domain.Area;
import cn.wow.common.domain.Org;
import cn.wow.common.domain.TreeNode;
import cn.wow.common.service.OperationLogService;
import cn.wow.common.service.OrgService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.operationlog.OperationType;
import cn.wow.common.utils.operationlog.ServiceType;

/**
 * 机构管理控制器
 * 
 * @author zhenjunzhuo 
 * 2017-09-15
 */
@Controller
@RequestMapping(value = "org")
public class OrgController extends AbstractController {

	Logger logger = LoggerFactory.getLogger(OrgController.class);

	@Autowired
	private OrgService orgService;
	@Autowired
	private OperationLogService operationLogService;

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest request, Model model) {
		return "sys/org/org_list";
	}

	/**
	 * 新建/修改页面
	 */
	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id, String parentid) {
		if (StringUtils.isNotBlank(id)) {
			Org org = orgService.selectOne(Long.parseLong(id));
			model.addAttribute("area", org);
		}

		Org parent = orgService.selectOne(Long.parseLong(parentid));
		model.addAttribute("parent", parent);
		model.addAttribute("id", id);
		model.addAttribute("parentid", parentid);
		return "sys/org/org_detail";
	}

	/**
	 * 新建/修改保存
	 */
	@ResponseBody
	@RequestMapping(value = "/save")
	public AjaxVO save(HttpServletRequest request, Model model, String id, String code, String parentid, String text, String desc, String areaid) {
		AjaxVO vo = new AjaxVO();
		Org org = null;

		try {
			if (StringUtils.isNoneBlank(id)) {
				org = orgService.selectOne(Long.parseLong(id));

				if (org != null) {
					if (!org.getName().equals(text)) {
						Map<String, Object> rMap = new HashMap<String, Object>();
						rMap.put("name", text);
						rMap.put("parentid", parentid);
						List<Org> areaList = orgService.selectAllList(rMap);

						if (areaList != null && areaList.size() > 0) {
							vo.setMsg("同一级机构下，机构名称不能重复");
							vo.setSuccess(false);
							return vo;
						}
					}

					org.setDesc(desc);
					org.setName(text);
					org.setParentid(Long.parseLong(parentid));
					if(StringUtils.isNotBlank(areaid)){
						org.setAreaid(Long.parseLong(areaid));
					}
					orgService.update(getCurrentUserName(), org);
					
					vo.setMsg("编辑成功");
				}
			} else {
				Org exist = orgService.getByCode(code);
				if(exist != null){
					vo.setMsg("机构编码已经存在，请重新输入");
					vo.setSuccess(false);
					return vo;
				}
				
				Map<String, Object> rMap = new HashMap<String, Object>();
				rMap.put("name", text);
				rMap.put("parentid", parentid);
				List<Org> orgList = orgService.selectAllList(rMap);

				if (orgList != null && orgList.size() > 0) {
					vo.setMsg("同一级机构下，机构名称不能重复");
					vo.setSuccess(false);
					return vo;
				} else {
					org = new Org();
					org.setDesc(desc);
					org.setName(text);
					org.setCode(code);
					org.setParentid(Long.parseLong(parentid));
					if(StringUtils.isNotBlank(areaid)){
						org.setAreaid(Long.parseLong(areaid));
					}
					Org parent = orgService.selectOne(Long.parseLong(parentid));
					org.setParent(parent);
					
					orgService.save(getCurrentUserName(), org);
					vo.setMsg("新建成功");
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();

			vo.setMsg("保存失败，系统异常");
			vo.setSuccess(false);
			logger.error("机构保存失败：", ex.getMessage());
			return vo;
		}
		vo.setData(org.getId());
		return vo;
	}

	/**
	 * 机构树
	 */
	@ResponseBody
	@RequestMapping(value = "/tree")
	public List<TreeNode> tree(HttpServletRequest request, Model model) {
		List<TreeNode> areaTree = orgService.getTree();
		return areaTree;
	}

	/**
	 * 机构信息
	 */
	@ResponseBody
	@RequestMapping(value = "/info")
	public Org info(HttpServletRequest request, Model model, String id) {
		Org org = orgService.selectOne(Long.parseLong(id));
		return org;
	}

	/**
	 * 机构移动
	 */
	@ResponseBody
	@RequestMapping(value = "/move")
	public AjaxVO move(HttpServletRequest request, Model model, String id, String parentid) {
		AjaxVO vo = new AjaxVO();

		try {
			Org org = orgService.selectOne(Long.parseLong(id));
			
			String oldParentCode = "";
			if (org.getParent() != null) {
				oldParentCode = org.getParent().getCode();
			}
			org.setParentid(Long.parseLong(parentid));
			orgService.move(org);

			// 当前父节点
			Org currentParent = orgService.selectOne(Long.parseLong(id));

			String detail = "{\"name\":\"" + org.getName() + "\", \"from\":\"" + oldParentCode + "\", \"to\":\"" + currentParent.getParent().getCode() + "\"}";
			operationLogService.save(getCurrentUserName(), OperationType.MOVE, ServiceType.AREA, detail);
		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("机构移动失败：", ex.getMessage());
		}

		vo.setMsg("移动成功");
		vo.setSuccess(true);
		return vo;
	}

	/**
	 * 机构删除
	 */
	@ResponseBody
	@RequestMapping(value = "/delete")
	public AjaxVO delete(HttpServletRequest request, Model model, String id) {
		AjaxVO vo = new AjaxVO();

		try {
			Org org = orgService.selectOne(Long.parseLong(id));
			orgService.deleteByPrimaryKey(getCurrentUserName(), org);
		} catch (Exception ex) {
			ex.printStackTrace();

			vo.setMsg("删除失败，系统异常");
			vo.setSuccess(false);
			logger.error("机构删除失败：", ex.getMessage());
			return vo;
		}

		vo.setMsg("删除成功");
		vo.setSuccess(true);
		return vo;
	}
}
