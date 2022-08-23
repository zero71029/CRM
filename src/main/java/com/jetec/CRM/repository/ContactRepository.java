package com.jetec.CRM.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.jetec.CRM.model.ContactBean;

public interface ContactRepository extends JpaRepository<ContactBean, Integer>{


	List<ContactBean> findByNameLikeIgnoreCase(String string);

	List<ContactBean> findByCompanyLikeIgnoreCase(String string);

	

	List<ContactBean> findByMoblieLikeIgnoreCase(String string);

	List<ContactBean> findByPhoneLikeIgnoreCase(String string);

	boolean existsByNameAndCompany(String name, String company);

	List<ContactBean> findByClientid(Integer clientid);

	@Query(value ="SELECT contactid FROM `contact` WHERE name = ?1  ", nativeQuery=true)
	Integer selectIdByname(String name);

	Object findByNameAndCompany(String name, String company);

}
