package com.jetec.CRM.repository;

import com.jetec.CRM.model.PotentialCustomerBean;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Collection;
import java.util.List;

public interface PotentialCustomerRepository extends JpaRepository<PotentialCustomerBean, String> {

    List<PotentialCustomerBean> findByNameLikeIgnoreCase(String string, Sort sort);

    List<PotentialCustomerBean> findByUserLikeIgnoreCase(String string, Sort sort);

    List<PotentialCustomerBean> findByCompanyLikeIgnoreCase(String string, Sort sort);

    List<PotentialCustomerBean> findByStatus(String string);

    List<PotentialCustomerBean> findByUserAndStatus(String adminname, String Status);

    @Query(value = "SELECT  *  from potentialcustomer where  (aaa BETWEEN ?1 AND ?2 ) ORDER By aaa DESC ", nativeQuery = true)
    public List<PotentialCustomerBean> findCreatetime(@Param("startTime") String startTime, @Param("endTime") String endTime);

    List<PotentialCustomerBean> findBySource(String source);

    List<PotentialCustomerBean> findByIndustry(String industry);


    List<PotentialCustomerBean> findByTrackbeanTracktimeBetween(String from, String to);



    @Query(value = "SELECT  *  from potentialcustomer where user != '' AND (status = '未處理' OR status = '已聯繫' OR status = '提交主管')", nativeQuery = true)
    Page<PotentialCustomerBean> findStatus(Pageable p);


    List<PotentialCustomerBean> findByRemarkLikeIgnoreCase(String remark);

    @Query(value = "SELECT  COUNT(*)  from potentialcustomer where   aaa BETWEEN ?1 AND ?2  ", nativeQuery = true)
    Integer gettodayTotal(@Param("startTime") String startTime, @Param("endTime") String endTime);

    List<PotentialCustomerBean> findByUserAndAaaBetween(String user, String startDay, String endDay, Sort sort);

    List<PotentialCustomerBean> findByNameLikeIgnoreCaseOrCompanyLikeIgnoreCaseAndAaaBetween(String s, String s1, String startDay, String endDay, Sort sort);

    List<PotentialCustomerBean> findByRemarkLikeIgnoreCaseAndAaaBetween(String s, String startDay, String endDay, Sort sort);

    List<PotentialCustomerBean> findByStatusAndAaaBetween(String state, String startDay, String endDay, Sort sort);

    List<PotentialCustomerBean> findByIndustryAndAaaBetween(String industry, String startDay, String endDay, Sort sort);

    List<PotentialCustomerBean> findByUser(String user);






    @Query(value = "select * from potentialcustomer p where  (aaa between ?1 and ?2) and user = ?3   \n" +
            "and customerid not in  (select customerid from market m)", nativeQuery = true)
    List<PotentialCustomerBean> getPotentialCustomerbyBYAaaAndUserNotinMarket(String startDay, String endDay, String name);

    @Query(value = "select * from potentialcustomer p where user = ?1  and   status = ?2    and receivestate = ?3    and    (aaa between ?4 and ?5)    \n" +
            "and customerid not in  (select customerid from market m)", nativeQuery = true)
    List<PotentialCustomerBean> getPotentialCustomerByUserAndStateAndReceivesAndAaaAndNotinMarket(String user, String state, Integer receives, String startDay, String endDay);

    @Query(value = "select * from potentialcustomer p where user = ?1  and   status = ?2    and  (aaa between ?3 and ?4)    \n" +
            "and customerid not in  (select customerid from market m)", nativeQuery = true)
    List<PotentialCustomerBean> getPotentialCustomerByUserAndStateAndAaaAndNotinMarket(String user, String state, String startDay, String endDay);

    @Query(value = "select * from potentialcustomer p where user = ?1  and   receivestate = ?2    and  (aaa between ?3 and ?4)    \n" +
            "and customerid not in  (select customerid from market m)", nativeQuery = true)
    List<PotentialCustomerBean> getPotentialCustomerAndUserAndReceivesByAaaAndNotinMarket(String user, Integer receives, String startDay, String endDay);

    List<PotentialCustomerBean> findByUserIsNull();



    List<PotentialCustomerBean> findByPhoneLikeAndAaaBetween(String s, String startDay, String endDay, Sort sort);

    List<PotentialCustomerBean> findByMoblieLikeAndAaaBetween(String s, String startDay, String endDay, Sort sort);

    List<PotentialCustomerBean> findByFaxLikeAndAaaBetween(String s, String startDay, String endDay, Sort sort);
}
