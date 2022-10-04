package com.jetec.CRM.repository;

import com.jetec.CRM.model.BusinessTripBean;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface BusinessTripRepository extends JpaRepository<BusinessTripBean,Integer> {
    List<BusinessTripBean> findByTripdayBetween(String toString, String toString1, Sort tripday);


    @Query(value ="DELETE FROM `businesstripcooperator` WHERE `name` ='' or tripid is null", nativeQuery=true)
    @Modifying
    void delNull();
    @Query(value ="ALTER TABLE businesstripcooperator AUTO_INCREMENT = 1;", nativeQuery=true)
    @Modifying
    void zero();
}
