package com.jetec.CRM.model;


import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "businesstripcooperator")
public class CooperatorBean {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private Integer tripid;
    private String name;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getTripid() {
        return tripid;
    }

    public void setTripid(Integer tripid) {
        this.tripid = tripid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    @Override
    public String toString() {
        return "PcooperatorBean{" +
                "id=" + id +
                ", tripid=" + tripid +
                ", name='" + name + '\'' +

                '}';
    }
}
