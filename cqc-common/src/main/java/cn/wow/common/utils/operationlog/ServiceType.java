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
	ACCOUNT("Account"), 
	USER_LOGIN("User Login"),
	USER_LOGOUT("User Logout"), 
	ROLE("Role");

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
