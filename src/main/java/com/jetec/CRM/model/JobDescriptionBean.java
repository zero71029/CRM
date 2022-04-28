package com.jetec.CRM.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "jobdescription")
public class JobDescriptionBean {
    @Id
    private String jobdescriptionid;
    private String jobname;
    private String admin;
    private String arrivaldate;
    private String director;
    private String counselor;
    private String workcontent;
    private String assessmentindicators;
    private String aaa;
    private String department;

    @Override
    public String toString() {
        return "JobDescriptionBean{" +
                "jobdescriptionid='" + jobdescriptionid + '\'' +
                ", jobname='" + jobname + '\'' +
                ", admin='" + admin + '\'' +
                ", arrivaldate='" + arrivaldate + '\'' +
                ", director='" + director + '\'' +
                ", counselor='" + counselor + '\'' +
                ", workcontent='" + workcontent + '\'' +
                ", assessmentindicators='" + assessmentindicators + '\'' +
                ", aaa='" + aaa + '\'' +
                ", department='" + department + '\'' +
                '}';
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getJobdescriptionid() {
        return jobdescriptionid;
    }

    public void setJobdescriptionid(String jobdescriptionid) {
        this.jobdescriptionid = jobdescriptionid;
    }

    public String getJobname() {
        return jobname;
    }

    public void setJobname(String jobname) {
        this.jobname = jobname;
    }

    public String getAdmin() {
        return admin;
    }

    public void setAdmin(String admin) {
        this.admin = admin;
    }

    public String getArrivaldate() {
        return arrivaldate;
    }

    public void setArrivaldate(String arrivaldate) {
        this.arrivaldate = arrivaldate;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getCounselor() {
        return counselor;
    }

    public void setCounselor(String counselor) {
        this.counselor = counselor;
    }

    public String getWorkcontent() {
        return workcontent;
    }

    public void setWorkcontent(String workcontent) {
        this.workcontent = workcontent;
    }

    public String getAssessmentindicators() {
        return assessmentindicators;
    }

    public void setAssessmentindicators(String assessmentindicators) {
        this.assessmentindicators = assessmentindicators;
    }

    public String getAaa() {
        return aaa;
    }

    public void setAaa(String aaa) {
        this.aaa = aaa;
    }
}
