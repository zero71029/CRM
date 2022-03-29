package com.jetec.CRM.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jetec.CRM.model.MarketStateBean;

public interface MarketStateRepository extends JpaRepository<MarketStateBean, String> {

	boolean existsByAdminidAndFieldAndState(Integer adminid, String filed, String state);

	List<MarketStateBean> findByAdminid(Integer adminid);

}
