package com.jetec.CRM.repository;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import com.jetec.CRM.model.TrackBean;
import org.springframework.data.jpa.repository.Query;

public interface TrackRepository extends JpaRepository<TrackBean, String>{

	void deleteByCustomerid(String id);

	

	List<TrackBean> findByCustomerid(String customerid, Sort sort);




	@Query(value = "SELECT  DISTINCT(customerid) FROM track  WHERE tracktime BETWEEN ?1 AND ?2", nativeQuery = true)
    List<String> setectTrackTime(String start, String end);

	List<TrackBean> findByCustomeridOrderByTracktimeDesc(String customerid);
}
