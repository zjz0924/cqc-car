package cn.wow.common.utils.taskState;

/**
 * 基准任务记录状态（OTS、材料研究所任务）
 * 
 * @author zhenjunzhuo 2017-10-16
 */
public enum StandardTaskRecordEnum {
	
	ENTERING(1, "基准信息录入"), 
	EXAMINE_PASS(2, "审核通过"),
	EXAMINE_NOTPASS(3, "审核不通过"),
	TRANSMIT(4, "任务下达"), 
	APPROVE_AGREE(5, "审批同意"), 
	APPROVE_DISAGREE(6, "审批不同意"),
	UPLOAD_ATLAS(7, "图谱结果上传"),
	UPLOAD_PATTERN(8, "型式结果上传"), 
	SEND(9, "结果发送"), 
	CONFIRM_PASS(10, "结果确认合格"), 
	CONFIRM_NOTPASS(11, "结果确认不合格"), 
	SAVE(12, "基准保存"),
	NOTICE(13, "收费通知");

	private int state;

	private String msg;
	
	private StandardTaskRecordEnum(int state, String msg) {
		this.state = state;
		this.msg = msg;
	}

	public int getState() {
		return state;
	}

	public String getMsg() {
		return msg;
	}

}