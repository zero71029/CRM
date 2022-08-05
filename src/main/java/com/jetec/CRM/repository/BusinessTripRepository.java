package com.jetec.CRM.repository;

import com.jetec.CRM.model.BusinessTripBean;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BusinessTripRepository extends JpaRepository<BusinessTripBean,Integer> {
}
