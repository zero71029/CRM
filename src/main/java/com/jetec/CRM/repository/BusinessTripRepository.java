package com.jetec.CRM.repository;

import com.jetec.CRM.model.BusinessTripBean;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface BusinessTripRepository extends JpaRepository<BusinessTripBean, Integer> {

    @Query(value = "DELETE FROM `businesstripcooperator` WHERE `name` ='' or tripid is null", nativeQuery = true)
    @Modifying
    void delNull();

    @Query(value = "ALTER TABLE businesstripcooperator AUTO_INCREMENT = 1;", nativeQuery = true)
    @Modifying
    void zero();

    @Query(value = "select  * from businesstrip where (car1 = ?1 or car2 = ?2) and tripday BETWEEN ?3  and  ?4 AND del = 0 order by tripday DESC", nativeQuery = true)
    @Modifying
    List<BusinessTripBean> getByCar(String car, String car1, String start, String end);

    @Query(value = "select  * from businesstrip where (car1 = ?1 or car2 = ?2)  AND del = 0 order by tripday DESC", nativeQuery = true)
    @Modifying
    List<BusinessTripBean> getByOnlyCar(String car, String car1);

    List<BusinessTripBean> findByDelAndTripdayBetween(int i, String toString, String toString1, Sort tripday);

    @Query(value = "UPDATE businesstrip SET del=1 WHERE tripid=?1", nativeQuery = true)
    @Modifying
    void delId(Integer id);

}
