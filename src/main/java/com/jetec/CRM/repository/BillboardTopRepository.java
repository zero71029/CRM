package com.jetec.CRM.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jetec.CRM.model.BillboardTopBean;

public interface BillboardTopRepository  extends JpaRepository<BillboardTopBean, String>{

	boolean existsByBillboardidAndAdminid(Integer billboardid, Integer adminid);

	void deleteAllByBillboardidAndAdminid(Integer billboardid, Integer adminid);

	void deleteAllByBillboardid(Integer id);

}
