package com.jetec.CRM.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.time.LocalDateTime;

@Entity
@Table(name = "laboratory_forum")
public class LaboratoryForumBean {

    @Id
    @Column(columnDefinition = "char(32)")
    private String forumid;
    private String member;
    private String name;
    private String state;
    private String replytime;
    @Column(columnDefinition = "TINYINT(1)")
    private String top;
    private String forumgroup;
    @Column(columnDefinition = "char(32)")
    private String forumgroupid;
    private String remark;
    private String time;

    private LocalDateTime lastmodified = LocalDateTime.now();


    public String getForumid() {
        return forumid;
    }

    public void setForumid(String forumid) {
        this.forumid = forumid;
    }

    public String getMember() {
        return member;
    }

    public void setMember(String member) {
        this.member = member;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getReplytime() {
        return replytime;
    }

    public void setReplytime(String replytime) {
        this.replytime = replytime;
    }

    public String getTop() {
        return top;
    }

    public void setTop(String top) {
        this.top = top;
    }

    public String getForumgroup() {
        return forumgroup;
    }

    public void setForumgroup(String forumgroup) {
        this.forumgroup = forumgroup;
    }

    public String getForumgroupid() {
        return forumgroupid;
    }

    public void setForumgroupid(String forumgroupid) {
        this.forumgroupid = forumgroupid;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public LocalDateTime getLastmodified() {
        return lastmodified;
    }

    public void setLastmodified(LocalDateTime lastmodified) {
        this.lastmodified = lastmodified;
    }

    @Override
    public String toString() {
        return "{" +
                "forumid:'" + forumid + '\'' +
                ", member:'" + member + '\'' +
                ", name:'" + name + '\'' +
                ", state:'" + state + '\'' +
                ", replytime:'" + replytime + '\'' +
                ", top:'" + top + '\'' +
                ", forumgroup:'" + forumgroup + '\'' +
                ", forumgroupid:'" + forumgroupid + '\'' +
                ", remark:'" + remark + '\'' +
                ", time:'" + time + '\'' +
                ", lastmodified:" + lastmodified +
                '}';
    }
}
