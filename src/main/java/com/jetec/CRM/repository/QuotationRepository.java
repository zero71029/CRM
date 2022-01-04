package com.jetec.CRM.repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.jetec.CRM.model.QuotationBean;

public interface QuotationRepository extends JpaRepository<QuotationBean, Integer> {

	@Transactional
	@Modifying
	@Query(value = "DELETE FROM quotationdetail where product = '' ", nativeQuery = true)
	void delNull();

	@Transactional
	@Modifying
	@Query(value ="alter table quotationdetail AUTO_INCREMENT=2", nativeQuery=true)
	void alterINCREMENT();

	List<QuotationBean> findByName(String name);

	


}


