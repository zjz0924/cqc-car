package cn.wow.common.domain;

import java.util.Date;

/**
 * 接收机构
 * 
 * @author junzzh 2018-10-28
 */
public class ReceiveOrg {

	// 机构名称
	private String name;
	// 任务ID
	private Long taskId;
	// 任务接收时间
	private Date createTime;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Long getTaskId() {
		return taskId;
	}

	public void setTaskId(Long taskId) {
		this.taskId = taskId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

}
