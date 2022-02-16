package com.jetec.CRM.repository;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import com.jetec.CRM.model.TrackBean;

public interface TrackRepository extends JpaRepository<TrackBean, String>{

	void deleteByCustomerid(String id);

	

	List<TrackBean> findByCustomerid(String customerid, Sort sort);


}
