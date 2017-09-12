package cn.wow.support.web;

import java.util.Date;
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
import cn.wow.common.domain.Account;
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

	private final static String moduleName = Contants.ACCOUNT;

	@Autowired
	private AccountService accountService;
	@Autowired
	private RoleService roleService;

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest httpServletRequest, Model model, String userName, String nickName,
			String mobile, String startCreateTime, String endCreateTime, String lock) {
		Map<String, Object> map = new PageMap(httpServletRequest);

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
		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime + " 00:00:00");
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime + " 23:59:59");
		}
		List<Account> dataList = accountService.selectAllList(map);

		model.addAttribute("dataList", dataList);

		model.addAttribute("userName", userName);
		model.addAttribute("nickName", nickName);
		model.addAttribute("mobile", mobile);
		model.addAttribute("lock", lock);
		model.addAttribute("startCreateTime", startCreateTime);
		model.addAttribute("endCreateTime", endCreateTime);
		model.addAttribute("permission", getPermission(httpServletRequest, moduleName));
		return "sys/account/account_list";
	}

	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id) {
		if (StringUtils.isNotBlank(id)) {
			Account account = accountService.selectOne(Long.parseLong(id));
			model.addAttribute("facadeBean", account);
		}

		model.addAttribute("mode", request.getParameter("mode"));
		model.addAttribute("roleList", getAllRole());
		return "sys/account/account_detail";
	}

	@RequestMapping(value = "/save")
	public String save(HttpServletRequest request, Model model, String id, String userName, String nickName,
			String mobile, String password, Long roleId) {

		String resultCode = "";
		String resultMsg = "";
		Account account = null;

		try {
			if (StringUtils.isNotBlank(id)) {
				account = accountService.selectOne(Long.parseLong(id));

				account.setRoleId(roleId);
				account.setMobile(mobile);
				account.setNickName(nickName);
				accountService.update(getCurrentUserName(), account);

				resultCode = Contants.EDIT_SUCCESS;
				resultMsg = Contants.EDIT_SUCCESS_MSG;
			} else {
				Map<String, Object> rMap = new HashMap<String, Object>();
				rMap.put("userName", userName);
				List<Account> userList = accountService.selectAllList(rMap);

				if (userList != null && userList.size() > 0) {
					resultCode = Contants.SAVE_FAIL;
					resultMsg = Contants.SAVE_FAIL_MSG + "，用户名已存在";
				} else {
					account = new Account();
					account.setUserName(userName);
					account.setPassword(MD5.getMD5(password, "utf-8").toUpperCase());
					account.setMobile(mobile);
					account.setNickName(nickName);
					account.setRoleId(roleId);
					account.setCreateTime(new Date());
					accountService.save(getCurrentUserName(), account);

					resultCode = Contants.SAVE_SUCCESS;
					resultMsg = Contants.SAVE_SUCCESS_MSG;
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			resultCode = Contants.EXCEPTION;
			resultMsg = Contants.EXCEPTION_MSG;
			model.addAttribute("roleList", getAllRole());
		}

		model.addAttribute("resultCode", resultCode);
		model.addAttribute("resultMsg", resultMsg);
		model.addAttribute("facadeBean", account);
		return "sys/account/account_detail";
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
	 * 重置密码 （新密码=账号（小写）+ 后4位电话号码）
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
					String password = account.getUserName().toLowerCase();
					if (StringUtils.isNotBlank(account.getMobile())) {
						password += account.getMobile().substring(7);
					}
					String newPwd = MD5.getMD5(password, "utf-8").toUpperCase();

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

	public List<Role> getAllRole() {
		Map<String, Object> map = new PageMap(false);
		return roleService.selectAllList(map);
	}

}
