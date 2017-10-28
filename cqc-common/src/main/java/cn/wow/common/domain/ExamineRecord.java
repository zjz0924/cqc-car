package cn.wow.common.domain;

import java.util.Date;

/**
 * 审核记录
 * @author zhenjunzhuo
 * 2017-10-28
 */
public class ExamineRecord{
    private Long id;

    // 任务ID
    private Long tId;
    // 操作人ID
    private Long aId;
    // 结果（1-通过，2-不通过）
    private Integer state;
    // 审核意见
    private String remark;
    // 审核时间
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

    public Long getaId() {
        return aId;
    }

    public void setaId(Long aId) {
        this.aId = aId;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
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