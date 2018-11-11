package cn.wow.common.domain;

import java.io.Serializable;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonIgnore;


/**
 * 零件材料信息
 * @author zhenjunzhuo
 * 2017-09-30
 */
public class Material extends JpaEntity{
	
	private static final long serialVersionUID = 5960296191241326092L;

	private Long id;
	 // 类型（1-基准， 2-抽样）
    private Integer type;
    // 材料名称
    private String matName;
    // 材料牌号
    private String matNo;
    // 供应商
    private String producer;
    // 材料颜色
    private String matColor;
    // 材料批号
    private String proNo;
    // 样品数量
    private Integer num;
    // 备注
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

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getMatName() {
        return matName;
    }

    public void setMatName(String matName) {
        this.matName = matName == null ? null : matName.trim();
    }

    public String getMatNo() {
        return matNo;
    }

    public void setMatNo(String matNo) {
        this.matNo = matNo == null ? null : matNo.trim();
    }

    public String getMatColor() {
        return matColor;
    }

    public void setMatColor(String matColor) {
        this.matColor = matColor == null ? null : matColor.trim();
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