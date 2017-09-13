package cn.wow.common.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 区域
 */
public class Area extends JpaEntity{
	
	private static final long serialVersionUID = -5450900564575959225L;

	private Long id;

    private String name;
    // 父区域
    private Long parentid;
    
    private Area parentArea;

    private String desc;

    private Date createTime;
    // 子区域
    @JsonIgnore
    private List<Area> subList;

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

    public Long getParentid() {
        return parentid;
    }

    public void setParentid(Long parentid) {
        this.parentid = parentid;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc == null ? null : desc.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    
	public List<Area> getSubList() {
		return subList;
	}

	public void setSubList(List<Area> subList) {
		this.subList = subList;
	}
	
	public Area getParentArea() {
		return parentArea;
	}

	public void setParentArea(Area parentArea) {
		this.parentArea = parentArea;
	}

	 @JsonIgnore
	public Serializable getPrimaryKey() {
		return id;
	}
}