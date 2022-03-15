package com.jetec.CRM.repository;

import java.util.Collection;
import java.util.Date;
import java.util.List;

import com.jetec.CRM.model.MarketBean;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.jetec.CRM.model.PotentialCustomerBean;

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

    List<PotentialCustomerBean> findByCreatetimeBetween(String from, String to);

    List<PotentialCustomerBean> findByTrackbeanTracktimeBetween(String from, String to);

    List<PotentialCustomerBean> findByTrackbeanTracktimeBetween(String from, String to, Sort sort);


    @Query(value = "SELECT  *  from potentialcustomer where status = '未處理' OR status = '已聯繫' OR status = '提交主管'", nativeQuery = true)
    Page<PotentialCustomerBean> findStatus(Pageable p);


    List<PotentialCustomerBean> findByRemarkLikeIgnoreCase(String remark);

    @Query(value = "SELECT  COUNT(*)  from potentialcustomer where aaa BETWEEN ?1 AND ?2  ", nativeQuery = true)
    Integer gettodayTotal(@Param("startTime") String startTime, @Param("endTime") String endTime);

    List<PotentialCustomerBean> findByUserAndAaaBetween(String user, String startDay, String endDay, Sort sort);

    List<PotentialCustomerBean> findByNameLikeIgnoreCaseOrCompanyLikeIgnoreCaseAndAaaBetween(String s, String s1, String startDay, String endDay, Sort sort);

    List<PotentialCustomerBean> findByRemarkLikeIgnoreCaseAndAaaBetween(String s, String startDay, String endDay, Sort sort);

    List<PotentialCustomerBean> findByStatusAndAaaBetween(String state, String startDay, String endDay, Sort sort);

    List<PotentialCustomerBean> findByIndustryAndAaaBetween(String industry, String startDay, String endDay, Sort sort);
}
