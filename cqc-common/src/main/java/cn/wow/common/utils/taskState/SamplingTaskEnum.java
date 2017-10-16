package cn.wow.common.utils.taskState;

/**
 * 抽样任务状态（PPAP、SOP）
 * 
 * @author zhenjunzhuo 2017-10-16
 */
public enum SamplingTaskEnum {

	TRANSMIT(1, "下达中"), 
	APPROVE(2, "审批中"), 
	UPLOADING(3, "结果上传中"), 
	COMPARISON(4, "结果比对中"), 
	SENDING(5, "结果发送中"), 
	CONFIRM(6, "结果确认中"), 
	ACCOMPLISH(7, "完成");

	private int state;

	private String msg;
	
	private SamplingTaskEnum(int state, String msg) {
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