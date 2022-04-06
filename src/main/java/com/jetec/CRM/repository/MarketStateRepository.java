package com.jetec.CRM.repository;

import com.jetec.CRM.model.MarketStateBean;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MarketStateRepository extends JpaRepository<MarketStateBean, String> {

	boolean existsByAdminidAndFieldAndState(Integer adminid, String filed, String state);

	List<MarketStateBean> findByAdminid(Integer adminid);

    boolean existsByAdminidAndField(Integer adminid, String state);


	MarketStateBean findByAdminidAndField(Integer adminid, String field);

	void deleteByAdminid(Integer adminid);


	MarketStateBean findByAdminidAndFieldAndState(Integer adminid, String field, String state);
}
