package cn.wow.support.web;

import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import cn.wow.common.domain.Account;
import cn.wow.common.domain.Area;
import cn.wow.common.domain.Org;
import cn.wow.common.domain.TreeNode;
import cn.wow.common.service.AreaService;
import cn.wow.common.service.OperationLogService;
import cn.wow.common.service.OrgService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.ImportExcelUtil;
import cn.wow.common.utils.operationlog.OperationType;
import cn.wow.common.utils.operationlog.ServiceType;
import cn.wow.common.utils.pagination.PageMap;

/**
 * 机构管理控制器
 * 
 * @author zhenjunzhuo 2017-09-15
 */
@Controller
@RequestMapping(value = "org")
public class OrgController extends AbstractController {

	Logger logger = LoggerFactory.getLogger(OrgController.class);

	@Autowired
	private OrgService orgService;
	@Autowired
	private OperationLogService operationLogService;
	@Autowired
	private AreaService areaService;

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest request, Model model) {
		return "sys/org/org_list";
	}

	/**
	 * 新建/修改页面
	 */
	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id, String parentid) {
		Org org = null;
		boolean canEdit = true;

		if (StringUtils.isNotBlank(id)) {
			org = orgService.selectOne(Long.parseLong(id));

			if (org.getParent() != null) {
				parentid = org.getParent().getId().toString();
			}
			if (org.getArea() != null) {
				model.addAttribute("areaid", org.getArea().getId());
				model.addAttribute("areaname", org.getArea().getName());
			}

			model.addAttribute("org", org);
		}

		if (StringUtils.isNotBlank(parentid)) {
			Org parentOrg = orgService.selectOne(Long.parseLong(parentid));
			model.addAttribute("parentOrg", parentOrg);

			// 如果父节点没有选择类型，那么就显示当前自己的类型
			Integer type = null;
			if (parentOrg.getType() != null) {
				type = parentOrg.getType();
				canEdit = false;
			} else {
				if (org != null) {
					type = org.getType();
					canEdit = true;
				}
			}
			model.addAttribute("type", type);
			model.addAttribute("canEdit", canEdit);
		}

		model.addAttribute("id", id);
		return "sys/org/org_detail";
	}

	/**
	 * 新建/修改保存
	 */
	@ResponseBody
	@RequestMapping(value = "/save")
	public AjaxVO save(HttpServletRequest request, Model model, String id, String code, String parentid, String text,
			String desc, String areaid, Integer type, String addr) {
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
							vo.setMsg("名称已存在");
							vo.setSuccess(false);
							vo.setData("name");
							return vo;
						}
					}

					// 是否需要修改所有子机构的类型
					boolean flag = false;
					if (org.getType() != null && org.getType().intValue() != type.intValue()) {
						flag = true;
					}

					org.setDesc(desc);
					org.setName(text);
					org.setType(type);
					org.setAddr(addr);
					org.setParentid(Long.parseLong(parentid));
					if (StringUtils.isNotBlank(areaid)) {
						org.setAreaid(Long.parseLong(areaid));
					}
					orgService.update(getCurrentUserName(), org, flag);

					vo.setMsg("编辑成功");
				}
			} else {
				Org exist = orgService.getByCode(code);
				if (exist != null) {
					vo.setMsg("编码已存在");
					vo.setSuccess(false);
					vo.setData("code");
					return vo;
				}

				Map<String, Object> rMap = new HashMap<String, Object>();
				rMap.put("name", text);
				rMap.put("parentid", parentid);
				List<Org> orgList = orgService.selectAllList(rMap);

				if (orgList != null && orgList.size() > 0) {
					vo.setMsg("名称已存在");
					vo.setSuccess(false);
					vo.setData("name");
					return vo;
				} else {
					org = new Org();
					org.setDesc(desc);
					org.setName(text);
					org.setCode(code);
					org.setType(type);
					org.setAddr(addr);
					org.setParentid(Long.parseLong(parentid));
					if (StringUtils.isNotBlank(areaid)) {
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
			logger.error("机构保存失败：", ex);
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
	public List<TreeNode> tree(HttpServletRequest request, Model model, String svalue, String stype) {
		List<TreeNode> areaTree = orgService.getTree(svalue, stype);
		return areaTree;
	}

	/**
	 * 获取类型获取机构树
	 * 
	 * @param type 1-通用五菱, 2-供应商, 3-实验室, 4-其它
	 */
	@ResponseBody
	@RequestMapping(value = "/getTreeByType")
	public List<TreeNode> getTreeByType(HttpServletRequest request, Model model, int type) {
		List<TreeNode> areaTree = orgService.getTreeByType(type);
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

			boolean flag = true;
			Org newOrg = orgService.selectOne(Long.parseLong(parentid));
			if (newOrg.getType() != null && org.getParent().getType() != null
					&& newOrg.getType().intValue() == org.getParent().getType().intValue()) {
				flag = false;
			} else {
				org.setType(newOrg.getType());
			}
			orgService.move(org, flag);

			// 当前父节点
			Org currentParent = orgService.selectOne(Long.parseLong(id));

			String detail = "{\"name\":\"" + org.getName() + "\", \"from\":\"" + oldParentCode + "\", \"to\":\""
					+ currentParent.getCode() + "\"}";
			operationLogService.save(getCurrentUserName(), OperationType.MOVE, ServiceType.SYSTEM, detail);
		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("机构移动失败：", ex);

			vo.setSuccess(false);
			vo.setMsg("机构移动失败");
			return vo;
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
			orgService.delete(getCurrentUserName(), org);
		} catch (Exception ex) {
			ex.printStackTrace();

			vo.setMsg("删除失败，系统异常");
			vo.setSuccess(false);
			logger.error("机构删除失败：", ex);
			return vo;
		}

		vo.setMsg("删除成功");
		vo.setSuccess(true);
		return vo;
	}

	/**
	 * 机构导出
	 */
	@RequestMapping(value = "/export")
	public void export(HttpServletRequest request, HttpServletResponse response) {
		String filename = "机构列表";

		try {
			// 设置头
			ImportExcelUtil.setResponseHeader(response, filename + ".xlsx");

			Workbook wb = new SXSSFWorkbook(100); // 保持100条在内存中，其它保存到磁盘中
			// 工作簿
			Sheet sh = wb.createSheet("机构清单");
			sh.setColumnWidth(0, (short) 4000);
			sh.setColumnWidth(1, (short) 8000);
			sh.setColumnWidth(2, (short) 4000);
			sh.setColumnWidth(3, (short) 8000);
			sh.setColumnWidth(4, (short) 4000);
			sh.setColumnWidth(5, (short) 6000);
			sh.setColumnWidth(6, (short) 6000);

			Map<String, CellStyle> styles = ImportExcelUtil.createStyles(wb);

			String[] titles = { "机构编码", "机构名称", "机构类型", "上级机构", "区域", "地址", "备注" };
			int r = 0;

			Row titleRow = sh.createRow(0);
			titleRow.setHeight((short) 450);
			for (int k = 0; k < titles.length; k++) {
				Cell cell = titleRow.createCell(k);
				cell.setCellStyle(styles.get("header"));
				cell.setCellValue(titles[k]);
			}

			++r;

			Map<String, Org> orgMap = this.allOrgList();
			List<TreeNode> areaTree = orgService.getTree(null, null);

			for (int j = 0; j < areaTree.size(); j++) {// 添加数据

				TreeNode node = areaTree.get(j);
				List<String> idList = new ArrayList<String>();
				getChildIds(node, idList);

				if (idList.size() > 0) {
					for (String id : idList) {
						Org org = orgMap.get(id);

						if (org != null) {
							Row contentRow = sh.createRow(r);
							contentRow.setHeight((short) 400);

							Cell cell1 = contentRow.createCell(0);
							cell1.setCellStyle(styles.get("cell"));
							cell1.setCellValue(org.getCode());

							Cell cell2 = contentRow.createCell(1);
							cell2.setCellStyle(styles.get("cell"));
							cell2.setCellValue(org.getName());

							Cell cell3 = contentRow.createCell(2);
							cell3.setCellStyle(styles.get("cell"));
							if (org.getType() != null) {
								String type = "";
								if (org.getType() == 1) {
									type = "通用五菱";
								} else if (org.getType() == 2) {
									type = "供应商";
								} else if (org.getType() == 3) {
									type = "实验室";
								} else if (org.getType() == 4) {
									type = "其它";
								}
								cell3.setCellValue(type);
							}

							Cell cell4 = contentRow.createCell(3);
							cell4.setCellStyle(styles.get("cell"));
							if (org.getParent() != null) {
								cell4.setCellValue(org.getParent().getName());
							}

							Cell cell5 = contentRow.createCell(4);
							cell5.setCellStyle(styles.get("cell"));
							if (org.getArea() != null) {
								cell5.setCellValue(org.getArea().getName());
							}

							Cell cell6 = contentRow.createCell(5);
							cell6.setCellStyle(styles.get("cell"));
							cell6.setCellValue(org.getAddr());

							Cell cell7 = contentRow.createCell(6);
							cell7.setCellStyle(styles.get("cell"));
							cell7.setCellValue(org.getDesc());
							r++;
						}
					}
				}
			}

			OutputStream os = response.getOutputStream();
			wb.write(os);
			os.flush();
			os.close();

		} catch (Exception e) {
			logger.error("机构列表导出失败");

			e.printStackTrace();
		}
	}

	/**
	 * 机构导入
	 */
	@ResponseBody
	@RequestMapping(value = "/import")
	public AjaxVO importUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
		AjaxVO vo = new AjaxVO();
		Account currentAccount = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

		List<String> titleList = new ArrayList<String>();
		titleList.add("机构编码");
		titleList.add("机构名称");
		titleList.add("机构类型");
		titleList.add("上级机构编码");
		titleList.add("区域编码");
		titleList.add("地址");
		titleList.add("备注");

		MultipartFile file = multipartRequest.getFile("upfile");
		if (file.isEmpty()) {
			vo.setSuccess(false);
			vo.setMsg("文件不存在");
			return vo;
		}

		try {
			InputStream in = file.getInputStream();
			List<List<Object>> execelList = new ImportExcelUtil().getBankListByExcel(in, file.getOriginalFilename());
			List<Account> createList = new ArrayList<Account>();
			List<Account> updateList = new ArrayList<Account>();
			List<Org> tempList = new ArrayList<Org>();

			if (execelList != null && execelList.size() > 0) {
				// 检查模板是否正确
				List<Object> titleObj = execelList.get(0);
				if (titleObj == null || titleObj.size() < 6) {
					vo.setSuccess(false);
					vo.setData("导入模板不正确");
					return vo;
				} else {
					boolean flag = true;

					if (!"机构编码".equals(titleObj.get(0).toString())) {
						flag = false;
					}
					if (!"机构名称".equals(titleObj.get(1).toString())) {
						flag = false;
					}
					if (flag && !"机构类型".equals(titleObj.get(2).toString())) {
						flag = false;
					}
					if (flag && !"上级机构编码".equals(titleObj.get(3).toString())) {
						flag = false;
					}
					if (flag && !"区域编码".equals(titleObj.get(4).toString())) {
						flag = false;
					}
					if (flag && !"地址".equals(titleObj.get(5).toString())) {
						flag = false;
					}
					if (flag && !"备注".equals(titleObj.get(6).toString())) {
						flag = false;
					}

					if (!flag) {
						vo.setSuccess(false);
						vo.setMsg("导入模板不正确");
						return vo;
					}
				}

				Map<String, Area> areaMap = this.allAreaByCodeList();
				Map<String, Org> orgMap = this.allOrgByCodeList();

				for (int i = 1; i < execelList.size(); i++) {
					List<Object> obj = execelList.get(i);

					if (obj.size() < 1 || obj.get(0) == null) {
						continue;
					}

					String orgCode = obj.get(0).toString();
					if (StringUtils.isBlank(orgCode)) {
						continue;
					}

					String orgName = null;
					if (obj.size() >= 2 && obj.get(1) != null) {
						orgName = obj.get(1).toString();
					}

					String type = null;
					if (obj.size() >= 3 && obj.get(2) != null) {
						type = obj.get(2).toString();
					}

					String parentOrgCode = null;
					if (obj.size() >= 4 && obj.get(3) != null) {
						parentOrgCode = obj.get(3).toString();
					}

					String areaCode = null;
					if (obj.size() >= 5 && obj.get(4) != null) {
						areaCode = obj.get(4).toString();
					}

					String address = null;
					if (obj.size() >= 6 && obj.get(5) != null) {
						address = obj.get(5).toString();
					}

					String remark = null;
					if (obj.size() >= 7 && obj.get(6) != null) {
						remark = obj.get(6).toString();
					}

					Org temp = new Org();
					temp.setCode(orgCode);
					temp.setName(orgName);

					if (StringUtils.isNotBlank(parentOrgCode)) {
						Org parent = orgMap.get(parentOrgCode);
						if (parent != null) {
							temp.setParent(parent);
						}
					}

					if (StringUtils.isNotBlank(areaCode)) {
						Area area = areaMap.get(areaCode);
						if (area != null) {
							temp.setArea(area);
						}
					}

					if (StringUtils.isNotBlank(type)) {
						if ("通用五菱".equals(type)) {
							temp.setType(1);
						} else if ("供应商".equals(type)) {
							temp.setType(2);
						} else if ("实验室".equals(type)) {
							temp.setType(3);
						} else if ("其它".equals(type)) {
							temp.setType(4);
						}
					}
					temp.setAddr(address);
					temp.setDesc(remark);
					tempList.add(temp);
				}
			}

			if (tempList.size() > 0) {
				Queue<Org> queue = new LinkedList<Org>();
				
				for (Org org : tempList) {
					if(org.getParent() == null) {
						queue.offer(org);
					} else {
						
					}
				}
			}

			if (createList.size() > 0) {
				// accountService.batchAdd(createList);
			}
			if (updateList.size() > 0) {
				// accountService.batchUpdate(updateList);
			}
			String msg = "新增：" + createList.size() + " 用户，修改：" + updateList.size() + "用户";
			vo.setMsg(msg);

		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("机构导入失败：", ex);

			vo.setMsg("导入失败，系统异常");
			vo.setSuccess(false);
			return vo;
		}
		return vo;
	}

	/**
	 * 获取所有机构信息
	 * 
	 * @return
	 */
	public Map<String, Org> allOrgList() {
		List<Org> orgList = orgService.selectAllList(new PageMap(false));
		Map<String, Org> dataMap = new HashMap<String, Org>();

		if (orgList != null && orgList.size() > 0) {
			for (Org org : orgList) {
				dataMap.put(org.getId().toString(), org);
			}
		}
		return dataMap;
	}

	/**
	 * 获取所有机构信息
	 * 
	 * @return
	 */
	public Map<String, Org> allOrgByCodeList() {
		List<Org> orgList = orgService.selectAllList(new PageMap(false));
		Map<String, Org> dataMap = new HashMap<String, Org>();

		if (orgList != null && orgList.size() > 0) {
			for (Org org : orgList) {
				dataMap.put(org.getCode(), org);
			}
		}
		return dataMap;
	}

	/**
	 * 获取所有地区信息
	 * 
	 * @return
	 */
	public Map<String, Area> allAreaList() {
		List<Area> areaList = areaService.selectAllList(new PageMap(false));
		Map<String, Area> dataMap = new HashMap<String, Area>();

		if (areaList != null && areaList.size() > 0) {
			for (Area area : areaList) {
				dataMap.put(area.getId().toString(), area);
			}
		}
		return dataMap;
	}

	/**
	 * 获取所有地区信息
	 * 
	 * @return
	 */
	public Map<String, Area> allAreaByCodeList() {
		List<Area> areaList = areaService.selectAllList(new PageMap(false));
		Map<String, Area> dataMap = new HashMap<String, Area>();

		if (areaList != null && areaList.size() > 0) {
			for (Area area : areaList) {
				dataMap.put(area.getCode(), area);
			}
		}
		return dataMap;
	}

	/**
	 * 获取当前节点中所有机构的ID
	 * 
	 * @param node
	 * @param idList
	 */
	public void getChildIds(TreeNode node, List<String> idList) {
		String id = node.getId();
		idList.add(id);

		if (node.getChildren() != null && node.getChildren().size() > 0) {
			for (TreeNode child : node.getChildren()) {
				getChildIds(child, idList);
			}
		}
	}
}
