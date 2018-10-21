package cn.wow.common.domain;

import java.io.Serializable;

public class Reason implements Serializable {

	private static final long serialVersionUID = 3041309943190033877L;
	
	private Long id;
	// 样件来源
	private String origin;
	// 抽样原因
	private String reason;
	// 试验费用出处
	private String source;
	// 备注
	private String remark;
	// 其他原因描述
	private String otherRemark;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getOtherRemark() {
		return otherRemark;
	}

	public void setOtherRemark(String otherRemark) {
		this.otherRemark = otherRemark;
	}
	
	
}
