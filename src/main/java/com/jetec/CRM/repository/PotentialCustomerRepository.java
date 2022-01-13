package com.jetec.CRM.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.jetec.CRM.model.PotentialCustomerBean;

public interface PotentialCustomerRepository extends JpaRepository<PotentialCustomerBean, Integer>{

	List<PotentialCustomerBean> findByNameLikeIgnoreCase(String string);

	List<PotentialCustomerBean> findByUserLikeIgnoreCase(String string);

	List<PotentialCustomerBean> findByCompanyLikeIgnoreCase(String string);

	List<PotentialCustomerBean> findByStatus(String string);

	List<PotentialCustomerBean> findByUserAndStatus(String adminname, String Status);

	@Query(value ="SELECT  *  from potentialcustomer where status != '不合格' AND status != '合格' AND (createtime BETWEEN ?1 AND ?2 )",nativeQuery = true)
	public List<PotentialCustomerBean> findCreatetime(@Param("startTime") Date startTime,@Param("endTime") Date endTime );

	List<PotentialCustomerBean> findBySource(String source);

	List<PotentialCustomerBean> findByIndustry(String industry);

	List<PotentialCustomerBean> findByCreatetimeBetween(String from, String to);

	List<PotentialCustomerBean> findByTrackbeanTracktimeBetween(String from, String to);

	List<PotentialCustomerBean> findByTrackbeanTracktimeBetween(String from, String to, Sort sort);


}
