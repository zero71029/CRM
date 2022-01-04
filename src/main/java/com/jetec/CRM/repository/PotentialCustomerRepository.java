package com.jetec.CRM.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jetec.CRM.model.PotentialCustomerBean;

public interface PotentialCustomerRepository extends JpaRepository<PotentialCustomerBean, Integer>{

	List<PotentialCustomerBean> findByNameLikeIgnoreCase(String string);

	List<PotentialCustomerBean> findByUserLikeIgnoreCase(String string);

	List<PotentialCustomerBean> findByCompanyLikeIgnoreCase(String string);

	List<PotentialCustomerBean> findByStatus(String string);

	List<PotentialCustomerBean> findByUserAndStatus(String adminname, String Status);

}
