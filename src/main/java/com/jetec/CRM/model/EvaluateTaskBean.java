package com.jetec.CRM.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "evaluatetask")
public class EvaluateTaskBean {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer taskid;
    private String evaluateid;
    private String finish;
    private String content;
    private String important;
    private String costtime;
    private String taskdate;
    private Date createtime;


    public EvaluateTaskBean() {
    }

    public EvaluateTaskBean(Integer taskid, String evaluateid, String content, String important, String taskdate) {
        this.taskid = taskid;
        this.evaluateid = evaluateid;
        this.content = content;
        this.important = important;
        this.taskdate = taskdate;
    }

    public Integer getTaskid() {
        return taskid;
    }

    public void setTaskid(Integer taskid) {
        this.taskid = taskid;
    }

    public String getEvaluateid() {
        return evaluateid;
    }

    public void setEvaluateid(String evaluateid) {
        this.evaluateid = evaluateid;
    }

    public String getFinish() {
        return finish;
    }

    public void setFinish(String finish) {
        this.finish = finish;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImportant() {
        return important;
    }

    public void setImportant(String important) {
        this.important = important;
    }

    public String getCosttime() {
        return costtime;
    }

    public void setCosttime(String costtime) {
        this.costtime = costtime;
    }

    public String getTaskdate() {
        return taskdate;
    }

    public void setTaskdate(String taskdate) {
        this.taskdate = taskdate;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    @Override
    public String toString() {
        return "EvaluateTaskBean{" +
                "taskid='" + taskid + '\'' +
                ", evaluateid='" + evaluateid + '\'' +
                ", finish='" + finish + '\'' +
                ", content='" + content + '\'' +
                ", important='" + important + '\'' +
                ", costtime='" + costtime + '\'' +
                ", taskdate='" + taskdate + '\'' +
                ", createtime=" + createtime +
                '}';
    }
}
