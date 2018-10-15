package cn.wow.common.vo;

/**
 *    结果VO
 */
public class ResultFlagVO {

	private boolean flag = true;
	
	private Integer state = 0;

	public boolean getFlag() {
		return flag;
	}

	public void setFlag(boolean flag) {
		this.flag = flag;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}
}
