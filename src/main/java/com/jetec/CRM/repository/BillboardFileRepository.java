package com.jetec.CRM.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jetec.CRM.model.BillboardFileBean;

public interface BillboardFileRepository extends JpaRepository<BillboardFileBean, String>{

	List<BillboardFileBean> findByAuthorize(String authorizeId);

	BillboardFileBean getByUrl(String url);

	void deleteByBillboardid(Integer i);

	List<BillboardFileBean> findByBillboardid(Integer i);

	void deleteAllByBillboardid(Integer i);



}
