package com.jetec.CRM.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "evaluate")
public class EvaluateBean {

    @Id
    private String evaluateid;
    private String department; //部門
    private String name;//姓名
    private String evaluatedate;//日期
    private String remark;//備註
    private String score;//評語
    private String assessment;//考評
    private String director;//主管
    private String hr;//人事

    private String costtime;//總花費時間
    //任務
    @JsonIgnore
    @OrderBy("taskid")
    @OneToMany(targetEntity = EvaluateTaskBean.class ,mappedBy = "evaluateid", cascade = CascadeType.ALL)
    private List<EvaluateTaskBean> task;




    public EvaluateBean() {
    }

    public EvaluateBean(String department, String name, String evaluatedate) {
        this.department = department;
        this.name = name;
        this.evaluatedate = evaluatedate;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getEvaluateid() {
        return evaluateid;
    }

    public void setEvaluateid(String evaluateid) {
        this.evaluateid = evaluateid;
    }

    public String getCosttime() {
        return costtime;
    }

    public void setCosttime(String costtime) {
        this.costtime = costtime;
    }

    public List<EvaluateTaskBean> getTask() {
        return task;
    }

    public void setTask(List<EvaluateTaskBean> task) {
        this.task = task;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEvaluatedate() {
        return evaluatedate;
    }

    public void setEvaluatedate(String evaluatedate) {
        this.evaluatedate = evaluatedate;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getAssessment() {
        return assessment;
    }

    public void setAssessment(String assessment) {
        this.assessment = assessment;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getHr() {
        return hr;
    }

    public void setHr(String hr) {
        this.hr = hr;
    }

    @Override
    public String toString() {
        return "EvaluateBean{" +
                "evaluateid='" + evaluateid + '\'' +
                ", department='" + department + '\'' +
                ", name='" + name + '\'' +
                ", evaluatedate='" + evaluatedate + '\'' +
                ", remark='" + remark + '\'' +
                ", score='" + score + '\'' +
                ", assessment='" + assessment + '\'' +
                ", director='" + director + '\'' +
                ", hr='" + hr + '\'' +
                ", costtime='" + costtime + '\'' +
                ", task=" + task +
                '}';
    }
}

