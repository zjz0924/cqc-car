package cn.wow.common.utils.operationlog;

import java.io.Serializable;

/**
 * 
 * An enum for the different ServiceType types that exists in the MSA
 * application.
 * 
 * @author MIEP/Ericsson
 *
 */
public enum ServiceType implements Serializable {
	ACCOUNT("用户管理"), 
	USER_LOGIN("用户登录"),
	USER_LOGOUT("用户登出"), 
	ROLE("角色管理"),
	ROLE_GROUP("角色组管理"),
	ORG("机构管理"),
	AREA("区域管理"),
	MENU("菜单管理");

	private String displayName;

	ServiceType(String displayName) {
		this.displayName = displayName;
	}

	public String getDisplayName() {
		return displayName;
	}

	public static ServiceType valueOfString(String type) {
		ServiceType st = null;
		for (ServiceType t : ServiceType.values()) {
			if (t.name().equalsIgnoreCase(type)) {
				st = t;
				break;
			}
		}
		return st;
	}

}
