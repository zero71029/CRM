package com.jetec.CRM.model;

import javax.persistence.*;

@Entity
@Table(name="application")
public class ApplicationBean {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer applicationid;

    private String admin;//申請⼈
    private String english;//護照英⽂名
    private String department;//部⾨職位
    private String privateemail;//私⼈Email
    private String privateid;//ID名稱
    private String email;//公司Email帳號
    private String arrivetime;//到職⽇
    private String createtime;//創造日

    public Integer getApplicationid() {
        return applicationid;
    }

    public void setApplicationid(Integer applicationid) {
        this.applicationid = applicationid;
    }


    public String getAdmin() {
        return admin;
    }

    public void setAdmin(String admin) {
        this.admin = admin;
    }

    public String getEnglish() {
        return english;
    }

    public void setEnglish(String english) {
        this.english = english;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getPrivateemail() {
        return privateemail;
    }

    public void setPrivateemail(String privateemail) {
        this.privateemail = privateemail;
    }

    public String getPrivateid() {
        return privateid;
    }

    public void setPrivateid(String privateid) {
        this.privateid = privateid;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getArrivetime() {
        return arrivetime;
    }

    public void setArrivetime(String arrivetime) {
        this.arrivetime = arrivetime;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    @Override
    public String toString() {
        return "ApplicationBean{" +
                "applicationid=" + applicationid +

                ", admin='" + admin + '\'' +
                ", english='" + english + '\'' +
                ", department='" + department + '\'' +
                ", privateemail='" + privateemail + '\'' +
                ", privateid='" + privateid + '\'' +
                ", email='" + email + '\'' +
                ", arrivetime='" + arrivetime + '\'' +
                ", createtime='" + createtime + '\'' +
                '}';
    }
}
