package cn.wow.common.domain;

import java.io.Serializable;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 机构
 */
public class Org extends JpaEntity {
	
	private static final long serialVersionUID = -5541816906077899811L;

	private Long id;

    private String name;

    private String code;

    private Long areaid;
    
    private Area area;

    private String desc;

    private Long parentid;
    
    private Org parent;
    
    @JsonIgnore
    private List<Org> subList;

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

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code == null ? null : code.trim();
    }

    public Long getAreaid() {
        return areaid;
    }

    public void setAreaid(Long areaid) {
        this.areaid = areaid;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc == null ? null : desc.trim();
    }

    public Long getParentid() {
        return parentid;
    }

    public void setParentid(Long parentid) {
        this.parentid = parentid;
    }
    
    public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}

	public Org getParent() {
		return parent;
	}

	public void setParent(Org parent) {
		this.parent = parent;
	}

	public List<Org> getSubList() {
		return subList;
	}

	public void setSubList(List<Org> subList) {
		this.subList = subList;
	}

	@JsonIgnore
	public Serializable getPrimaryKey() {
		return id;
	}
}