package com.jetec.CRM.model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "askleave")
public class LeaveBean {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer leaveid;
    @Column(columnDefinition="CHAR(32)")
    private String uuid;
    private String user;//申請人
    private String department;//部門
    private String leaveName;//假別
    private String agent;//職務代理人
    private String reason;//事由
    private String startday;//請假時間
    private String endday;//請假時間
    private String director;//主管
    private String leaveday;//請假日
    private String applyday;//申請日期
    private String remark;//備註
    @Column(columnDefinition="tinyint")
    private int del;

    public LeaveBean() {
    }

    public LeaveBean(LeaveBean leaveBean) {
        user = leaveBean.getUser();
        uuid = leaveBean.getUuid();
        department = leaveBean.getDepartment();
        leaveName =leaveBean.getLeaveName();
        agent = leaveBean.getAgent();
        reason = leaveBean.getReason();
        startday = leaveBean.getStartday();
        endday = leaveBean.getEndday();
        director = leaveBean.getDirector();
        leaveday = leaveBean.getLeaveday();
        applyday = leaveBean.getApplyday();
        remark = leaveBean.getRemark();
    }


    public int getDel() {
        return del;
    }

    public void setDel(int del) {
        this.del = del;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getLeaveid() {
        return leaveid;
    }

    public void setLeaveid(Integer leaveid) {
        this.leaveid = leaveid;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getLeaveName() {
        return leaveName;
    }

    public void setLeaveName(String leaveName) {
        this.leaveName = leaveName;
    }

    public String getAgent() {
        return agent;
    }

    public void setAgent(String agent) {
        this.agent = agent;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getStartday() {
        return startday;
    }

    public void setStartday(String startday) {
        this.startday = startday;
    }

    public String getEndday() {
        return endday;
    }

    public void setEndday(String endday) {
        this.endday = endday;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getApplyday() {
        return applyday;
    }

    public void setApplyday(String applyday) {
        this.applyday = applyday;
    }

    public String getLeaveday() {
        return leaveday;
    }

    public void setLeaveday(String leaveday) {
        this.leaveday = leaveday;
    }

    @Override
    public String toString() {
        return "LeaveBean{" +
                "leaveid=" + leaveid +
                ", user='" + user + '\'' +
                ", department='" + department + '\'' +
                ", leaveName='" + leaveName + '\'' +
                ", agent='" + agent + '\'' +
                ", reason='" + reason + '\'' +
                ", startday='" + startday + '\'' +
                ", endday='" + endday + '\'' +
                ", director='" + director + '\'' +
                ", 請假日='" + leaveday + '\'' +
                ", applyday='" + applyday + '\'' +
                '}';
    }
}
