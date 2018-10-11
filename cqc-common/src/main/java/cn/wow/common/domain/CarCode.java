package cn.wow.common.domain;

import java.io.Serializable;

/**
 * 车型代码
 */
public class CarCode extends JpaEntity{
	
	private static final long serialVersionUID = -6260606811779602759L;

	private Long id;

    private String code;
    
    private String remark;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Override
	public Serializable getPrimaryKey() {
		return this.id;
	}
	
	
}