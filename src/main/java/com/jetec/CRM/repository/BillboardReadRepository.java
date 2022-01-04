package com.jetec.CRM.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jetec.CRM.model.BillboardReadBean;

public interface BillboardReadRepository extends JpaRepository<BillboardReadBean, String>{

	Boolean existsByBillboardidAndName(Integer billboardid, String name);

	void deleteByBillboardidAndName(Integer billboardid, String username);


}
