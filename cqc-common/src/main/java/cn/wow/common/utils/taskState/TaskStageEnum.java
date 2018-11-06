package cn.wow.common.utils.taskState;

/**
 * 任务阶段
 */
public enum TaskStageEnum {

	EXAMINE(1, "任务申请"), TRANSMIT(2, "任务下达"), APPROVE(3, "任务审批");

	private int state;

	private String msg;

	private TaskStageEnum(int state, String msg) {
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
