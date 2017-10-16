package cn.wow.common.utils.taskState;

/**
 * 基准任务状态（OTS、材料研究所任务）
 * 
 * @author zhenjunzhuo 2017-10-16
 */
public enum StandardTaskEnum {

	EXAMINE(1, "审核中"), 
	EXAMINE_NOTPASS(2, "审核不通过"), 
	TRANSMIT(3, "下达中"), 
	APPROVE(4, "审批中"), 
	UPLOADING(5, "结果上传中"), 
	SENDING(6, "结果发送中"), 
	CONFIRM(7, "结果确认中"), 
	ACCOMPLISH(8, "完成");

	private int state;

	private String msg;
	
	private StandardTaskEnum(int state, String msg) {
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