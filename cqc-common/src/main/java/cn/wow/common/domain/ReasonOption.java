package cn.wow.common.domain;

import java.io.Serializable;

/**
 * 抽样原因-选项
 */
public class ReasonOption implements Serializable {

	private static final long serialVersionUID = -8296488029901576532L;

	private Long id;

	private String name;

	private String remark;

	// 1-样件来源，2-抽样原因，3-费用出处
	private Integer type;

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
		this.name = name;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}