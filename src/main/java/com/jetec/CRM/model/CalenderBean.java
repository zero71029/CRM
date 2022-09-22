package com.jetec.CRM.model;

import javax.persistence.*;

@Entity
@Table(name = "calender")
public class CalenderBean {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer calenderid;
    private String theme;
    private String detail;
    private String day;
    private String name;



    public Integer getCalenderid() {
        return calenderid;
    }

    public void setCalenderid(Integer calenderid) {
        this.calenderid = calenderid;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "CalenderBean{" +
                "calenderid=" + calenderid +
                ", theme='" + theme + '\'' +
                ", detail='" + detail + '\'' +
                ", day='" + day + '\'' +
                ", name='" + name + '\'' +
                '}';
    }
}
