package cn.wow.common.domain;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 零件信息
 * @author zhenjunzhuo
 * 2017-09-29
 */
public class Parts extends JpaEntity{
	
	private static final long serialVersionUID = 7726615942307878232L;
	
	private Long id;
    // 类型（1-基准， 2-抽样）
    private Integer type;
    // 零件图号
    private String code;
    // 零件名称
    private String name;
    // 供应商
    private String producer;
    // 供应商代码
    private String producerCode;
    // 生产日期
    private Date proTime;
    // 样件数量
    private Integer num;
    // 生产场地
    private String place;
    // 样件批号
    private String proNo;
    // 备注
    private String remark;
    // 状态(0-审批中, 1-完成，2-弃用)
    private Integer state;
    
    private Date createTime;
    
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code == null ? null : code.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Date getProTime() {
        return proTime;
    }

    public void setProTime(Date proTime) {
        this.proTime = proTime;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place == null ? null : place.trim();
    }

    public String getProNo() {
        return proNo;
    }

    public void setProNo(String proNo) {
        this.proNo = proNo == null ? null : proNo.trim();
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
	
	public String getProducer() {
		return producer;
	}

	public void setProducer(String producer) {
		this.producer = producer == null ? null : producer.trim();
	}
	
	public String getProducerCode() {
		return producerCode;
	}

	public void setProducerCode(String producerCode) {
		this.producerCode = producerCode == null ? null : producerCode.trim();
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	@JsonIgnore
	public Serializable getPrimaryKey() {
		return id;
	}
}