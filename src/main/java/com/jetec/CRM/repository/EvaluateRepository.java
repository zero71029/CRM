package com.jetec.CRM.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.jetec.CRM.model.EvaluateBean;

import java.util.List;

public interface EvaluateRepository extends JpaRepository<EvaluateBean,String> {



    @Modifying
    @Query(value ="DELETE FROM `evaluatetask` WHERE `content` =''", nativeQuery=true)
    void delnull();
    @Modifying
    @Query(value ="DELETE FROM `evaluatetask` WHERE `content` is null", nativeQuery=true)
    void delempty();


    Page<EvaluateBean> findByName(String name, Pageable p);


    @Query(value ="SELECT DISTINCT name from evaluate ", nativeQuery=true)
    List<String> getName();
}
