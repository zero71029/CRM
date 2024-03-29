package com.jetec.CRM.model;


import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "businesstrip")
public class BusinessTripBean {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer tripid;
    @Column(columnDefinition="CHAR(32)")
    private String uuid;
    private String responsible1;//負責人員1
    private String responsible2;//負責人員2
    private String responsible3;//負責人員3
    private String tripname;//行程目的
    private String type;//行程類型
    private String content;//行程內容
    private String schedule;//排程人員
    private String tripday;//行程日期
    private String expected;//預估時間
    private String car1;
    private String car2;
    private String director;//主管
    @Column(columnDefinition="tinyint")
    private int del;

    @OneToMany(targetEntity = CooperatorBean.class , cascade = CascadeType.ALL)
    @JoinColumn(name="tripid", referencedColumnName="tripid")
    private List<CooperatorBean> cooperator;
    //@他人


    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public int getDel() {
        return del;
    }

    public void setDel(int del) {
        this.del = del;
    }

    public List<CooperatorBean> getCooperator() {
        return cooperator;
    }

    public void setCooperator(List<CooperatorBean> cooperator) {
        this.cooperator = cooperator;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public Integer getTripid() {
        return tripid;
    }

    public void setTripid(Integer tripid) {
        this.tripid = tripid;
    }

    public String getResponsible1() {
        return responsible1;
    }

    public void setResponsible1(String responsible1) {
        this.responsible1 = responsible1;
    }

    public String getResponsible2() {
        return responsible2;
    }

    public void setResponsible2(String responsible2) {
        this.responsible2 = responsible2;
    }

    public String getResponsible3() {
        return responsible3;
    }

    public void setResponsible3(String responsible3) {
        this.responsible3 = responsible3;
    }



    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSchedule() {
        return schedule;
    }

    public void setSchedule(String schedule) {
        this.schedule = schedule;
    }



    public String getExpected() {
        return expected;
    }

    public void setExpected(String expected) {
        this.expected = expected;
    }

    public String getTripname() {
        return tripname;
    }

    public void setTripname(String tripname) {
        this.tripname = tripname;
    }

    public String getTripday() {
        return tripday;
    }

    public void setTripday(String tripday) {
        this.tripday = tripday;
    }


    public String getCar1() {
        return car1;
    }

    public void setCar1(String car1) {
        this.car1 = car1;
    }

    public String getCar2() {
        return car2;
    }

    public void setCar2(String car2) {
        this.car2 = car2;
    }

    @Override
    public String toString() {
        return "BusinessTripBean{" +
                "tripid=" + tripid +
                ", responsible1='" + responsible1 + '\'' +
                ", responsible2='" + responsible2 + '\'' +
                ", responsible3='" + responsible3 + '\'' +
                ", tripname='" + tripname + '\'' +
                ", type='" + type + '\'' +
                ", content='" + content + '\'' +
                ", schedule='" + schedule + '\'' +
                ", tripday='" + tripday + '\'' +
                ", expected='" + expected + '\'' +
                ", director='" + director + '\'' +
                ", cooperator=" + cooperator +
                '}';
    }
}
