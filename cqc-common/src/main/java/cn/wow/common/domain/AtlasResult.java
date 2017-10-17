package cn.wow.common.domain;

import java.util.Date;

/**
 * 图谱结果
 */
public class AtlasResult {
    
	private Long id;
    // 任务ID
    private Long tId;
    // 类型 ：1-红外光分析、2-差热分析、3-热重分析
    private Integer type;
    // 图片
    private String pic;
    // 备注
    private String remark;
    // 创建时间
    private Date createTime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long gettId() {
        return tId;
    }

    public void settId(Long tId) {
        this.tId = tId;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic == null ? null : pic.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}