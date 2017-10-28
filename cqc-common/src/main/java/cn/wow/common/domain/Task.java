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
     *  OTS、材料研究所任务： 1-审核中，2-下达中，3-审批中，4-结果上传中，5-结果发送中，6-结果确认中，7-收费通知中，8-完成
     *  PPAP、SOP： 1-下达中，2-审批中，3-结果上传中，4-结果比对中，5-结果发送中，6-结果确认中，7-收费通知中，8-完成
     */
    private Integer state;
   
    
    // 零部件图谱实验室ID
    private Long partsAtlId; 
    private Org partsAtl;
    
    // 原材料图谱实验室ID
    private Long matAtlId;
    private Org matAtl;
    
    // 零部件型式实验室ID
    private Long partsPatId;
    private Org partsPat;
    
    // 原材料型式实验室ID
    private Long matPatId;
    private Org matPat;
    
    // 结果确认失败次数
    private Integer failNum;
    // 备注
    private String remark;
    // 创建时间
    private Date createTime;
    
    // 零部件图谱结果(0-未上传，1-已上传，2-已发送，3-合格，4-不合格)
    private Integer partsAtlResult;
    // 原材料图谱结果(0-未上传，1-已上传，2-已发送，3-合格，4-不合格)
    private Integer matAtlResult;
    // 零部件型式结果 (0-未上传，1-已上传，2-已发送，3-合格，4-不合格)
    private Integer partsPatResult;
    // 原材料型式结果(0-未上传，1-已上传，2-已发送，3-合格，4-不合格) 
    private Integer matPatResult;
    
    
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

	public Integer getPartsAtlResult() {
		return partsAtlResult;
	}

	public void setPartsAtlResult(Integer partsAtlResult) {
		this.partsAtlResult = partsAtlResult;
	}

	public Integer getMatAtlResult() {
		return matAtlResult;
	}

	public void setMatAtlResult(Integer matAtlResult) {
		this.matAtlResult = matAtlResult;
	}

	public Integer getPartsPatResult() {
		return partsPatResult;
	}

	public void setPartsPatResult(Integer partsPatResult) {
		this.partsPatResult = partsPatResult;
	}

	public Integer getMatPatResult() {
		return matPatResult;
	}

	public void setMatPatResult(Integer matPatResult) {
		this.matPatResult = matPatResult;
	}

	public Long getPartsAtlId() {
		return partsAtlId;
	}

	public void setPartsAtlId(Long partsAtlId) {
		this.partsAtlId = partsAtlId;
	}

	public Org getPartsAtl() {
		return partsAtl;
	}

	public void setPartsAtl(Org partsAtl) {
		this.partsAtl = partsAtl;
	}

	public Long getMatAtlId() {
		return matAtlId;
	}

	public void setMatAtlId(Long matAtlId) {
		this.matAtlId = matAtlId;
	}

	public Org getMatAtl() {
		return matAtl;
	}

	public void setMatAtl(Org matAtl) {
		this.matAtl = matAtl;
	}

	public Long getPartsPatId() {
		return partsPatId;
	}

	public void setPartsPatId(Long partsPatId) {
		this.partsPatId = partsPatId;
	}

	public Org getPartsPat() {
		return partsPat;
	}

	public void setPartsPat(Org partsPat) {
		this.partsPat = partsPat;
	}

	public Long getMatPatId() {
		return matPatId;
	}

	public void setMatPatId(Long matPatId) {
		this.matPatId = matPatId;
	}

	public Org getMatPat() {
		return matPat;
	}

	public void setMatPat(Org matPat) {
		this.matPat = matPat;
	}
	
}