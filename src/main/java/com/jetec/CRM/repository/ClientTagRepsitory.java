package com.jetec.CRM.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.jetec.CRM.model.ClientTagBean;

public interface ClientTagRepsitory extends JpaRepository<ClientTagBean, String>{

	List<ClientTagBean> findByClientid(Integer clientid);

	
	@Query(value = "SELECT  clientid ,name,clienttagid FROM `clienttag` WHERE name= ?1 ", nativeQuery = true)
	List<ClientTagBean> getTagList(String tag);


	boolean existsByClientidAndName(Integer clientid, String tagName);

}
