package cn.wow.common.utils.taskState;

/**
 * 基准任务状态（OTS、材料研究所任务）
 * 
 * @author zhenjunzhuo 2017-10-16
 */
public enum StandardTaskEnum {

	EXAMINE(1, "审核中"), 
	EXAMINE_NOTPASS(2, "审核不通过"), 
	TESTING(3, "试验中"), 
	NOTIFY(4, "收费通知中"),
	ACCOMPLISH(5, "完成");

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