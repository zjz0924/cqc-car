package cn.wow.common.domain;

import java.io.Serializable;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 整车信息
 * @author zhenjunzhuo
 * 2017-09-28
 */
public class Vehicle extends JpaEntity{
	
	private static final long serialVersionUID = 7974505926589019084L;

	private Long id;
	//代码
    private String code;
    //生产时间
    private Date proTime;
    //生产基地
    private String proAddr;
    //备注
    private String remark;
    
    // 状态(0-审批中, 1-完成)
    private Integer state;
    
    private Date createTime;

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
        this.code = code == null ? null : code.trim();
    }

    public Date getProTime() {
        return proTime;
    }

    public void setProTime(Date proTime) {
        this.proTime = proTime;
    }

    public String getProAddr() {
        return proAddr;
    }

    public void setProAddr(String proAddr) {
        this.proAddr = proAddr == null ? null : proAddr.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    
	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	@JsonIgnore
	public Serializable getPrimaryKey() {
		return id;
	}
}