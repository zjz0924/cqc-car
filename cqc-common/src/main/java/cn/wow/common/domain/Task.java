package cn.wow.common.domain;

import java.util.Date;

/**
 * 任务
 * 
 * @author zhenjunzhuo 2017-10-13
 */
public class Task {

	private Long id;
	// 任务号
	private String code;

	// 信息ID
	private Long iId;
	private Info info;

	// 基准信息ID（用于 PPAP任务）
	private Long standIid;
	private Info standInfo;

	// 申请人机构
	private Long orgId;
	private Org org;

	// 申请人
	private Long aId;
	private Account applicat;

	// 类型(1-OTS、2-PPAP、3-SOP、4-材料研究所任务)
	private Integer type;

	// 父任务ID
	private Long tId;

	/**
	 * 状态： OTS、材料研究所任务： 1-审核中，2-审核不通过，3-试验中，4-完成，5-申请修改，6-申请不通过 
	 *    PPAP、SOP：1-审批中，2-审批不通过，3-结果上传中，4-结果比对中，5-结果发送中，6-结果接收中，7-完成，8-申请修改，9-申请不通过，10-确认是否二次抽样，11-中止任务
	 */
	private Integer state;

	// 零件图谱实验室ID
	private Long partsAtlId;
	private Org partsAtl;

	// 材料图谱实验室ID
	private Long matAtlId;
	private Org matAtl;

	// 零件型式实验室ID
	private Long partsPatId;
	private Org partsPat;

	// 材料型式实验室ID
	private Long matPatId;
	private Org matPat;

	// 结果接收失败次数
	private Integer failNum;
	// 备注
	private String remark;
	// 创建时间
	private Date createTime;
	// 确认时间
	private Date confirmTime;

	// 零件图谱结果(0-待处理，1-未上传，2-已上传，3-已发送，4-接收，5-不接收， 6-审批不通过)
	private Integer partsAtlResult;
	// 材料图谱结果(0-待处理，1-未上传，2-已上传，3-已发送，4-接收，5-不接收， 6-审批不通过)
	private Integer matAtlResult;
	// 零件型式结果 (0-待处理，1-未上传，2-已上传，3-已发送，4-接收，5-不接收， 6-审批不通过)
	private Integer partsPatResult;
	// 材料型式结果(0-待处理，1-未上传，2-已上传，3-已发送，4-接收，5-不接收， 6-审批不通过)
	private Integer matPatResult;

	// 零件图谱实验次数
	private Integer partsAtlTimes;
	// 材料图谱实验次数
	private Integer matAtlTimes;
	// 零件型式实验次数
	private Integer partsPatTimes;
	// 材料型式实验次数
	private Integer matPatTimes;

	// 是否申请修改信息（0-否， 1-等待审批）
	private Integer infoApply;
	// 是否申请修改试验结果（0-否，1-等待审批，2-子任务等待审批）
	private Integer resultApply;

	// 结果（1-合格，2-不合格）
	private Integer result;

	// 是否接收（1-接收，2-不接收）
	private Integer isReceive;

	// 零件图谱实验编号
	private String partsAtlCode;

	// 材料图谱实验编号
	private String matAtlCode;

	// 零件型式实验编号
	private String partsPatCode;

	// 材料型式实验编号
	private String matPatCode;

	// PPAP和SOP 任务信息
	private TaskInfo taskInfo;

	// 是否是草稿（0-否，1-是）
	private Integer draft;

	// 基准图谱类型
	private String atlType;

	// 测试项目
	private String atlItem;

	// 基准图谱备注
	private String atlRemark;

	// 期望完成时间
	private Date expectDate;

	// 抽样原因
	private Long reasonId;
	private Reason reason;

	// 试验结论 - 冗余字段，用于显示
	private String partsAtlConclusion;
	private String matAtlConclusion;
	private String partsPatConclusion;
	private String matPatConclusion;

	// 接收实验室 - 冗余字段，用于显示
	private String receiveLabOrg;

	// 审核人员（ots 和 第三方）
	private Long examineAccountId;
	// 下达人员（ots 和 第三方）
	private Long trainsmitAccountId;
	// 审批人员
	private Long approveAccountId;

	// 冗余字段（用于识别任务类型，1-ots申请，2-ots审核，3-ots下达任务，4-ots审批，5-ppap下达，6-ppap审批，7-sop下达，8-sop审批，9-tpt申请，10-tpt审核，11-tpt下达，12-tpt审批，13-型式结果，14-图谱结果，15-结果对比,
	// 16-结果发送，17-结果接收：待上传列表，18-结果接收：已上传列表结果接收：已上传列表）
	private int taskType;

	// 跳转url（冗余字段）
	private String url;

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

	public String getAtlType() {
		return atlType;
	}

	public void setAtlType(String atlType) {
		this.atlType = atlType;
	}

	public String getAtlRemark() {
		return atlRemark;
	}

	public void setAtlRemark(String atlRemark) {
		this.atlRemark = atlRemark;
	}

	public Account getApplicat() {
		return applicat;
	}

	public void setApplicat(Account applicat) {
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

	public String getAtlItem() {
		return atlItem;
	}

	public void setAtlItem(String atlItem) {
		this.atlItem = atlItem;
	}

	public Long getStandIid() {
		return standIid;
	}

	public void setStandIid(Long standIid) {
		this.standIid = standIid;
	}

	public Info getStandInfo() {
		return standInfo;
	}

	public void setStandInfo(Info standInfo) {
		this.standInfo = standInfo;
	}

	public String getPartsAtlConclusion() {
		return partsAtlConclusion;
	}

	public void setPartsAtlConclusion(String partsAtlConclusion) {
		this.partsAtlConclusion = partsAtlConclusion;
	}

	public String getMatAtlConclusion() {
		return matAtlConclusion;
	}

	public void setMatAtlConclusion(String matAtlConclusion) {
		this.matAtlConclusion = matAtlConclusion;
	}

	public String getPartsPatConclusion() {
		return partsPatConclusion;
	}

	public void setPartsPatConclusion(String partsPatConclusion) {
		this.partsPatConclusion = partsPatConclusion;
	}

	public String getMatPatConclusion() {
		return matPatConclusion;
	}

	public void setMatPatConclusion(String matPatConclusion) {
		this.matPatConclusion = matPatConclusion;
	}

	public String getReceiveLabOrg() {
		return receiveLabOrg;
	}

	public void setReceiveLabOrg(String receiveLabOrg) {
		this.receiveLabOrg = receiveLabOrg;
	}

	public Long getExamineAccountId() {
		return examineAccountId;
	}

	public void setExamineAccountId(Long examineAccountId) {
		this.examineAccountId = examineAccountId;
	}

	public Long getTrainsmitAccountId() {
		return trainsmitAccountId;
	}

	public void setTrainsmitAccountId(Long trainsmitAccountId) {
		this.trainsmitAccountId = trainsmitAccountId;
	}

	public Long getApproveAccountId() {
		return approveAccountId;
	}

	public void setApproveAccountId(Long approveAccountId) {
		this.approveAccountId = approveAccountId;
	}

	public int getTaskType() {
		return taskType;
	}

	public void setTaskType(int taskType) {
		this.taskType = taskType;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

}