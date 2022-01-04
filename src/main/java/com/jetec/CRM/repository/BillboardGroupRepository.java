package com.jetec.CRM.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jetec.CRM.model.BillboardGroupBean;

public interface BillboardGroupRepository extends JpaRepository<BillboardGroupBean, String>{

	BillboardGroupBean findByBillboardgroupAndBillboardoption(String billtowngroup, String Billboardgroupid);

	boolean existsByBillboardgroupAndBillboardoption(String group, String option);


}
