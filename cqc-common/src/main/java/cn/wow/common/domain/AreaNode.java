package cn.wow.common.domain;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

/**
 * 区域树节点
 */
public class AreaNode implements Serializable {

	private static final long serialVersionUID = -3120773122177211682L;

	public String id;

	@JsonInclude(Include.NON_NULL)
	public String parent;

	public String text;
	
	@JsonInclude(Include.NON_NULL)
	public List<AreaNode> children;

	@JsonInclude(Include.NON_NULL)
	public String icon;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getParent() {
		return parent;
	}

	public void setParent(String parent) {
		this.parent = parent;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public List<AreaNode> getChildren() {
		return children;
	}

	public void setChildren(List<AreaNode> children) {
		this.children = children;
	}
	
	

}
