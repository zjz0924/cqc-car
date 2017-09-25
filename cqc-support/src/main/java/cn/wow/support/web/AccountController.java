package cn.wow.support.web;

import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.github.pagehelper.Page;
import cn.wow.common.domain.Account;
import cn.wow.common.domain.Org;
import cn.wow.common.domain.Role;
import cn.wow.common.service.AccountService;
import cn.wow.common.service.RoleService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.cookie.MD5;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.support.utils.Contants;

/**
 * 用户控制器
 * 
 * @author zhenjunzhuo 2016-12-20
 */
@Controller
@RequestMapping(value = "account")
public class AccountController extends AbstractController {

	Logger logger = LoggerFactory.getLogger(AccountController.class);

	private final static String defaultPageSize = "20";

	@Autowired
	private AccountService accountService;
	@Autowired
	private RoleService roleService;

	private List<Account> data = new ArrayList<Account>();

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest httpServletRequest, Model model) {
		model.addAttribute("defaultPageSize", defaultPageSize);
		return "sys/account/account_list";
	}

	/**
	 * 获取数据
	 */
	@ResponseBody
	@RequestMapping(value = "/getList")
	public Map<String, Object> getList(HttpServletRequest request, Model model, String userName, String nickName,
			String mobile, String startCreateTime, String endCreateTime, String lock, String orgId, String roleId) {

		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", defaultPageSize);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "username asc");

		if (StringUtils.isNotBlank(userName)) {
			map.put("userName", userName);
		}
		if (StringUtils.isNotBlank(nickName)) {
			map.put("nickName", nickName);
		}
		if (StringUtils.isNotBlank(lock)) {
			map.put("lock", lock);
		}
		if (StringUtils.isNotBlank(mobile)) {
			map.put("mobile", mobile);
		}
		if (StringUtils.isNotBlank(orgId)) {
			map.put("orgId", orgId);
		}
		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime + " 00:00:00");
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime + " 23:59:59");
		}

		List<Account> dataList = accountService.selectAllList(map);

		if (dataList != null && dataList.size() > 0) {
			for (Account account : dataList) {
				if (StringUtils.isNotBlank(account.getRoleId())) {
					List<Role> roleList = roleService.selectRoles(account.getRoleIds());
					account.setRoleList(roleList);
				}
			}
		}

		data = dataList;

		// 分页
		Page<Account> pageList = (Page<Account>) dataList;

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("total", pageList.getTotal());
		dataMap.put("rows", pageList.getResult());

		return dataMap;
	}

	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id) {
		if (StringUtils.isNotBlank(id)) {
			String roleVal = "";
			Account account = accountService.selectOne(Long.parseLong(id));

			Org org = account.getOrg();
			if (org != null) {
				model.addAttribute("orgId", org.getId());
				model.addAttribute("orgName", org.getName());
			}

			if (StringUtils.isNotBlank(account.getRoleId())) {
				List<Role> roleList = roleService.selectRoles(account.getRoleIds());

				if (roleList != null && roleList.size() > 0) {
					for (int i = 0; i < roleList.size(); i++) {
						Role role = roleList.get(i);
						if (i != roleList.size() - 1) {
							roleVal += "{ id: 'r_" + role.getId() + "', text: '" + role.getName() + "'},";
						} else {
							roleVal += "{ id: 'r_" + role.getId() + "', text: '" + role.getName() + "'}";
						}
					}
					roleVal = "[" + roleVal + "]";
				}
			}

			model.addAttribute("roleVal", roleVal);
			model.addAttribute("facadeBean", account);
		}
		return "sys/account/account_detail";
	}

	@ResponseBody
	@RequestMapping(value = "/save")
	public AjaxVO save(HttpServletRequest request, Model model, String id, String userName, String nickName,
			String mobile, String password, String roleId, Long orgId, String email) {
		AjaxVO vo = new AjaxVO();
		Account account = null;

		try {
			if (StringUtils.isNotBlank(id)) {
				account = accountService.selectOne(Long.parseLong(id));

				if (account != null) {
					account.setRoleId(roleId);
					account.setMobile(mobile);
					account.setNickName(nickName);
					account.setEmail(email);
					account.setOrgId(orgId);
					accountService.update(getCurrentUserName(), account);
				}
				vo.setMsg("编辑成功");
			} else {
				Map<String, Object> rMap = new HashMap<String, Object>();
				rMap.put("userName", userName);
				List<Account> userList = accountService.selectAllList(rMap);

				if (userList != null && userList.size() > 0) {
					vo.setData("userName");
					vo.setMsg("用户名已经存在");
					vo.setSuccess(false);
					return vo;
				} else {
					account = new Account();
					account.setUserName(userName);
					account.setPassword(MD5.getMD5(password, "utf-8").toUpperCase());
					account.setMobile(mobile);
					account.setNickName(nickName);
					account.setRoleId(roleId);
					account.setCreateTime(new Date());
					account.setEmail(email);
					account.setOrgId(orgId);
					accountService.save(getCurrentUserName(), account);

					vo.setMsg("新增成功");
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();

			logger.error("用户保存失败", ex);
			vo.setMsg("保存失败，系统异常");
			vo.setSuccess(false);
			return vo;
		}
		return vo;
	}

	@ResponseBody
	@RequestMapping(value = "/delete")
	public AjaxVO delete(HttpServletRequest request, String id) {
		AjaxVO vo = new AjaxVO();

		try {
			if (StringUtils.isNotBlank(id)) {
				Account account = accountService.selectOne(Long.parseLong(id));

				if (account != null) {
					int num = accountService.deleteByPrimaryKey(getCurrentUserName(), account);

					if (num > 0) {
						getResponse(vo, Contants.SUC_DELETE);
					} else {
						getResponse(vo, Contants.FAIL_DELETE);
					}
				} else {
					getResponse(vo, Contants.FAIL_DELETE);
				}
			} else {
				getResponse(vo, Contants.FAIL_DELETE);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			getResponse(vo, Contants.EXCEP);
		}
		return vo;
	}

	/**
	 * 锁定/解锁用户
	 * 
	 * @param id
	 * @param lock
	 */
	@ResponseBody
	@RequestMapping(value = "/lock")
	public AjaxVO lock(HttpServletRequest request, String id, String lock) {
		AjaxVO vo = new AjaxVO();

		try {
			if (StringUtils.isNotBlank(id)) {
				Account account = accountService.selectOne(Long.parseLong(id));

				if (account != null) {
					account.setLock(lock);
					accountService.update(getCurrentUserName(), account);

					getResponse(vo, Contants.SUC_EDIT);
				} else {
					getResponse(vo, Contants.FAIL_EDIT);
				}
			} else {
				getResponse(vo, Contants.FAIL_EDIT);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			getResponse(vo, Contants.EXCEP);
		}
		return vo;
	}

	/**
	 * 重置密码 （默认密码888888）
	 * 
	 * @param id
	 */
	@ResponseBody
	@RequestMapping(value = "/resetPwd")
	public AjaxVO resetPwd(HttpServletRequest request, String id, String lock) {
		AjaxVO vo = new AjaxVO();

		try {
			if (StringUtils.isNotBlank(id)) {
				Account account = accountService.selectOne(Long.parseLong(id));

				if (account != null) {
					String newPwd = MD5.getMD5("888888", "utf-8").toUpperCase();

					account.setPassword(newPwd);
					accountService.update(getCurrentUserName(), account);

					getResponse(vo, true, "密码重置成功");
				} else {
					getResponse(vo, false, "密码重置失败");
				}
			} else {
				getResponse(vo, false, "密码重置失败");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			getResponse(vo, Contants.EXCEP);
		}
		return vo;
	}

	@RequestMapping(value = "/changePwd")
	public String changePwd(HttpServletRequest request, Model model) {
		return "sys/account/account_changepwd";
	}

	@ResponseBody
	@RequestMapping(value = "/updatePwd")
	public AjaxVO updatePwd(HttpServletRequest request, String oldPwd, String newPwd) {
		AjaxVO vo = new AjaxVO();
		Account currentAccount = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);

		try {
			if (currentAccount != null) {
				oldPwd = MD5.getMD5(oldPwd, "utf-8").toUpperCase();
				if (!oldPwd.equals(currentAccount.getPassword())) {
					return new AjaxVO("修改失败，原密码不正确", false);
				}

				newPwd = MD5.getMD5(newPwd, "utf-8").toUpperCase();
				currentAccount.setPassword(newPwd);
				accountService.update(getCurrentUserName(), currentAccount);

				getResponse(vo, true, "密码修改成功，请重新登录");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			getResponse(vo, Contants.EXCEP);
		}
		return vo;
	}

	@RequestMapping(value = "/exportUser")
	public void exportUser(HttpServletRequest request, HttpServletResponse response) {
		String filename = "用户清单";

		try {
			// 设置头
			setResponseHeader(response, filename + ".xlsx");

			Workbook wb = new SXSSFWorkbook(100); // 保持100条在内存中，其它保存到磁盘中
			// 工作簿
			Sheet sh = wb.createSheet("用户清单");

			Map<String, CellStyle> styles = createStyles(wb);

			String[] titles = { "用户名", "姓名", "手机号码", "机构名称", "角色", "邮箱", "状态", "创建时间" };
			String[] engTitles = { "userName", "nickName", "mobile", "orgName", "roleName", "email", "lock",
					"createTime" };
			int r = 0;

			sh.setColumnWidth(0, (short) 6000);
			sh.setColumnWidth(1, (short) 6000);
			sh.setColumnWidth(2, (short) 6000);
			sh.setColumnWidth(3, (short) 6000);
			sh.setColumnWidth(4, (short) 6000);
			sh.setColumnWidth(5, (short) 6000);
			sh.setColumnWidth(6, (short) 6000);
			sh.setColumnWidth(7, (short) 6000);

			for (int j = 0; j <= data.size(); j++) {// 添加数据
				Row contentRow = sh.createRow(r);
				Account account = data.get(j);

				for (int i = 0; i < engTitles.length; i++) {
					Cell cell1 = contentRow.createCell(0);
					cell1.setCellStyle(styles.get("cell"));
					cell1.setCellValue(account.getUserName());

					Cell cell2 = contentRow.createCell(1);
					cell2.setCellStyle(styles.get("cell"));
					cell2.setCellValue(account.getNickName());

					Cell cell3 = contentRow.createCell(2);
					cell3.setCellStyle(styles.get("cell"));
					cell3.setCellValue(account.getMobile());

					Cell cell4 = contentRow.createCell(3);
					cell4.setCellStyle(styles.get("cell"));
					cell4.setCellValue(account.getOrg().getName());

					String roleStr = "";
					List<Role> roleList = roleService.selectRoles(account.getRoleIds());

					if (roleList != null && roleList.size() > 0) {
						for (int k = 0; i < roleList.size(); i++) {
							Role role = roleList.get(k);
							if (k != roleList.size() - 1) {
								roleStr += role.getName() + ",";
							} else {
								roleStr += role.getName();
							}
						}
					}
					Cell cell5 = contentRow.createCell(4);
					cell5.setCellStyle(styles.get("cell"));
					cell5.setCellValue(roleStr);

					Cell cell6 = contentRow.createCell(5);
					cell6.setCellStyle(styles.get("cell"));
					cell6.setCellValue(account.getEmail());

					String lock = "正常";
					if (account.getLock() == "Y") {
						lock = "锁定";
					}
					Cell cell7 = contentRow.createCell(6);
					cell7.setCellStyle(styles.get("cell"));
					cell7.setCellValue(lock);

					Cell cell8 = contentRow.createCell(7);
					cell8.setCellStyle(styles.get("cell"));
					cell8.setCellValue(account.getCreateTime());
				}
				r++;
			}

			OutputStream os = response.getOutputStream();
			wb.write(os);
			os.flush();
			os.close();
		} catch (Exception e) {
			logger.error("用户清单导出失败");
		}
	}

	/**
	 * 设置头
	 * 
	 * @param response
	 * @param fileName
	 */
	public void setResponseHeader(HttpServletResponse response, String fileName) {
		try {
			fileName = new String(fileName.getBytes(), "ISO8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		response.setContentType("application/octet-stream;charset=ISO8859-1");
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
		response.addHeader("Pargam", "no-cache");
		response.addHeader("Cache-Control", "no-cache");
	}

	/**
	 * 样式
	 */
	private Map<String, CellStyle> createStyles(org.apache.poi.ss.usermodel.Workbook wb) {

		Map<String, CellStyle> styles = new HashMap<String, CellStyle>();
		CellStyle style;

		style = wb.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		styles.put("header", style);

		style = wb.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		styles.put("cell", style);

		return styles;
	}

}
