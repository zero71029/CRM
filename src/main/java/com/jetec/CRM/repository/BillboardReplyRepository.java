package com.jetec.CRM.repository;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.jetec.CRM.model.BillboardBean;
import com.jetec.CRM.model.BillboardReplyBean;

public interface BillboardReplyRepository extends JpaRepository<BillboardReplyBean, String>{

	List<BillboardReplyBean> getByBillboardid(Integer billboardid, Sort sort);
	
	
	@Query(value ="SELECT * FROM `billboard` WHERE state = '公開'  AND  date_sub(curdate(), interval 7 day) <= createtime  ORDER BY createtime DESC", nativeQuery=true)
	List<BillboardBean> xxx();
	

}
