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
    // 填写机构ID
    private Long orgId;
    private Org org;
    // 填写人
    private Long aId;
    private Account account;
    // 类型(1-OTS、2-PPAP、3-SOP、4-材料研究所任务)
    private Integer type;
    
    // 父任务ID
    private Long tId;
    
    /** 
     * 	状态：
     *  OTS、材料研究所任务： 1-审核中，2-审核不通过，3-试验中，4-完成，5-申请修改，6-申请不通过
     *  PPAP、SOP： 1-审批中，2-审批不通过，3-结果上传中，4-结果比对中，5-结果发送中，6-结果确认中，7-完成，8-申请修改，9-申请不通过，10-确认是否二次抽样，11-中止任务
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
    // 确认时间
    private Date confirmTime;
    
    // 零部件图谱结果(0-待处理，1-未上传，2-已上传，3-已发送，4-接收，5-不接收， 6-审批不通过)
    private Integer partsAtlResult;
    // 原材料图谱结果(0-待处理，1-未上传，2-已上传，3-已发送，4-接收，5-不接收， 6-审批不通过)
    private Integer matAtlResult;
    // 零部件型式结果 (0-待处理，1-未上传，2-已上传，3-已发送，4-接收，5-不接收， 6-审批不通过)
    private Integer partsPatResult;
    // 原材料型式结果(0-待处理，1-未上传，2-已上传，3-已发送，4-接收，5-不接收， 6-审批不通过) 
    private Integer matPatResult;
    
    // 零部件图谱实验次数
    private Integer partsAtlTimes;
    // 原材料图谱实验次数
    private Integer matAtlTimes;
    // 零部件型式实验次数
    private Integer partsPatTimes;
    // 原材料型式实验次数
    private Integer matPatTimes;
    
    // 是否申请修改信息（0-否， 1-等待审批）
    private Integer infoApply;
    // 是否申请修改试验结果（0-否，1-等待审批，2-子任务等待审批）
    private Integer resultApply;
    
    // 结果（1-合格，2-不合格）
    private Integer result;
    
    // 是否接收（1-接收，2-不接收）
    private Integer isReceive;
    
    // 零部件图谱实验编号
    private String partsAtlCode;
    
    // 原材料图谱实验编号
    private String matAtlCode;
    
    // 零部件型式实验编号
    private String partsPatCode;
    
    // 原材料型式实验编号
    private String matPatCode;
    
    // PPAP和SOP 任务信息
    private TaskInfo taskInfo;
    
    // 是否是草稿（0-否，1-是）
    private Integer draft;
    
    // 基准图谱类型（1-零件基准图谱，2-材料基准图谱， 3-材料型式试验，4-零件型式试验）
    private Integer atlType;
    
    // 基准图谱备注
    private String atlRemark;
    
    // 期望完成时间
    private Date expectDate;
    
    // 委托实验室
    private Long labId;
    private Org lab;
    
    // 申请人ID
    private Long applicatId;
    private Applicat applicat;
    
    // 抽样原因
    private Long reasonId;
    private Reason reason;
    
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

	public Integer getPartsAtlTimes() {
		return partsAtlTimes;
	}

	public void setPartsAtlTimes(Integer partsAtlTimes) {
		this.partsAtlTimes = partsAtlTimes;
	}

	public Integer getMatAtlTimes() {
		return matAtlTimes;
	}

	public void setMatAtlTimes(Integer matAtlTimes) {
		this.matAtlTimes = matAtlTimes;
	}

	public Integer getPartsPatTimes() {
		return partsPatTimes;
	}

	public void setPartsPatTimes(Integer partsPatTimes) {
		this.partsPatTimes = partsPatTimes;
	}

	public Integer getMatPatTimes() {
		return matPatTimes;
	}

	public void setMatPatTimes(Integer matPatTimes) {
		this.matPatTimes = matPatTimes;
	}

	public Date getConfirmTime() {
		return confirmTime;
	}

	public void setConfirmTime(Date confirmTime) {
		this.confirmTime = confirmTime;
	}

	public Integer getInfoApply() {
		return infoApply;
	}

	public void setInfoApply(Integer infoApply) {
		this.infoApply = infoApply;
	}

	public Integer getResultApply() {
		return resultApply;
	}

	public void setResultApply(Integer resultApply) {
		this.resultApply = resultApply;
	}

	public Long gettId() {
		return tId;
	}

	public void settId(Long tId) {
		this.tId = tId;
	}

	public Integer getResult() {
		return result;
	}

	public void setResult(Integer result) {
		this.result = result;
	}

	public Integer getIsReceive() {
		return isReceive;
	}

	public void setIsReceive(Integer isReceive) {
		this.isReceive = isReceive;
	}

	public String getPartsAtlCode() {
		return partsAtlCode;
	}

	public void setPartsAtlCode(String partsAtlCode) {
		this.partsAtlCode = partsAtlCode;
	}

	public String getMatAtlCode() {
		return matAtlCode;
	}

	public void setMatAtlCode(String matAtlCode) {
		this.matAtlCode = matAtlCode;
	}

	public String getPartsPatCode() {
		return partsPatCode;
	}

	public void setPartsPatCode(String partsPatCode) {
		this.partsPatCode = partsPatCode;
	}

	public String getMatPatCode() {
		return matPatCode;
	}

	public void setMatPatCode(String matPatCode) {
		this.matPatCode = matPatCode;
	}

	public TaskInfo getTaskInfo() {
		return taskInfo;
	}

	public void setTaskInfo(TaskInfo taskInfo) {
		this.taskInfo = taskInfo;
	}

	public Integer getDraft() {
		return draft;
	}

	public void setDraft(Integer draft) {
		this.draft = draft;
	}

	public Integer getAtlType() {
		return atlType;
	}

	public void setAtlType(Integer atlType) {
		this.atlType = atlType;
	}

	public String getAtlRemark() {
		return atlRemark;
	}

	public void setAtlRemark(String atlRemark) {
		this.atlRemark = atlRemark;
	}

	public Long getApplicatId() {
		return applicatId;
	}

	public void setApplicatId(Long applicatId) {
		this.applicatId = applicatId;
	}

	public Applicat getApplicat() {
		return applicat;
	}

	public void setApplicat(Applicat applicat) {
		this.applicat = applicat;
	}

	public Long getReasonId() {
		return reasonId;
	}

	public void setReasonId(Long reasonId) {
		this.reasonId = reasonId;
	}

	public Reason getReason() {
		return reason;
	}

	public void setReason(Reason reason) {
		this.reason = reason;
	}

	public Date getExpectDate() {
		return expectDate;
	}

	public void setExpectDate(Date expectDate) {
		this.expectDate = expectDate;
	}

	public Org getLab() {
		return lab;
	}

	public void setLab(Org lab) {
		this.lab = lab;
	}

	public Long getLabId() {
		return labId;
	}

	public void setLabId(Long labId) {
		this.labId = labId;
	}
	
}