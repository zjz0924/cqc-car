package cn.wow.common.domain;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 零部件信息
 * @author zhenjunzhuo
 * 2017-09-29
 */
public class Parts extends JpaEntity{
	
	private static final long serialVersionUID = 7726615942307878232L;
	
	private Long id;
    // 类型（1-基准， 2-抽样）
    private Integer type;
    // 代码
    private String code;
    // 名称
    private String name;
    // 生产商
    private String producer;
    // 生产日期
    private Date proTime;
    // 生产场地
    private String place;
    // 生产批次
    private String proNo;
    // 生产工艺
    private String technology;
    // 材料名称 
    private String matName;
    // 材料牌号
    private String matNo;
    // 材料颜色
    private String matColor;
    // 材料生产商
    private String matProducer;
    // 图片
    private String pic;
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

    public String getProducer() {
        return producer;
    }

    public void setProducer(String producer) {
        this.producer = producer == null ? null : producer.trim();
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

    public String getTechnology() {
        return technology;
    }

    public void setTechnology(String technology) {
        this.technology = technology == null ? null : technology.trim();
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

    public String getMatProducer() {
        return matProducer;
    }

    public void setMatProducer(String matProducer) {
        this.matProducer = matProducer == null ? null : matProducer.trim();
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic == null ? null : pic.trim();
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