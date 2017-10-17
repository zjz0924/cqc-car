package cn.wow.common.domain;

import java.util.Date;

/**
 * 任务
 * @author zhenjunzhuo
 * 2017-10-13
 */
public class Task {
	
    private Long id;
    // 任务号
    private String code;
    // 信息ID
    private Long iId;
    private Info info;
    // 申请机构ID
    private Long orgId;
    private Org org;
    // 申请人
    private Long aId;
    private Account account;
    // 类型(1-OTS、2-PPAP、3-SOP、4-材料研究所任务)
    private Integer type;
    
    /** 
     * 	状态：
     *  OTS、材料研究所任务： 1-审核中，2-下达中，3-审批中，4-结果上传中，5-结果发送中，6-结果确认中，7-完成
     *  PPAP、SOP： 1-下达中，2-审批中，3-结果上传中，4-结果比对中，5-结果发送中，6-结果确认中，7-完成
     */
    private Integer state;
    // 图谱实验室ID
    private Long atlasLab; 
    private Org atlas;
    // 图谱上传结果 (0-未上传，1-已上传)
    private Integer atlasResult;
    // 型式实验室ID
    private Long patternLab;
    private Org pattern;
    // 型式上传结果(0-未上传，1-已上传) 
    private Integer patternResult;
    // 结果确认失败次数
    private Integer failNum;
    // 备注
    private String remark;
    // 创建时间
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

    public Long getiId() {
        return iId;
    }

    public void setiId(Long iId) {
        this.iId = iId;
    }

    public Long getOrgId() {
        return orgId;
    }

    public void setOrgId(Long orgId) {
        this.orgId = orgId;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Long getAtlasLab() {
		return atlasLab;
	}

	public void setAtlasLab(Long atlasLab) {
		this.atlasLab = atlasLab;
	}

	public Long getPatternLab() {
		return patternLab;
	}

	public void setPatternLab(Long patternLab) {
		this.patternLab = patternLab;
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

	public Info getInfo() {
		return info;
	}

	public void setInfo(Info info) {
		this.info = info;
	}

	public Integer getFailNum() {
		return failNum;
	}

	public void setFailNum(Integer failNum) {
		this.failNum = failNum;
	}

	public Org getOrg() {
		return org;
	}

	public void setOrg(Org org) {
		this.org = org;
	}

	public Long getaId() {
		return aId;
	}

	public void setaId(Long aId) {
		this.aId = aId;
	}

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

	public Org getAtlas() {
		return atlas;
	}

	public void setAtlas(Org atlas) {
		this.atlas = atlas;
	}

	public Org getPattern() {
		return pattern;
	}

	public void setPattern(Org pattern) {
		this.pattern = pattern;
	}

	public Integer getAtlasResult() {
		return atlasResult;
	}

	public void setAtlasResult(Integer atlasResult) {
		this.atlasResult = atlasResult;
	}

	public Integer getPatternResult() {
		return patternResult;
	}

	public void setPatternResult(Integer patternResult) {
		this.patternResult = patternResult;
	}
}