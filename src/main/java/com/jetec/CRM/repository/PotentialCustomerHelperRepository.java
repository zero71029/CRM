package com.jetec.CRM.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jetec.CRM.model.PotentialCustomerHelperBean;

public interface PotentialCustomerHelperRepository extends JpaRepository<PotentialCustomerHelperBean, String>{



	List<PotentialCustomerHelperBean> findByCustomerid(Integer customerid);

}
