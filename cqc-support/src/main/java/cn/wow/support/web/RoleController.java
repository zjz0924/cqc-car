package cn.wow.support.web;

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
import cn.wow.common.domain.Menu;
import cn.wow.common.domain.Role;
import cn.wow.common.domain.RolePermission;
import cn.wow.common.service.AccountService;
import cn.wow.common.service.MenuService;
import cn.wow.common.service.RolePermissionService;
import cn.wow.common.service.RoleService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.support.utils.Contants;

@Controller
@RequestMapping(value = "role")
public class RoleController extends AbstractController {

	private static Logger logger = LoggerFactory.getLogger(RoleController.class);

	private final static String moduleName = Contants.ROLE;
	
	@Autowired
	private RoleService roleService;
	@Autowired
	private MenuService menuService;
	@Autowired
	private RolePermissionService rolePermissionService;
	@Autowired
	private AccountService accountService;

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest httpServletRequest, Model model) {
		List<Menu> menuList = menuService.getMenuList();

		model.addAttribute("menuList", menuList);
		return "sys/role/role_list";
	}

	@RequestMapping(value = "/data")
	@ResponseBody
	public AjaxVO data(HttpServletRequest httpServletRequest, Model model, String roleName) {
		AjaxVO vo = new AjaxVO();

		try {
			Map<String, Object> map = new PageMap(false);
			map.put("custom_order_sql", "name asc");
			if (StringUtils.isNotBlank(roleName)) {
				map.put("name", roleName);
			}
			List<Role> dataList = roleService.selectAllList(map);

			vo.setSuccess(true);
			vo.setData(dataList);
		} catch (Exception ex) {
			vo.setSuccess(false);
			vo.setMsg("系统异常，数据加载失败");
			logger.error("Failed to get role data.", ex);
		}
		return vo;
	}

	@ResponseBody
	@RequestMapping(value = "/delete")
	public AjaxVO delete(HttpServletRequest request, String id) {
		AjaxVO vo = new AjaxVO();

		if (StringUtils.isNotBlank(id)) {
			int num = roleService.deleteByPrimaryKey(getCurrentUserName(), Long.parseLong(id));

			if (num > 0) {
				getResponse(vo, Contants.SUC_DELETE);
			} else {
				getResponse(vo, Contants.FAIL_DELETE);
			}
		} else {
			getResponse(vo, Contants.FAIL_DELETE);
		}

		return vo;
	}

	@ResponseBody
	@RequestMapping(value = "/rolePermission")
	public AjaxVO rolePermission(HttpServletRequest request, String id) {
		AjaxVO vo = new AjaxVO();

		if (StringUtils.isNotBlank(id)) {
			RolePermission permission = rolePermissionService.selectOne(Long.parseLong(id));

			vo.setData(permission);
			vo.setSuccess(true);
		} else {
			vo.setSuccess(false);
			vo.setMsg("系统异常，获取角色权限失败");
		}
		return vo;
	}

	@ResponseBody
	@RequestMapping(value = "/addRole")
	public AjaxVO addRole(HttpServletRequest request, String id, String name, String permission) {
		AjaxVO vo = new AjaxVO();
		vo.setMsg("保存成功");
		List<Role> roleList = getRoleListByName(name);

		try {
			RolePermission rolePermission = null;
			Role role = null;

			if (StringUtils.isNotBlank(id)) {
				if (roleList != null && roleList.size() > 0
						&& roleList.get(0).getId().longValue() != Long.parseLong(id)) {
					vo.setSuccess(false);
					vo.setMsg("角色名已存在");
				}else{
					role = roleService.selectOne(Long.parseLong(id));
					role.setName(name);

					String oldPermission = "";
					rolePermission = rolePermissionService.selectOne(Long.parseLong(id));
					if (rolePermission == null) {
						rolePermission = new RolePermission();
						rolePermission.setRoleId(role.getId());
					}
					oldPermission = rolePermission.getPermission();
					rolePermission.setPermission(permission);

					roleService.updateRole(getCurrentUserName(), role, rolePermission);
					logger.info("update role [ " + name + " ], old permission [ "+ oldPermission +" ] ,  new permission [ " + permission +" ]");
				}
			} else {
				if (roleList != null && roleList.size() > 0){
					vo.setSuccess(false);
					vo.setMsg("角色名已存在");
				}else{
					role = new Role(name);
					role.setPermission(permission);
					rolePermission = new RolePermission(permission);
					
					roleService.createRole(getCurrentUserName(), role, rolePermission);
					logger.info("create role [ " + name + " ], the permission [ " + permission +" ]");
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			vo.setMsg("系统异常，保存失败");
			vo.setSuccess(false);
			logger.error("Failed to add role.", ex);
		}
		return vo;
	}

	@ResponseBody
	@RequestMapping(value = "/deleteRole")
	public AjaxVO deleteRole(HttpServletRequest request, Long roleId) {
		AjaxVO vo = new AjaxVO();
		vo.setMsg("删除成功");

		try {
			Map<String, Object> map = new PageMap(false);
			map.put("roleId", roleId);
			List<Account> accountList = accountService.selectAllList(map);

			if (accountList == null || accountList.size() < 1) {
				Role role = roleService.selectOne(roleId);
				roleService.deleteRole(getCurrentUserName(), role);
			} else {
				vo.setSuccess(false);
				vo.setMsg("删除失败，当前角色正在使用中");
			}
		} catch (Exception ex) {
			ex.printStackTrace();

			vo.setSuccess(false);
			vo.setMsg("系统异常，无法删除");
			logger.error("Failed to delete role.", ex);
		}
		return vo;
	}

	public List<Role> getRoleListByName(String name) {
		Map<String, Object> map = new PageMap(false);
		map.put("name", name);
		List<Role> roleList = roleService.selectAllList(map);
		return roleList;
	}

}