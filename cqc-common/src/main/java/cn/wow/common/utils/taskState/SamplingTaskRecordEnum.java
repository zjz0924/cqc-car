package cn.wow.common.utils.taskState;

/**
 * 抽样任务记录状态（PPAP、SOP）
 * 
 * @author zhenjunzhuo 2017-10-16
 */
public enum SamplingTaskRecordEnum {
	
	APPLY(1, "任务申请"), 
	TRANSMIT(2, "任务下达"), 
	APPROVE_AGREE(5, "审批同意"), 
	APPROVE_DISAGREE(6, "审批不同意"), 
	UPLOAD(4, "结果上传"), 
	COMPARISON_NORMAL(5, "结果比对正常"),
	COMPARISON_ABNORMAL(6, "结果比对异常"),
	SEND(6, "结果发送"), 
	CONFIRM(7, "结果确认"), 
	SAVE(8, "结果留存"),
	REORDER(9, "重新下任务"),
	ALARM(10, "发送警告书"),
	NOTICE(11, "收费通知");

	private int state;

	private String msg;
	
	private SamplingTaskRecordEnum(int state, String msg) {
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