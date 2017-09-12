package cn.wow.common.domain;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class Role extends JpaEntity{
	
	private static final long serialVersionUID = 5632083155878693998L;

	private Long id;

    private String name;
    
    private String permission;

    public Role(){
    	
    }
    
    public Role(String name){
    	this.name = name;
    }
    
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
    
    public String getPermission() {
		return permission;
	}

	public void setPermission(String permission) {
		this.permission = permission;
	}

	@JsonIgnore
	public Serializable getPrimaryKey() {
		return id;
	}
    
}