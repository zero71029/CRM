package com.jetec.CRM.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.jetec.CRM.model.WorkBean;

public interface WorKRepository extends JpaRepository<WorkBean, String> {

	List<WorkBean> findByNameLikeIgnoreCase(String string);

	List<WorkBean> findByUserLikeIgnoreCase(String string);

	List<WorkBean> findByClientid(Integer clientid);

	List<WorkBean> findByContactid(Integer clientid);

	List<WorkBean> findByState(String string, Sort sort);

	List<WorkBean> findByUserAndState(String name, String state);

	@Query(value = "SELECT  *  from work where state != '失敗結案' AND state != '成功結案' order by aaa DESC ", nativeQuery = true)
	Page<WorkBean> findStage(Pageable p);

	@Query(value = "SELECT  count(*)  from work where state != '失敗結案' AND state != '成功結案' order by aaa DESC ", nativeQuery = true)
	Integer getTotal();

	Page<WorkBean> findByNameLikeIgnoreCase(String string, Pageable p);

	Page<WorkBean> findByUserLikeIgnoreCase(String string, Pageable p);

	Page<WorkBean> findByClientid(Integer clientid, Pageable p);

	Page<WorkBean> findByContactid(Integer clientid, Pageable p);

}
