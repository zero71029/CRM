package com.jetec.CRM.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jetec.CRM.model.AdminMailBean;

public interface AdminMailRepository extends JpaRepository<AdminMailBean, String>{

	boolean existsByBillboardidAndAdminid(Integer billboardid, Integer adminid);

	void deleteByBillboardidAndAdminid(Integer billboardid, Integer adminid);

	boolean existsByBillboardid(Integer id);

	void deleteAllByBillboardid(Integer id);



}
