package com.jetec.CRM.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jetec.CRM.model.TrackBean;

public interface TrackRepository extends JpaRepository<TrackBean, Integer>{

	void deleteByCustomerid(Integer id);

}
