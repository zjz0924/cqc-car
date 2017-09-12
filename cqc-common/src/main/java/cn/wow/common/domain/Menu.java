package cn.wow.common.domain;

import java.io.Serializable;
import java.util.List;

public class Menu implements Serializable{
	
	private static final long serialVersionUID = -7677318918671654590L;

	private Long id;

    private String name;

    private String url;

    private String logo;

    private Long pId;

    private Integer sortNum;
    
    private String isParent;
    
    private List<Menu> subList;
    //菜单别名，用来设置权限，必须唯一
    private String alias;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo == null ? null : logo.trim();
    }

    public Long getpId() {
        return pId;
    }

    public void setpId(Long pId) {
        this.pId = pId;
    }

    public Integer getSortNum() {
        return sortNum;
    }

    public void setSortNum(Integer sortNum) {
        this.sortNum = sortNum;
    }

	public String getIsParent() {
		return isParent;
	}

	public void setIsParent(String isParent) {
		this.isParent = isParent;
	}

	public List<Menu> getSubList() {
		return subList;
	}

	public void setSubList(List<Menu> subList) {
		this.subList = subList;
	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}
}