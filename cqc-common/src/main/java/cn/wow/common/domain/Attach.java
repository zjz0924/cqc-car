package cn.wow.common.domain;

import org.apache.commons.lang3.StringUtils;

/**
 * 附件
 * 
 * @author junzzh 2018-10-27
 */
public class Attach {

	private Long id;
	// 零件型式附件
	private String partsFile;

	private String partsFileName;

	// 材料型式附件
	private String materialFile;

	private String materialFileName;

	// 任务号
	private Long taskId;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getPartsFile() {
		return partsFile;
	}

	public void setPartsFile(String partsFile) {
		this.partsFile = partsFile == null ? null : partsFile.trim();
	}

	public String getMaterialFile() {
		return materialFile;
	}

	public void setMaterialFile(String materialFile) {
		this.materialFile = materialFile == null ? null : materialFile.trim();
	}

	public Long getTaskId() {
		return taskId;
	}

	public void setTaskId(Long taskId) {
		this.taskId = taskId;
	}

	public String getPartsFileName() {
		return partsFileName;
	}

	public String getMaterialFileName() {
		return materialFileName;
	}

	public void setPartsFileName(String partsFileName) {
		this.partsFileName = partsFileName;
	}

	public void setMaterialFileName(String materialFileName) {
		this.materialFileName = materialFileName;
	}

	public void setFileName() {
		if (StringUtils.isNotBlank(this.partsFile)) {
			this.partsFileName = this.partsFile.substring(this.partsFile.lastIndexOf("/") + 1);
		}

		if (StringUtils.isNotBlank(this.materialFile)) {
			this.materialFileName = this.materialFile.substring(this.materialFile.lastIndexOf("/") + 1);
		}
	}

}