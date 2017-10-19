package cn.wow.common.domain;

import java.util.Date;

/**
 * 任务操作记录
 * @author zhenjunzhuo
 * 2017-10-13
 */
public class TaskRecord {
    
	private Long id;
    // 任务号
    private String code;
    // 操作人ID
    private Long aId;
    
    private Account account;
    
    // 状态：1-基准信息录入，2-基准实验任务的下达，3-基准已经完成审批的修改申请，4-抽样任务的下达，5-抽样实验修改申请
    /** 
     * 	状态：
     *  OTS、材料研究所任务： 1-基准信息录入，2-审核，3-任务下达，4-任务审批，5-结果上传，6-结果发送，7-结果确认，8-基准保存，9-收费通知
     *  PPAP、SOP： 1-任务申请，2-任务下达，3-任务审批，4-结果上传，5-结果比对，6-结果发送，7-结果确认，8-结果留存，9-重新下任务，10-发送警告书，11-收费通知
     */
    private Integer state;
     
    private String remark;

    private Date createTime;
    
    public TaskRecord(){
    	
    }

    public TaskRecord(String code, Long aId, Integer state, String remark, Date createTime){
    	this.code = code;
    	this.aId = aId;
    	this.state = state;
    	this.remark = remark;
    	this.createTime = createTime;
    }
    
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

    public Long getaId() {
        return aId;
    }

    public void setaId(Long aId) {
        this.aId = aId;
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

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}
}