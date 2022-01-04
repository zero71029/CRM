package com.jetec.CRM.repository;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import com.jetec.CRM.model.WorkBean;

public interface WorKRepository extends JpaRepository<WorkBean, Integer>{

	List<WorkBean> findByNameLikeIgnoreCase(String string);

	List<WorkBean> findByUserLikeIgnoreCase(String string);

	List<WorkBean> findByClientid(Integer clientid);

	List<WorkBean> findByContactid(Integer clientid);

	List<WorkBean> findByState(String string, Sort sort);

	List<WorkBean> findByUserAndState(String name, String state);

}
