package com.jetec.CRM.repository;

import com.jetec.CRM.model.BusinessTripBean;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BusinessTripRepository extends JpaRepository<BusinessTripBean,Integer> {
    List<BusinessTripBean> findByTripdayBetween(String toString, String toString1, Sort tripday);
}
