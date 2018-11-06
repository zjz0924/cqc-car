package cn.wow.common.utils.taskState;

public enum EmailTypeEnum {

	RESULT(1, "结果"), COST(2, "收费通知");
	
	private int state;

	private String msg;

	private EmailTypeEnum(int state, String msg) {
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
