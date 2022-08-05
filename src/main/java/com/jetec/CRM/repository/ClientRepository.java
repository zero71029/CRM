package com.jetec.CRM.repository;

import java.util.Collection;
import java.util.List;

import com.jetec.CRM.model.MarketBean;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;

import com.jetec.CRM.model.ClientBean;

import javax.persistence.LockModeType;

public interface ClientRepository extends JpaRepository<ClientBean, Integer>{






	@Query(value ="SELECT clientid FROM `client` WHERE name = ?1  ", nativeQuery=true)
	Integer selectIdByname(String name);

	List<ClientBean> findByNameLikeIgnoreCase(String string);

	List<ClientBean> findByUniformnumberLikeIgnoreCase(String string);

	List<ClientBean> findByPhoneLikeIgnoreCase(String string);

	List<ClientBean> findByUserLikeIgnoreCase(String string);

	boolean existsByName(String client);

	List<ClientBean> findByState(Integer i);

	ClientBean findByName(String name);


	List<ClientBean> findByIndustry(String industry);

	List<ClientBean> findByIndustryAndAaaBetween(String e, String finalStart, String finalEnd);

	List<ClientBean> findByIndustryIsNullAndAaaBetween(String start, String end);

	List<ClientBean> findByIndustryIsNull();
}
